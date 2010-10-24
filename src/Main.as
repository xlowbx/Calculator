package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	import view.Button;
	import view.Calculator;
	import view.CalculatorView;
	
	public class Main extends Sprite
	{
		private var _bg:Loader;
		public function Main()
		{
			_bg = new Loader();
			var rect:Sprite = new Sprite;
			rect.graphics.beginFill(0xFFFFFF);
			rect.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			rect.graphics.endFill();
			_bg.mask = rect;
			var url:String = "images/christmas.png";
			var urlReq:URLRequest = new URLRequest(url);
			_bg.load(urlReq);
			addChild(_bg);
			
			var addCalcButton:Button = new Button("+CALC",createNewCalc,50,20);
			addChild(addCalcButton);
		}
		private function createNewCalc(str:String):void{
			var view:CalculatorView = new CalculatorView(0x000000 + (0xffffff - 0x000000) *Math.random()); 	
			addChild(view);
			
		}
	}
}