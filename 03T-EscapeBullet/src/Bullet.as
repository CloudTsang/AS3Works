package
{
	import flash.events.Event;
	import flash.geom.Point;

	public class Bullet extends Zidan
	{	
		public var spdx:int;
		public var spdy:int;
        public var P:Point;
		public function Bullet(angleX:int,angleY:int,spdX:int,spdY:int)
		{
			super();
			spdx=spdX;
			spdy=spdY;
			trace(this.x,this.y);
			this.addEventListener(Event.ENTER_FRAME,shoot);
			this.rotation=Math.atan2(angleX,angleY)*180/Math.PI;
		}
		private function shoot(event:Event):void{
			//trace(this.x,this.y);
			this.x+=spdx;
			this.y+=spdy;
		}
		public function clear():Boolean{
 
			if(P.x<10 || P.x>500 || P.y<0 || P.y>600){
	
				this.removeEventListener(Event.ENTER_FRAME,shoot);
				trace("removed")
				return true;
			}
			else {
				return false;
			}
		}
		
	}
}