package view
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;

	public class Calculator extends Sprite
	{
		private var _width:Number = 130;
		private var _height:Number = 200;
		private var _margin:Number = 10;
		private var _printScreen:PrintScreen;
		private var _array:Array;
		private var _bgColor:Number;
		public function Calculator(bgColor:Number)
		{	_bgColor = bgColor;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyBoardInput);
			_array = new Array;
			_array.push("");
			_array.push("");
			_array.push("");
			draw();
			drawTextField();
			drawButtons();
		}
		private function keyBoardInput(e:KeyboardEvent):void{
			trace(e.charCode);
			parseInput(String.fromCharCode(e.charCode));
		}
		private function drawTextField():void{
			_printScreen = new PrintScreen(_width-(_margin*2),_height/7);
			addChild(_printScreen);
			_printScreen.x = _margin;
			_printScreen.y = _margin;
		}
		private function draw():void{
	        this.graphics.beginFill(_bgColor,0.5);
			this.graphics.drawRoundRect(0,0,_width,_height,15);
			this.graphics.endFill();
		}
		private function drawButtons():void{
		
			var buttonGroup:Array = new Array;
		
			for(var i:int = 9, row:int = 0; i > 0; i--, row++){
				
				var aButton:Button = new Button(String(i), parseInput);
				buttonGroup.push(aButton);
				addChild(aButton);
				aButton.x = _margin + ((i%3-1) == -1? 2: (i%3-1)) *(_margin + aButton.width);
				aButton.y = _printScreen.y + (Math.floor(row/3)+1)*(_printScreen.height)+ _margin;
			}
			var zeroButton:Button = new Button("0", parseInput);
			addChild(zeroButton);
			zeroButton.x = _margin + 2 *(_margin + aButton.width);
			zeroButton.y = _printScreen.y + 4 *(_printScreen.height )+ _margin;
			
			var addButton:Button = new Button("+", parseInput);
			addChild(addButton);
			addButton.x = _margin + 3 *(_margin + aButton.width);
			addButton.y = _printScreen.y + 1 *(_printScreen.height )+ _margin;
			
			var subButton:Button = new Button("-" , parseInput);
			addChild(subButton);
			subButton.x = _margin + 3 *(_margin + aButton.width);
			subButton.y = _printScreen.y + 2 *(_printScreen.height )+ _margin;
			
			var mulButton:Button = new Button ("*" , parseInput);
			addChild(mulButton);
			mulButton.x = _margin + 3 *(_margin + aButton.width);
			mulButton.y = _printScreen.y + 3 *(_printScreen.height) + _margin;
			
			var divButton:Button = new Button ("/", parseInput);
			addChild(divButton);
			divButton.x = _margin + 3 *(_margin + aButton.width);
			divButton.y = _printScreen.y + 4 *(_printScreen.height) + _margin;			
			
			var clearButton:Button = new Button ("C", parseInput);
			addChild(clearButton);
			clearButton.x = _margin + 0 *(_margin + aButton.width);
			clearButton.y = _printScreen.y + 4 *(_printScreen.height) + _margin;
			
			var delButton:Button = new Button ("DEL", parseInput);
			addChild(delButton);
			delButton.x = _margin + 1 *(_margin + aButton.width);
			delButton.y = _printScreen.y + 4 *(_printScreen.height) + _margin;
			
			var eqButton:Button = new Button ("=", parseInput);
			addChild(eqButton);
			eqButton.x = _margin + 3 *(_margin + aButton.width);
			eqButton.y = _printScreen.y + 5 *(_printScreen.height) + _margin;						
		}

		public function parseInput(input:String):void{
			var arrayOP:Array = new Array;
			arrayOP.push(new String("-"));
			arrayOP.push(new String("+"));
			arrayOP.push(new String("*"));
			arrayOP.push(new String("/"));
			// If it's a clear button
			if(input == "C"){
				resetArray();
				_printScreen.redraw("INPUT");
			// If it's a del button
			} else if(input == "DEL"){
				if((_array[2] as String).length > 0){
					_array[2] = (_array[2] as String).slice(0,(_array[2] as String).length-1);
					_printScreen.redraw(_array[2]);
				} else if ((_array[0] as String).length > 0){
					_array[0] = (_array[0] as String).slice(0,(_array[0] as String).length-1);
					_printScreen.redraw(_array[0]);
				} 
			// If it's a equal button
			} else if(input == "="){
				var t:String = processOP(_array[0], _array[1], _array[2]); 
				resetArray();
				if(t == "ERROR"){
					_printScreen.redraw(t);
				} else{
					_array[0] = t;
					_printScreen.redraw(_array[0]);
				}
				
			} else{
				// If it's a number
				if(48 <= input.charCodeAt(0) && input.charCodeAt(0) <=57){
					// If first operand already saved
					if((_array[1] as String).length > 0){
						_array[2] += input;
						_printScreen.redraw(_array[2]);	
					// Otherwise save to first operand
					}else{
						_array[0] += input;
						_printScreen.redraw(_array[0]);
					}
				// If it's an operator
				} else if((_array[0] as String).length > 0 ){
					for each(var op:String in arrayOP){
						if (input == op){
							if((_array[2] as String).length > 0){
								var tmpOP:String = input;
								var tmp:String = processOP(_array[0], _array[1], _array[2]); 
								resetArray();
								if(tmp == "ERROR"){
									_printScreen.redraw(tmp);
								} else{
									_array[0] = tmp;
									_array[1] = tmpOP;
									_printScreen.redraw(_array[0]);
								}
							}else {
								_array[1] = op;
								_printScreen.redraw(_array[1]);
							}
						}
					} 
				}
			}
		}
		private function resetArray():void{
			for (var i:int = 0; i < _array.length ; i++){
				_array[i] = "";
			}
		}
		private function processOP(leftOp:String, operator:String, rightOp:String):String{
			switch (operator){
				case "+": 
					return String(Number(leftOp) + Number(rightOp));
					break;
				case "-":
					return String(Number(leftOp) - Number(rightOp));
					break;
				case "*": 
					return String(Number(leftOp) * Number(rightOp));
					break;
				case "/":
					return (String(Number(leftOp) / Number(rightOp)) == "Infinity") || (String(Number(leftOp) / Number(rightOp)) == "-Infinity")? "ERROR": String(Number(leftOp) / Number(rightOp));
					break;
				default:
					return "ERROR";
					break;
			}
		}
	}
}