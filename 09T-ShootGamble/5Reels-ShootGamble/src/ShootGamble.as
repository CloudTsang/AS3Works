package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.text.engine.TextBlock;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	[SWF(width="1380", height="720",  backgroundColor="0xffffff" , frameRate="60")]
	public class ShootGamble extends Sprite
	{
		public var Money:int=5000;
		public var Bet:int=100;
		public var BulletNum:int=1;
		public var CanonNum:int=1;
		public var CanonArr:Array;
		public var FishArr:Array;
		public var Starting:Boolean=false;
		public var HaveFish:Boolean=false;
		public var timer:Timer=new Timer(100);
		public var text1:TextBlank=new TextBlank(30,false,20,10,35,1200,2," ");
		public var text2:TextBlank=new TextBlank(30,false,1000,10,35,100,2," ");
		public function ShootGamble()
		{
						stage.align = StageAlign.TOP_LEFT;
						stage.scaleMode = StageScaleMode.NO_SCALE;
			setTimeout(init,100);
		}
		private function init():void{
			stage.addEventListener(KeyboardEvent.KEY_DOWN,Ctrl);
			RenewTXT();
			SetCanons();
			timer.addEventListener("timer",HitTest1);
		}
		
		public function HitTest1(event:TimerEvent):void{
			if(HaveFish==true){
				for(var l:int=0;l<CanonNum;l++){
					for(var m:int=0;m<FishArr.length;m++){
						HitTest2(CanonArr[l],FishArr[m]);
					}
				}
			}
		}
		public function HitTest2(can:Canon,yu:Fish):void
		{
			for(var a:int=0;a<can.bltArr.length;a++)
			{
				if(can.bltArr[a].hitTestObject(yu)==true)
				{
					can.removeChild(can.bltArr[a]);
					yu.timer.stop();
					yu.y=650;
					Money+=yu.odds;						
					trace("你赢得了",yu.odds,"分!");
					RenewTXT();					
				}
			}
		}
		public function  makeFish():void
		{
			FishArr=new Array;
			var fishNum:int=int(Math.random()*10)+20;
			var yu:Fish;
			var dfct:int;
			for(var k:int=0;k<fishNum;k++){
				dfct=int(Math.random()*11);
				if(dfct==10){
					if(Money<1000){
						yu=new Fish(50);
					}else{
						yu=new Fish(200);
					}
				}else if(dfct<=6){
					if(Money<1000){
						yu=new Fish(200);
					}else{
						yu=new Fish(50);
					}
				}else{
					yu=new Fish(100);
				}
				yu.y=int(Math.random()*100)+100;
				yu.x=int(Math.random()*1000)+1200;
				stage.addChild(yu);
				FishArr.push(yu);
			}
			Money-=Bet;
			HaveFish=true;
		}
		public function SetCanons():void
		{
			CanonArr=new Array;
			CanonArr[0]=new Canon(600,500);
			CanonArr[1]=new Canon(300,500);
			CanonArr[2]=new Canon(900,500);
			CanonArr[3]=new Canon(0,500);
			CanonArr[4]=new Canon(1200,500);
			CanonArr[0].Switch(true);
			for(var j:int=0;j<5;j++)
			{
				addChild(CanonArr[j]);
			}
		}
		public function RenewTXT():void{
			text1.text="钱:"+String(Money)+"  装弹数："+String(BulletNum)+"   炮台数："+String(CanonNum)+"    下注金额："+String(Bet);
			if(Starting==true){
				text2.text="开始中";
			}else{
				text2.text="暂停中";
			}
			addChild(text1);
			addChild(text2);
		}
		public function Ctrl(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.ESCAPE:
				{
					GameOver();
					break;
				}
				case Keyboard.SHIFT:
				{
					if(Starting==true && HaveFish==false){
						//Money-=500;
						makeFish();
						trace("放出了",FishArr.length,"条鱼！");
					} 
					break;
				}
				case Keyboard.ENTER:
				{
					if(Money>=Bet){
						
						Starting=true;
						trace("炮弹已上膛");
						RenewTXT();
						
						makeFish();
					}
					break;
				}
				case Keyboard.SPACE:
				{
					if(Starting==true && BulletNum>=1 && CanonArr[0].ONOFF==true){
						BulletNum-=1;
						RenewTXT();
						for(var n:int=0;n<CanonNum;n++){
							CanonArr[n].Shot();
						}
						timer.start();
						trace("子弹数：",BulletNum);
					}
					break;
				}
					
				case Keyboard.UP:
				{
					if(Starting==false && BulletNum<10){
						Bet+=(CanonNum*100);
						BulletNum+=1;
						
						RenewTXT();
					}					
					break;
				}
				case Keyboard.DOWN:
				{
					if(Starting==false &&　BulletNum>1){
						Bet-=(CanonNum*100);
						BulletNum-=1;
						
						RenewTXT();
					}
					break;
				}
				case Keyboard.LEFT:
				{
					if(Starting==false){
						if(CanonNum>1){
							Bet=BulletNum*(CanonNum-2)*100;
							CanonNum-=2;
							if(CanonNum==3){
								CanonArr[3].Switch(false);
								CanonArr[4].Switch(false);
							}
							else{
								CanonArr[1].Switch(false);
								CanonArr[2].Switch(false);
							}
						}
						RenewTXT();
						
					}
					break;
				}
				case Keyboard.RIGHT:
				{
					if(Starting==false){
						if(CanonNum<5){
							Bet=BulletNum*(CanonNum+2)*100;
							CanonNum+=2;
							if(CanonNum==3){
								CanonArr[1].Switch(true);
								CanonArr[2].Switch(true);
							}
							else{
								CanonArr[3].Switch(true);
								CanonArr[4].Switch(true);
							}
						}
						RenewTXT();
						
					}
					break;
				}
				case Keyboard.NUMBER_0:
				{
					Money=5000;
					RenewTXT();
					break;
				}
			}
		}
		public function GameOver():void
		{
			
			if(Starting==true && HaveFish== true){
				for(var z:int=0;z<FishArr.length;z++){
					if(FishArr[z].stage!=null){
						stage.removeChild(FishArr[z]);
					}
				}
			}
			timer.reset();
			BulletNum=1;
			Bet=CanonNum*100;;
			Starting=false;
			HaveFish=false;
			RenewTXT();
		}
	}
	
}