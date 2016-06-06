package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.sampler.getInvocationCount;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import flashx.textLayout.formats.BackgroundColor;
	
	public class Main extends Sprite
	{
		public var fruit:FruitMc=new FruitMc;
		
		
		public	var a:Bet=new Bet();
		public function Main()
		{
			stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;	
	stage.addEventListener(KeyboardEvent.KEY_DOWN,start);
			
			a.x=500;
			a.y=250;
			addChild(a);
			fruit.x=250
			addChild(fruit);
			a.btn_Str.addEventListener(MouseEvent.CLICK,startBtnHandler);
			a.btn_AutoPlay.addEventListener(MouseEvent.CLICK,autoBtnHandler);
			fruit.addEventListener("gameset",strBtnLock);
		}
		private function strBtnLock(e:Event):void{
		//	a.btn_Str.addEventListener(MouseEvent.CLICK,startBtnHandler);
			a.strBtnEnable(true);
		}
		private function startBtnHandler(e:MouseEvent):void{
			fruit.startGame();
		//	a.btn_Str.removeEventListener(MouseEvent.CLICK,startBtnHandler);
			a.strBtnEnable(false);
		}
		private function autoBtnHandler(e:MouseEvent):void{
			fruit.autoSpin=true;
			fruit.startGame();
		}
		
		public function start(e:KeyboardEvent):void{
			switch(e.keyCode){
				case Keyboard.F:
					fruit.gotoTarget(int(Math.random()*24));
					break;
				case Keyboard.D:
					fruit.mcTarget=int(Math.random()*24);
					fruit.timer.start();
					break;
				case Keyboard.G:
					fruit.startGame();
					break;
			}
		}
	}
}