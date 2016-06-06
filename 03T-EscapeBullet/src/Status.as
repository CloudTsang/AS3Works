package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	public class Status extends Sprite
	{
		//存放角色基本数值
		public var HP:int;
		public var MP:int;
		public var ATK:int;
		public var DEF:int;
		public var SPD:int;
		//public var buffArr:Array=new Array;
		
		//buff=开关boolean+持续时间timer(+画面sprite)
		//中毒
		public var poisonSwitch:Boolean=false;
		private var poisonTimer:Timer=new Timer(1000);
		//护罩
		public var barrierSwitch:Boolean=false;
		private var barrier:Sprite=new Sprite;
		private var barrierTimer:Timer=new Timer(1000);
		//徐徐回复
		public var regenSwitch:Boolean=false;
		private var regenTimer:Timer=new Timer(1000);
		
		
		//private var timer:Timer=new Timer(1000);
		
		public function Status()//这个是角色状态的类
		{
			drawCircle(barrier,0xff0000,0.8,60,0,0,false);		
			poisonTimer.addEventListener("timer",poisonHandler);
			barrierTimer.addEventListener("timer",barrierHandler);
			regenTimer.addEventListener("timer",regenHandler);
		}
		
			//设定角色数值
		public function SetStatus(hp:int,mp:int,atk:int,def:int,spd:int):void
		{
			HP=hp;
			MP=mp;
			ATK=atk;
			DEF=def;
			SPD=spd;
		}
		
		public function MakeBuff(buff:String,buffRptCnt:int=1):void {
			switch(buff){
				case "poison":
					poisonTimer.repeatCount=10;
					poisonTimer.start();
				case "barrier":
					barrierTimer.repeatCount=10;
					barrierTimer.start();
					break;
				case "regen":					
					regenTimer.repeatCount=5;
					regenTimer.start();
					break;
				
			}
		}
		
		//中毒debuff处理
		private function poisonHandler(event:TimerEvent):void{
			if(poisonTimer.currentCount==1){
				poisonSwitch=true;
			}
			else if(poisonTimer.currentCount==poisonTimer.repeatCount){
				poisonSwitch=false;
				poisonTimer.reset()
			}
			HP=HP-HP*0.1;
			trace("HP:  "+HP);
		}
		
		//护罩buff处理
		private function barrierHandler(event:TimerEvent):void{
			if(barrierTimer.currentCount==1){
				barrierSwitch=true;
				this.addChild(barrier);
			}
			else if(barrierTimer.currentCount==barrierTimer.repeatCount){
				barrierSwitch=false;
				barrierTimer.reset();
				this.removeChild(barrier);
			}
		}
		
		//徐徐回复buff处理
		private function regenHandler(event:TimerEvent):void
		{
			if(regenTimer.currentCount==1){
				regenSwitch=true;
			}
			else if(regenTimer.currentCount==regenTimer.repeatCount){
				regenTimer.reset();
				regenSwitch=false;
			}
			HP=HP+10;
			trace("HP:  "+HP);
		}
		
		private function drawCircle(sth:Sprite,color:uint,alp:Number,rad:int,x:int,y:int,fill:Boolean):void{
			if(fill==true){
				sth.graphics.beginFill(color);
			}
			sth.graphics.lineStyle(1,0x000000);
			sth.alpha=alp;
			sth.graphics.drawCircle(x,y,rad);
		}
	}
}