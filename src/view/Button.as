package view
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import flashx.textLayout.formats.TextAlign;

	public class Button extends Sprite
	{
		private var _textField:TextField; 
		private var _label:String;
		private var _width:Number;
		private var _height:Number;
		private var _textColor:Number;
		private var _onPrint:Function;
		public function Button(label:String = "???", onPrint:Function = null, width:Number = 20, height:Number = 20, textColor:Number = 0xffffff)
		{
			_label = label;
			_width = width;
			_height = height;
			_textColor = textColor;
			_onPrint = onPrint;
			addEventListener(Event.ADDED_TO_STAGE,init);
			
		}
		
		private function init(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(MouseEvent.ROLL_OVER, rOver);
			addEventListener(MouseEvent.ROLL_OUT, rOut);
			draw();
		}
		private function rOver(e:MouseEvent):void{
			this.alpha = 0.25;
		}
		private function rOut(e:MouseEvent):void{
			this.alpha = 1;
		}
		private function onClick(e:MouseEvent):void{
			if (_onPrint != null){
				_onPrint(_label);
			}
		}
		private function draw():void{
			this.graphics.beginFill(0x000000,1);
			this.graphics.drawRoundRect(0,0,_width,_height,15);
			this.graphics.endFill();
		
		 
			var format:TextFormat = new TextFormat;
			format.align = TextAlign.CENTER;
			_textField = new TextField;
			_textField.width = _width;
			_textField.height = _height;
			_textField.text = _label;
			_textField.textColor = 0xffffff;
			_textField.setTextFormat(format);
			addChild(_textField);
			
			this.mouseChildren = false;
			this.mouseEnabled = true;
			this.buttonMode = true;		
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
	}
}