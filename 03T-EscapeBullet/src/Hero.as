package 
{
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	public class Hero extends Sprite
	{
		//移动用timer
		public var timer:Timer=new Timer(10);
		//主角图形
		public var hero:Sprite=new Sprite;
        public var heroPlace:Sprite=new Sprite;
		//主角状态
		public var status:Status=new Status;
		
		public var moveanalog:Analog=new Analog;
		public var spinanalog:Analog=new Analog;
		
		public var angleX:Number;
		public var angleY:Number;
		
		public var heroGun:Gun=new Gun;
		public var GunTimer:Timer;
		private var border:Movelimit=new Movelimit;
		
		public function Hero()
		{
			super();
			
			//设定初始状态
			status.SetStatus(100,100,30,30,20);	
//			GunTimer=new Timer(status.SPD*100);
//			GunTimer.addEventListener("timer",ShotGun);
//			GunTimer.start();
			hero=drawCircle(0x000000,1,40,0,0,true);	
			heroPlace=drawCircle(0x000000,1,40,0,0,false);
			hero.x=300;
			hero.y=200;
			heroGun.x=hero.x;
			heroGun.y=hero.y;
			hero.addChild(status);
			hero.addChild(drawCircle(0xffffff,1,5,30,0,true));
			heroPlace.addChild(heroGun);
			heroPlace.addChild(hero);
			
			timer.addEventListener("timer",Move);
			timer.start();
		}
		
		public function ifDrag(drag:Boolean,which:Analog):void{
			which.Drag(drag);			
		}
		
		public function ShotGun(event:TimerEvent):void{
			heroGun.Shoot();
		}
		
		//获得buff的函数
		public function GetBuff(BuffType:String):void
		{
			switch(BuffType)
			{
				case "poison":
					status.MakeBuff(BuffType);
					break;
				case "barrier":
					status.MakeBuff(BuffType);
					break;
				case "regen":
					status.MakeBuff(BuffType);
					break;
			}
		}
		
		//移动函数
		private function Move(event:TimerEvent):void
		{

			if(hero.x<border.Left)
			{
				hero.x=hero.x+10;
				hero.y=(hero.y+(moveanalog.anlCtrl.y)/status.SPD);
			}else if(hero.x+hero.width+10>border.Right){
				hero.x=hero.x-10;
				hero.y=(hero.y+(moveanalog.anlCtrl.y)/status.SPD);
			}
			else if(hero.y+hero.height+10>border.Down){
				hero.x=(hero.x+(moveanalog.anlCtrl.x)/status.SPD);
				hero.y=hero.y-10;
			}
			else if(hero.y-10<border.Up){
				hero.y=hero.y+10;
				hero.x=(hero.x+(moveanalog.anlCtrl.x)/status.SPD);
			}
			else{
				hero.x=(hero.x+(moveanalog.anlCtrl.x)/status.SPD);
				hero.y=(hero.y+(moveanalog.anlCtrl.y)/status.SPD);
				heroGun.x=hero.x;
				heroGun.y=hero.y;
			}
			if(spinanalog.stage!=null && spinanalog.anlCtrl.x!=0 && spinanalog.anlCtrl.y!=0){
				angleX=spinanalog.anlCtrl.x;
				angleY=spinanalog.anlCtrl.y;
				hero.rotation=(Math.atan2(angleY,angleX)*180)/Math.PI;
			}
		}
		
		
		private function drawCircle(color:uint,alp:Number,rad:int,x:int,y:int,fill:Boolean):Sprite{
			var sth:Sprite=new Sprite;
			if(fill==true){
				sth.graphics.beginFill(color);
			}
			sth.graphics.lineStyle(0,0,0);
			sth.alpha=alp;
			sth.graphics.drawCircle(x,y,rad);
			return sth;
		}
		
	}
}