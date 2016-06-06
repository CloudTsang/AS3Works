package
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Fish extends Sprite
	{
		public var timer:Timer=new Timer(10);
		public var spd:Number;
		public var odds:int;
	    
		public function Fish(type:int)
		{
			super();
			this.graphics.lineStyle(0,0x000000,0);
			switch(type)
			{
				case 0:
				{
					this.graphics.beginFill(0x0000ff);
					spd=20;
					break;
				}
				case 1:
				{
					this.graphics.beginFill(0xcc00cc);
					spd=18;
					break;
				}
				case 2:
				{
					this.graphics.beginFill(0x33ccff);
					spd=16;
					break;
				}
					
					
				case 3:
				{
					this.graphics.beginFill(0x0ff000);
					spd=14;
					break;
				}
					
				case 4:
				{
					this.graphics.beginFill(0x000066);
					
					spd=12;
					break;
				}
					
				case 5:
				{
					this.graphics.beginFill(0xcc9933);
					spd=10;
					
					break;
				}
				case 6:
				{
					this.graphics.beginFill(0xcc0000);
					spd=8;
					break;
				}
				case 7:
				{
					this.graphics.beginFill(0xffff00);
					spd=6;
					break;
				}
					
			}
			odds=(type+0.5)/2;
			this.graphics.drawRect(0,0,80,40);
			timer.addEventListener("timer",Swim);
			//timer.start();
			TweenLite.to(this,spd,{x:-200});			
		}
		
		public function Swim(event:TimerEvent):void{
			this.x-=spd;
			if(this.x<-250){
				timer.stop();
			}
		}
	}
}