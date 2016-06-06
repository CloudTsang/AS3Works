package 
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Soldier extends Sprite
	{
		public var timer:Timer=new Timer(100);
		public var status:Status=new Status;
		public var rotaX:int;
		public var rotaY:int;		
		
		private var DirectionX:int=0;// -1,0,1;
		private var DirectionY:int=0;
		
		private var border:Movelimit=new Movelimit;
		
		public function Soldier()
		{
			super();
					
			this.addChild(drawCircle(0xFF0000,1,40,0,0,true));
			this.addChild(drawCircle(0xffffff,1,5,30,0,true));
			
			timer.addEventListener("timer",Move);
			timer.start();
		}
		
		private function Move(event:TimerEvent):void
		{
			if(timer.currentCount%100==0){
				
			}

			this.x+=DirectionX*status.SPD;
			this.y+=DirectionY*status.SPD;
			
		}
		private function randirect():int{
			var a:int=int(Math.random()*2);
			if(a==1){
				return -1;
			}else{
				return 1;
			}			
		}
		public function turn180():void{
			 DirectionX=0-DirectionX;
			 DirectionY=0-DirectionY;
		}
		public function turn90():void{
			DirectionX=1-Math.abs(DirectionX);
			DirectionY=1-Math.abs(DirectionY);
		}
		private function drawCircle(color:uint,alp:Number,rad:int,x:int,y:int,fill:Boolean):Sprite{
		    var sth:Sprite=new Sprite;
			if(fill==true){
				sth.graphics.beginFill(color);
			}
			sth.graphics.lineStyle(1,0x000000);
			sth.alpha=alp;
			sth.graphics.drawCircle(x,y,rad);
			return sth;
		}
	}
}