package
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Fish extends Sprite
	{
		public var timer:Timer=new Timer(10);
		public var spd:int;
		public var odds:int;
		public function Fish(rare:int)
		{
			super();
			this.graphics.lineStyle(0,0x000000,0);
			switch(rare)
			{
				case 50:
				{
					this.graphics.beginFill(0xff0000);
					spd=1;
					odds=rare;
					break;
				}
					
				case 100:
				{
					this.graphics.beginFill(0x00ff00);
					odds=rare;
					spd=3;
					break;
				}
					
				case 200:
				{
					this.graphics.beginFill(0xffff00);
					spd=5;
					odds=rare;
					break;
				}
			}
			this.graphics.drawRect(0,0,80,40);
			timer.addEventListener("timer",Swim);
			timer.start();
		}
		
		public function Swim(event:TimerEvent):void{
			this.x-=spd;
			if(this.x<-250){
				timer.stop();
			}
		}
	}
}