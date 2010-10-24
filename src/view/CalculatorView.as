package view
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	public class CalculatorView extends Sprite
	{
		private var calculator:Calculator;
		private var _bgColor:Number;
		public function CalculatorView(bgColor:Number)
		{	_bgColor = bgColor;
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			draw();
		}

		private function draw():void{
			calculator = new Calculator(_bgColor);
			calculator.x = 100;
			calculator.y = 100;
			addChild(calculator);

			calculator.addEventListener(MouseEvent.MOUSE_DOWN, dragIt);
			calculator.addEventListener(MouseEvent.MOUSE_UP, dropIt);
		}
		private function dragIt(e:MouseEvent):void{
			calculator.startDrag();
		}
		private function dropIt(e:MouseEvent):void{
			calculator.stopDrag();
		}

	}
}