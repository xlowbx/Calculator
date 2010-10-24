package view
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import flashx.textLayout.formats.TextAlign;

	public class PrintScreen extends Sprite
	{
		private var _textField:TextField;
		private var _width:Number;
		private var _height:Number;
		private var _format:TextFormat;
		public function PrintScreen(width:Number = 100, height:Number = 100)
		{
			_width = width;
			_height = height;
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			drawBox();
			drawTextField();
			
		}
		private function drawBox():void{
			this.graphics.beginFill(0x000000,0.8);
			this.graphics.drawRoundRect(0,0,_width,_height,15);
			this.graphics.endFill();
		}
		private function drawTextField():void{
			_textField = new TextField;
			_format = new TextFormat;
			_format.align = TextAlign.RIGHT;
			_format.color = 0xffffff;
			_textField.width = _width;
			_textField.height = _height;
			_textField.textColor = 0xffffff;
			_textField.defaultTextFormat= _format;
			_textField.text = "INPUT";
			addChild(_textField);
			
		}
		public function redraw(str:String):void{
			_textField.text = str;
		}
	}
}