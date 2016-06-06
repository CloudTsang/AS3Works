package
{
	import com.greensock.TweenLite;
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Timer;

	public class Bullet extends ZiDan
	{
		public var P:Point;
		public function Bullet()
		{
			super();
			//this.addEventListener(Event.ENTER_FRAME,shoot);
			TweenLite.to(this,5,{y:-1000});
		}
		
	}
}