package himmae.observer
{
	import himmae.observer.Subject2;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class TimeCount extends Subject2
	{
		public var timer:Timer;
		public function TimeCount(t:int=60)
		{
			super();
			_param=t;
			timer=new Timer(1000 , t);
			timer.addEventListener(TimerEvent.TIMER , timerHandler);
//			timer.start();
		}
		
		private function timerHandler(e:TimerEvent):void{
			_param--;
			callObserver();
		}
		
		public override function set param(p:*):void{
			timer.repeatCount=p;
		}
	}
}