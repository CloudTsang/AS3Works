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
	public class ShootGamble2 extends Sprite
	{
		public var Money:Number=5000;
		public var Bet:Number=0;
		public var BulletNum:int=1;
		public var CanonNum:int=5;
		public var CanonArr:Array;
		public var FishArr:Array;
		public var Starting:Boolean=false;
		public var HaveFish:Boolean=false;
		public var timer:Timer=new Timer(100);
		public var text1:TextBlank=new TextBlank(30,false,20,10,35,1200,2," ");
		public var text2:TextBlank=new TextBlank(30,false,1000,10,35,100,2," ");
		public var text3:TextBlank=new TextBlank(30,false,180,640,35,1200,2," ");
		public var BetFish:BottomBet=new BottomBet;
		public var BetArr:Array=new Array(0,0,0,0,0,0,0,0);
		public var BetNumberTXT:MCnum=new MCnum;
		public var BetNumber:Array=new Array(1,5,10,20,50);
		public var Xnumber:int=1;
		public function ShootGamble2()
		{
			setTimeout(init,100);
		}
		
		private function init():void{
			stage.addEventListener(KeyboardEvent.KEY_DOWN,Ctrl);
			RenewTXT();
			SetCanons();
			timer.addEventListener("timer",HitTest1);
			BetFish.x=150;
			BetFish.y=600;
			addChild(BetFish);
			BetNumberTXT.x=0;
			BetNumberTXT.y=630;
			addChild(BetNumberTXT);			
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
					//yu.timer.stop();
					yu.y=850;
					Money+=BetArr[yu.odds]*(yu.odds+1);						
					RenewTXT();					
				}
			}
		}
		public function  makeFish():void
		{
			FishArr=new Array;
			var fishNum:int=int(Math.random()*25)+5;
			var yu:Fish;
			var dfct:int;
			for(var k:int=0;k<fishNum;k++){
				dfct=int(Math.random()*8);
				yu=new Fish(dfct);
				yu.y=int(Math.random()*100)+100;
				yu.x=int(Math.random()*1000)+1200;
				stage.addChild(yu);
				FishArr.push(yu);
				
			}
			HaveFish=true;
		}
		public function SetCanons():void
		{
			CanonArr=new Array;
			
			CanonArr[0]=new Canon(600,450);
			CanonArr[1]=new Canon(300,450);
			CanonArr[2]=new Canon(900,450);
			CanonArr[3]=new Canon(0,450);
			CanonArr[4]=new Canon(1200,450);
			for(var j:int=0;j<5;j++)
			{
				addChild(CanonArr[j]);
			}
		}
		public function RenewTXT():void{
			text1.text="钱:"+String(Money)+"  装弹数："+String(BulletNum)+"    下注金额："+String(Bet);
			if(Starting==true){
				text2.text="开始中";
			}else{
				text2.text="暂停中";
			}
			text3.text=BetArr[0]+"            "+BetArr[1]+"            "+BetArr[2]+"            "+BetArr[3]+"            "+BetArr[4]+"            "+BetArr[5]+"            "+BetArr[6]+"            "+BetArr[7];
			addChild(text1);
			addChild(text2);
			addChild(text3);
		}
		public function Ctrl(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.ESCAPE:					
					GameOver();
					break;				
//				case Keyboard.SHIFT:				
//					if(Starting==true && HaveFish==false){
//						makeFish();
//						trace("放出了",FishArr.length,"条鱼！");
//					} 
//					break;
				case Keyboard.PAGE_UP:
					if(Starting==false && BulletNum<5){
                        Bet=Bet/BulletNum*(BulletNum+1);
						BulletNum+=1;
						RenewTXT();						
					}			
					break;
				case Keyboard.PAGE_DOWN:
					if(Starting==false && BulletNum>1){
						Bet=Bet/BulletNum*(BulletNum-1);
						BulletNum-=1;
						RenewTXT();						
					}	
					break;
				
				case Keyboard.ENTER:
					if(Bet>0 && Money>=Bet ){						
						Starting=true;
						makeFish();
						Money-=Bet;
						RenewTXT();
					}
					break;
				
				case Keyboard.SPACE:
					if(Starting==true && BulletNum>=1){
						BulletNum-=1;
						RenewTXT();
						for(var n:int=0;n<CanonNum;n++){
							CanonArr[n].Shot();
						}
						timer.start();
					}
					break;
				
				case Keyboard.UP:
					if(Starting==false && BetNumberTXT.fps<5){			
						BetNumberTXT.fps+=1;
						BetNumberTXT.gotoAndStop(BetNumberTXT.fps);					
					}					
					break;
				
				case Keyboard.DOWN:
					if(Starting==false &&　BetNumberTXT.fps>1){
						BetNumberTXT.fps-=1;
						BetNumberTXT.gotoAndStop(BetNumberTXT.fps);				
						RenewTXT();
					}
					break;
				case Keyboard.NUMBER_1:
					BetArr[0]+=BetNumber[BetNumberTXT.fps-1];
					Bet+=BetNumber[BetNumberTXT.fps-1]*BulletNum;
					RenewTXT();
					break;
				case Keyboard.NUMBER_2:
					BetArr[1]+=BetNumber[BetNumberTXT.fps-1];
					Bet+=BetNumber[BetNumberTXT.fps-1]*BulletNum;
					RenewTXT();
					break;
				case Keyboard.NUMBER_3:
					BetArr[2]+=BetNumber[BetNumberTXT.fps-1];
					Bet+=BetNumber[BetNumberTXT.fps-1]*BulletNum;
					RenewTXT();
					break;
				case Keyboard.NUMBER_4:
					BetArr[3]+=BetNumber[BetNumberTXT.fps-1];
					Bet+=BetNumber[BetNumberTXT.fps-1]*BulletNum;
					RenewTXT();
					break;
				case Keyboard.NUMBER_5:
					BetArr[4]+=BetNumber[BetNumberTXT.fps-1];
					Bet+=BetNumber[BetNumberTXT.fps-1]*BulletNum;
					RenewTXT();
					break;
				case Keyboard.NUMBER_6:
					BetArr[5]+=BetNumber[BetNumberTXT.fps-1];
					Bet+=BetNumber[BetNumberTXT.fps-1]*BulletNum;
					RenewTXT();
					break;
				case Keyboard.NUMBER_7:
					BetArr[6]+=BetNumber[BetNumberTXT.fps-1];
					Bet+=BetNumber[BetNumberTXT.fps-1]*BulletNum;
					RenewTXT();
					break;
				case Keyboard.NUMBER_8:
					BetArr[7]+=BetNumber[BetNumberTXT.fps-1];
					Bet+=BetNumber[BetNumberTXT.fps-1]*BulletNum;
					RenewTXT();
					break;
				
//				case Keyboard.NUMBER_0:
//					
//					Money=5000;
//					RenewTXT();
//					break;
				
				//				case Keyboard.LEFT:
				//				
				//					if(Starting==false){
				//						if(CanonNum>1){
				//							Bet=BulletNum*(CanonNum-2)*100;
				//							CanonNum-=2;
				//							if(CanonNum==3){
				//								CanonArr[3].Switch(false);
				//								CanonArr[4].Switch(false);
				//							}
				//							else{
				//								CanonArr[1].Switch(false);
				//								CanonArr[2].Switch(false);
				//							}
				//						}
				//						RenewTXT();
				//					}
				//					break;
				//				
				//				case Keyboard.RIGHT:
				//				
				//					if(Starting==false){
				//						if(CanonNum<5){
				//							Bet=BulletNum*(CanonNum+2)*100;
				//							CanonNum+=2;
				//							if(CanonNum==3){
				//								CanonArr[1].Switch(true);
				//								CanonArr[2].Switch(true);
				//							}
				//							else{
				//								CanonArr[3].Switch(true);
				//								CanonArr[4].Switch(true);
				//							}
				//						}
				//						RenewTXT();
				//						
				//					}
				//					break;
				//				
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
			Bet=0;
			BetArr.splice(0,7,0,0,0,0,0,0,0,0);
			Starting=false;
			HaveFish=false;
			RenewTXT();
		}
	}
	
}