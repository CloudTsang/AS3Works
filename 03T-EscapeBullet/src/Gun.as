package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;

	public class Gun extends Sprite
	{
		private var timer:Timer=new Timer(1000);
		public var bltARR:Array=new Array;
		public var bullet:Bullet
		public function Gun()
		{
			timer.addEventListener("timer",BulletTest);
			timer.start();
		}
		public function Shoot():void
		{
			bullet=new Bullet(0,0,10,0);
			bullet.P=localToGlobal(new Point(bullet.x,bullet.y));
			this.addChild(bullet);
			bltARR.push(bullet);
			//trace(bltARR[0].x);
		}
		private function BulletTest(evt:TimerEvent):void
		{
			for(var i:int=0;i<bltARR.length;i++){
				if(BorderTest(bltARR[i])==true){			
					this.removeChild(bltARR[i]);
					bltARR.splice(i,1);
				}
			}
			//trace(i);
		}
		private function BorderTest(blt:Bullet):Boolean{
			
			trace(blt.P);
			var a:Boolean=blt.clear();
			
			if(a==true){
				return true;
			}else{
				return false;
			}

		}
	}
}