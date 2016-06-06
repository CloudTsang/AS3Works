package
{
	import com.greensock.TweenLite;
	import com.greensock.plugins.Physics2DPlugin;
	import com.greensock.plugins.PhysicsPropsPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.plugins.VolumePlugin;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.PressAndTapGestureEvent;
	import flash.events.TimerEvent;
	import flash.sampler.getLexicalScopes;
	import flash.text.ReturnKeyLabel;
	import flash.text.TextField;
	import flash.text.engine.TextBaseline;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import flashx.textLayout.factory.StringTextLineFactory;
	
	[SWF(width="1380", height="720",  backgroundColor="0xffffff" , frameRate="60")]
	public class ShonenJumpSlot extends Sprite
	{
		
		/** 按钮集合 **/
		public var btns:Buttons=new Buttons;
		/** 兑奖线集合 **/
		public var lineArr:Lines=new Lines;
		/** 五个转轮集合 **/
		public var slotReels:ReelPad=new ReelPad;
		/** 现有总金额 **/
		public var Money:Number;
		/** 自动旋转次数 **/
		public var Auto:uint=0;
		/**免费自动旋转次数**/
		public var freeAuto:uint=0;
		/**计费自动旋转次数**/
		public var payAuto:int=0;
		/**自动旋转timer**/
		private var autoTimer:Timer=new Timer(10);
//		/** 游戏是否正在进行 **/
//		private var isStart:Boolean=false;
		/** 转轮赢奖 **/
		private var Prize:Number;
		/**免费游戏赢奖总金额**/
		private var FreePrize:Number;
		/** 赌博赢奖，在自动旋转时是总的赢奖金额 * */	
		private var GamblePrize:Number;
		/**储存中奖线编号的数组**/
		private var tmpArr:Array=new Array;
		/**总赌注金额**/
		public var Bet:Number=20;
		/**赢奖效果**/
		public var pEffect:PrizeEffect=new PrizeEffect;		
		
		private var BetText:TextBlank=new TextBlank(true,1200,300,50,150,"0",35);	
		public var moneyText:TextBlank=new TextBlank(true,1200,200,50,150,"0",35);
		public var autoText:TextBlank=new TextBlank(true,1200,400,50,150,"0",35);
		public var freeAutoText:TextBlank=new TextBlank(true,1200,500,50,150,"0",35);
		
		public function ShonenJumpSlot()
		{		
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;	
			Init();	
//			setTimeout(Init , 500);
		}
		
		/**
		 * 开始按键的处理事件。
		 * 单次游戏按下按钮时会将各种Prize置0
		 * */
		public function startBtnHandler(event:MouseEvent):void{
			//Prize=0; 	
			GamblePrize=0;
			FreePrize=0;
			
			btns.Gamble.visible=false;			
			btns.BetLock(true);
			pEffect.clear();
			if(Buttons.Start.McPress.currentFrame==1){
				strSpin();
			}else{
				endSpin();
			}
			Buttons.Start.btnBlockSwitch();
//			isStart=!isStart;
//			if(isStart==true){
//				strSpin();				
//			}else{
//				endSpin();			
//			}		
			BGM.BgmStop("win");
		}	
		
		/**开始旋转**/
		private function strSpin():void{
			//将之前显示为“show”的兑奖线按键重置
			lineArr.setLines(tmpArr,"normal");		
			slotReels.gameCtrl(true);	
			if(freeAuto==0){
				Money-=Bet;	
			}			
			moneyText.text=String(Money);
		}
		/**停止旋转，在3000ms后执行标记检测函数**/
		private function endSpin():void{
			slotReels.gameCtrl(false);
	//		setTimeout(marksDetect,3000);
		}
		
		/**检测中奖标记**/
		public function marksDetect(e:Event):void{
			var tmpObj:Object; 
			var tmpFree:int=0;			
			tmpArr=new Array;
			Prize=0;
			
			for(var k:int=0;k<btns.getLine();k++){
				//将兑奖线分割为5个号码
				tmpObj=slotReels.markDetect(lineArr.getMark(k).split(/ /));	
				
				lineArr.setCountPrize(k,  tmpObj.Count ,  tmpObj.revCount ,  tmpObj.Odd*btns.getLineBet()+tmpObj.revOdd*btns.getLineBet());				
				if(tmpObj.Count>=3 || tmpObj.revCount>=3){							
				trace(lineArr.getLineData(k));		
					Prize +=lineArr.getPrize(k);
					tmpArr.push(k);  //当这条线的中奖标记数大于3时，记录下编号
				}	
			}
			lineArr.setLines(tmpArr,"prize"); //令中奖的线按钮显示
			Money+=Prize;     //总金额增加赢奖
			moneyText.text=String(Money);	
			//免费游戏检测
			tmpFree = slotReels.freeDetect();
			freeAuto += tmpFree;	
			Auto+=tmpFree;
			freeAutoText.text=String(freeAuto);	
			autoText.text=String(Auto);		
			
			if(Buttons.Start.visible==false){
				FreePrize+=Prize
			}else{
				GamblePrize+=Prize;
			}
			gameSetHandler();							
		}
		
		private function gameSetHandler():void
		{
			//进入免费游戏
			if(freeAuto>0 && Buttons.Start.visible==true){
				Buttons.Start.visible=false;
				btns.EscFree.visible=false;
				autoTimer.reset();
				BGM.BgmStop("ambient");
				BGM.BgmPlay("fgstart");
				setTimeout(autoSpinStart,5000);
				return;	
			}	
			//  自动旋转结束时                      免费游戏结束时
			if((Auto==0 || (freeAuto==0 && Buttons.Start.visible==false) ) && autoTimer.running==true){
				//直接进入下一次autoTimer函数结束自动旋转
				autoTimer.delay=10;
				return;
			}
			//自动旋转中什么都不做
			if(autoTimer.running==true){
				return;
			}
			
			btns.Gamble.setMoney(GamblePrize+FreePrize);//设置赌金
			btns.Gamble.visible=Boolean(btns.Gamble.Money); 
			btns.BetLock(false);
			//免费游戏什么都不做
			if(Buttons.Start.visible==false){
				return;
			}
			var s:int=int(GamblePrize/Bet);			
			if(s==0){
				return;
			}else if(s<=40){
			pEffect.winEffect(GamblePrize,25);
				BGM.BgmPlay("smallwin");
			}else if(s<=100){
				pEffect.winEffect(GamblePrize,25);
				BGM.BgmPlay("midwin");
			}else{
				pEffect.winEffect(GamblePrize,25);
				BGM.BgmPlay("bigwin");
			}
		}
		
		/**自动旋转函数**/
		public function AutoSpin(event:TimerEvent):void{								
			if(freeAuto==0 && Buttons.Start.visible==false){
				autoTimer.reset();
				if(FreePrize>0){
					BGM.BgmStop("ambient");				
					BGM.BgmPlay("fgend");
					if(Auto==0){
						//免费游戏结束后仍然继续自动旋转是赢奖牌子只显示免费游戏期间的赢奖，否则显示整次游戏的赢奖
						pEffect.winEffect(GamblePrize+FreePrize,100);
					}else{
						pEffect.winEffect(FreePrize,100);
					}
					setTimeout(autoSpinEnd,7000);
				}else{
					setTimeout(autoSpinEnd,3000);
				}
				return;
			}
			if(Auto==0){
				autoTimer.reset();
				autoSpinEnd();
				gameSetHandler();
				return;
			}			
			if(autoTimer.currentCount==1){
				autoTimer.delay=5000;			
			}
			
			strSpin();	
			setTimeout(endSpin,1000);							
			if(freeAuto>0){
				freeAuto--;
			}
			Auto--;				
		}
		
		/**开始自动旋转函数	 **/
		private function autoSpinStart():void{		
			if(freeAuto>0){
				//免费游戏时
				BGM.BgmPlay("free game");
			}else{
				Auto+=btns.getAuto();
				autoText.text=String(Auto);
			}			
			autoTimer.delay=10;
			autoTimer.start();			
		}
		/**结束自动旋转函数
		 * 	 
		 * 退出免费游戏到普通游戏、
		 * 退出免费游戏到自动旋转、
		 * 退出自动旋转、
		 * 自动旋转最后一次出现免费游戏、
		 * 免费游戏最后一次出现免费游戏**/
		private function autoSpinEnd():void{					
			if(Buttons.Start.visible==false){
				pEffect.clear();
				BGM.BgmStop("ambient");
				BGM.BgmStop("win");
				if(Auto>0){
					//免费游戏到普通自动旋转
					btns.EscFree.visible=true;
					autoTimer.delay=10;
					autoTimer.start();	
				}
				else{
					//免费游戏到普通游戏
					gameSetHandler();
				}
				Buttons.Start.visible=true;
				BGM.BgmPlay("normal");
				FreePrize=0;
				return;
			}		
			BGM.BgmPlay("normal");
			btns.EscFree.visible=false;
		}
		
		/**自动旋转按钮处理函数**/
		private function AutoBtnHandler(event:MouseEvent):void{
			Prize=0;
			FreePrize=0;
			GamblePrize=0;
			btns.Gamble.setMoney(0);
			btns.Gamble.visible=false;
			btns.EscFree.visible=true;		
			Buttons.Start.btnBlockSwitch();
			setTimeout(autoSpinStart,10);
			pEffect.clear();
			btns.BetLock(true);
		}
		/**开始自动旋转之后出现的“退出”按钮处理函数**/
		private function autoEscBtnHandler(event:MouseEvent):void{
			autoSpinEnd();
			btns.resetAuto();
			Buttons.Start.btnBlockSwitch();
			Auto=0;
			payAuto=0;
			autoText.text="0";
		}
		
		/**
		 * 赌博按键处理函数
		 * 标记检测后的赢奖会立即加到总金额上。
		 * 赌博赢奖则在退出赌博时加到总金额上，
		 * 退出→再进入赌博→输光时，退出赌博后全部扣除。
		 * */
		private function gambleHandler(event:MouseEvent):void{
			pEffect.clear();
			var tmp:Number=GamblePrize+FreePrize
			if(btns.Gamble.Money==0){	
				//赌输
				Money-=tmp;
				btns.Gamble.visible=false;
			}
			else if(tmp==btns.Gamble.Money){
				//当赌本=赌博赢奖时（进入赌博后直接退出时）什么都不做
			}
			else{
				//赌赢
				tmp=btns.Gamble.Money;
				Money=Money+tmp-GamblePrize-FreePrize;
			}
			trace("赌本:   "+btns.Gamble.Money);
			trace("总金额：  "+Money);
			moneyText.text=String(Money);
		}
		
		/**设置赌注相关按钮的处理事件**/
		private function betBtnsMouseHandler(e:MouseEvent):void{
			setTimeout(betChange,50);
		}
		/**赌注变更处理函数**/
		private function betChange():void{
			Bet=btns.getBet()*ReelPad.isDuo;
			BetText.text=String(Bet);
		}
		
		/**初始化函数**/
		public function Init():void{
			removeChildren();
			Money=5000;
			Prize=0;			
			FreePrize=0;
			GamblePrize=0;
			Auto=0;
			freeAuto=0;
			payAuto=0;
			Bet=20;
			
			BetText.text="20";
			addChild(BetText);			
			moneyText.text=String(Money);
			addChild(moneyText);
			autoText.text="0";
			addChild(autoText);
			freeAutoText.text="0";
			addChild(freeAutoText);
			
			addChild(new TextBlank(false,1200,170,500,150,"总金额\n\n\n赌注\n\n\n\n自动旋转回数\n\n\n免费游戏回数",25));		
			
			autoTimer.addEventListener("timer",AutoSpin);
			
			slotReels.addEventListener("Finish_Rolling",marksDetect);
			addChild(slotReels);
			addChild(lineArr.linesBtn);
			lineArr.setLine(20);
			
			Buttons.Start.McPress.addEventListener(MouseEvent.CLICK,startBtnHandler);
			btns.EscFree.addEventListener(MouseEvent.CLICK,autoEscBtnHandler);	
			btns.Gamble.McGamBtn.addEventListener(MouseEvent.CLICK,gambleHandler);	
			btns.AutoSpin.MCbtnASMenu.addEventListener(MouseEvent.CLICK,AutoBtnHandler);
			btns.Rate.addEventListener(MouseEvent.CLICK,betBtnsMouseHandler);
			btns.Line.addEventListener(MouseEvent.CLICK,betBtnsMouseHandler);
			btns.oneBet.addEventListener(MouseEvent.CLICK,betBtnsMouseHandler);
			btns.Duo.addEventListener(MouseEvent.CLICK,betBtnsMouseHandler);
			
			addChild(btns);					
			addChild(pEffect);
			TweenPlugin.activate([VolumePlugin]);
			BGM.Init()
			BGM.BgmPlay("normal");
		}		
	}
}