package
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.dns.AAAARecord;
	import flash.sampler.NewObjectSample;
	import flash.sampler.getMemberNames;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	import flash.utils.setTimeout;
	
	import org.osmf.events.TimeEvent;
	
	public class FruitMc extends McPanel
	{
		/**全部标记的数组**/
		public var McArr:Vector.<Mc>=new Vector.<Mc>();
		/**闪烁标记数组**/
		public var sparkArr:Vector.<int>=new Vector.<int>;
		/**转动间隔的数组**/	                                                                                                                
		private var  delayArr:Vector.<int>=new <int>[1000,800,600,300,200,200,100,100,200,200,300,600,800,500];
		/**编号数组**/
		private var NoArr:Array;
		/**需要点亮的标记编号数组**/
		private var TargetArr:Array;
		/**被点亮的标记编号数组**/
		private var OnNoArr:Vector.<int>=new Vector.<int>;
		/**现在点亮的标记**/
		public var mcOn:int=0;
		/**需要点亮的标记**/
		public var mcTarget:int=0;
		/**转动timer**/
		public var timer:Timer=new Timer(500);
		/**送灯timer**/
		private var prizeTimer:Timer=new Timer(1000); 
		/**闪烁timer**/
		private var sparkTimer:Timer=new Timer(200);
		/**转动间隔**/
		private var dl:int=0;
		/**快速转动的速度**/
		private const speed:int=40;
		/**快速转动的持续时间**/
		private const spintime:int=3000;
		/**这个值为true时，快速转动开始**/
		private var isRolling:Boolean=false;
		/**这个值为true时，转动即将被停止**/
		private var isStop:Boolean=false;
		/**这个值为true时，正在进行自动游戏**/
		public  var autoSpin:Boolean=false;
		public var gameSet_Event:Event=new Event("gameset");
//		[Embed(source="FruitSlot.xml", mimeType="application/octet-stream")]
//		private var FruitSlot:Class;
//		private var myxml:XML=XML(new FruitSlot);
			
		public function FruitMc()
		{
			super();

			McArr.push
				(			
					mc00  ,mc01,mc02,mc03,mc04,mc05,mc06,//上
					mc16,mc26,mc36,mc46,mc56,                  //右
					mc66,mc65,mc64,mc63,mc62,mc61,mc60,//下
					mc50,mc40,mc30,mc20,mc10                   //左
				);
			McArr[0].spark();
			
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			prizeTimer.addEventListener(TimerEvent.TIMER,Prize);
			sparkTimer.addEventListener(TimerEvent.TIMER,sparkTimerHandler);
			btn_1to6.addEventListener(MouseEvent.CLICK,gambleHandler);
			btn_8to13.addEventListener(MouseEvent.CLICK,gambleHandler);
			btn_Left.addEventListener(MouseEvent.CLICK,gbM_minus);
			btn_Right.addEventListener(MouseEvent.CLICK,gbM_plus);
			gambleBtnEnable(false);
			bgsSwt(true);
		}
		/**将全部点亮的标记熄灭**/
		public  function Init():void{
			sparkTimer.reset();
			for( var i:String in OnNoArr){
				McArr[ OnNoArr[i] ].isLock=false;
				McArr[ OnNoArr[i] ].normal();
			}			
			for( i in sparkArr){
				McArr[ sparkArr[i] ].isLock=false;
				McArr[ sparkArr[i] ].normal();
			}
			sparkArr=new Vector.<int>;
			OnNoArr=new Vector.<int>;
			NoArr=new Array;
			for(var j:int=0;j<24;j++){
				NoArr[j]=j;
			}
			McArr[mcOn].Atari();
			txt_GbResult.gotoAndStop("empty");
		}
		
		public function startGame():void{
			if(GameData.Money+GameData.Gamble-GameData.getBet()<0){
				trace("金额不足!");
				return;
			}
			Init();		
			gambleBtnEnable(false);
			GameData.Money=GameData.Money+GameData.Gamble-GameData.Bet;
			renew_MoneyText();
			GameData.Prize=0;
			GameData.Gamble=0;
			renew_PrizeText();
			TargetArr=createPrizeArr(randPrize());
		//	TargetArr=createPrizeArr("大四喜");
			trace(GameData.getPrize(TargetArr));
			mcTarget=TargetArr[0];
			timer.start();
		}
		public function autoPlay():void{
			if(autoSpin==true){
				startGame();
			}
		}
		
		/**生成中奖标记编号数组的函数**/
		private function randPrize():String{
			switch(int(Math.random()*20)){
				case 0:
				case 10:
				case 11:
				case 12:
				case 17:
					return "随机";
				case 1:
				case 13:
				case 14:
					return "随机送灯2";
				case 2:
				case 15:
				case 18:
					return "随机送灯3";
				case 3:
				case 16:
					return "小三元";
				case 4:
				case 19:
					return "大三元";
				case 5:
					return "大四喜";
				case 6:
					return "纵横四海上";
				case 7:
					return "纵横四海下";	
				case 8:
					return "纵横四海左";
				case 9:
					return "纵横四海右";
			}
			return "大满贯";	
		}		
		private function createPrizeArr(p:String):Array{		
			var tmpArr:Array=new Array;		
			NoArr.splice(9,1);
			NoArr.splice(20,1);
			trace(NoArr);
			switch(p){
				case "随机":
					tmpArr.push(NoArr.splice( int(Math.random()*NoArr.length),1 ));				
					break;
				case "随机送灯2":
					for(var j:int=2;j>0;j--){
						tmpArr.push(NoArr.splice( int(Math.random()*NoArr.length),1 ));		
					}
					break;
				case "随机送灯3":
					for(j=3;j>0;j--){
						tmpArr.push(NoArr.splice( int(Math.random()*NoArr.length),1 ));		
					}
					break;
				case "小三元":
					tmpArr.push(4,12,21);
					break;
				case "大三元":
					tmpArr.push(7,15,19);				
					break;
				case "大四喜":
					tmpArr.push(5,10,16,22);
					break;
				case "纵横四海上":
					tmpArr=new Array(0,1,2,3,4,5,6);
					return tmpArr;
				case "纵横四海下":
					tmpArr=new Array(12,13,14,15,16,17,18);
					return tmpArr;
				case "纵横四海左":
					tmpArr=new Array(18,19,20,21,22,23,0);
					return tmpArr;
				case "纵横四海右":
					tmpArr=new Array(6,7,8,9,10,11,12);
					return tmpArr;
			//	case "大满贯":
				//	return tmpArr;				
			}

			//打乱顺序
			tmpArr.unshift(  tmpArr.splice(Math.random()*tmpArr.length,1)  );
			tmpArr.unshift(  tmpArr.splice(Math.random()*tmpArr.length,1)  );
			switch(int(Math.random()*24)){
				case 0:
					tmpArr.unshift(9);
					break;
				case 1:
					tmpArr.unshift(21);
					break;
			}
			trace("中奖标记："+tmpArr);
			return tmpArr;
		}
		
		/**标记闪烁**/
		private function sparkTimerHandler(e:TimerEvent):void{		
			for( var i:int=0;i<sparkArr.length;i++){
				McArr[ sparkArr[i] ].spark();			
			}
			if(autoSpin==true && sparkTimer.currentCount>=10){
				startGame();
			}
		}			
		
		private function getTargetNum(i:int):int{
			if(i>=6) return i;
			else return i+24;
		}
		/**转动timer处理函数**/
		public function timerHandler(e:TimerEvent):void{	
			if(isStop==true && getTargetNum(mcTarget)-mcOn==6 && mcOn<=getTargetNum(mcTarget)){
				rollingCtrl(true);
				dl++;
			}
			if(isStop==true && isRolling==false && mcOn==mcTarget){
				isStop=false;
				sparkArr.push(mcTarget);	
				McArr[mcOn].isLock=true;
				timer.reset();				
				prizeTimer.start();
				return;
			}
			dispatchEvent(Bgm.playEvent);
			stepForward();
				
			if(!isRolling){	
				if(dl==5)bgsSwt(false);
				if(dl==8)bgsSwt(true);
				if(dl==6) {
					rollingCtrl(false);
					setTimeout(StopSwit,spintime);
					return;
				}
				dl++;
				if(dl==14)dl=0;
				timer.delay=delayArr[dl];
			}
		}
		
		/**送灯，包含结束游戏的处理**/
		public function Prize(e:TimerEvent):void{			
			if(prizeTimer.currentCount==TargetArr.length){
				prizeTimer.reset();
				trace("闪烁标记：",sparkArr);
				GameData.Gamble=GameData.Prize;
				renew_PrizeText();
				renew_MoneyText();
				sparkTimer.start();
				gambleBtnEnable(true);
				this.dispatchEvent(new Event("gameset"));
				return;
			}
			McArr[ TargetArr[prizeTimer.currentCount-1] ].normal();
			gotoTarget(TargetArr[prizeTimer.currentCount]);
		}
		
		/**旋转至目标**/
		public function gotoTarget(t:int):void{
			mcTarget=t;			
			if(Math.abs((mcTarget+13-mcOn))>=10) spinClockWise();
			else spinAntiClockWise();			
		}
		
		/**顺时针旋转至目标**/
		private function spinClockWise():void{
			stepForward();		
			if(mcOn==mcTarget){
				sparkArr.push(mcTarget);		
				McArr[mcOn].isLock=true;
				return;
			}
			setTimeout(spinClockWise,40);			
		}		
		/**逆时针旋转至目标**/
		private function spinAntiClockWise():void{
			stepBack();	
			if(mcOn==mcTarget){
				sparkArr.push(mcTarget);
				McArr[mcOn].isLock=true;
				return;
			}
			setTimeout(spinAntiClockWise,40);
		}		
		
		/**顺时针前移一格**/
		private function stepForward():void{
			mcOn++;
			if(mcOn==24)mcOn=0;				
			McArr[mcOn].Atari();				
			if(mcOn==0) McArr[23].normal();
			else McArr[mcOn-1].normal();
		}
		/**逆时针前移一格**/
		private function stepBack():void{
			--mcOn;
			if(mcOn==-1)mcOn=23;
			McArr[mcOn].Atari();
			if(mcOn==23) McArr[0].normal();
			else McArr[mcOn+1].normal();
		}
		
		/**开关快速转动的函数
		 * @param b true：转动，false：停止**/
		public function rollingCtrl(b:Boolean):void{
			isRolling=!b;
			bgsSwt(!isRolling);
			Bgm.playRolling(isRolling);
			if(isRolling)timer.delay=speed;			
		}
		
		private  function bgsSwt(b:Boolean):void{
			if(b)this.addEventListener(Bgm.bgsCtrlString,Bgm.BgsPlay);
			else this.removeEventListener(Bgm.bgsCtrlString,Bgm.BgsPlay);
		}
		
		private  function StopSwit():void{
			isStop=!isStop;
		}

		public  function renew_MoneyText():void{
			txt_Money.text=String(GameData.Money);
		}
		public function renew_PrizeText():void{
			txt_Prize.text=String(GameData.Gamble);
		}
		private function gambleHandler(e:MouseEvent):void{
			var result:int=int(Math.random()*14+1);		
			txt_GbResult.gotoAndStop(result+1);
			if(result==7){
				return;
			}else if(result>6 && e.currentTarget==btn_1to6){
				gambleLose();
			}else if(result<8 && e.currentTarget==btn_8to13){
				gambleLose();
			}else{
				gambleWin();
			}			
		}
		private function gambleLose():void{
			GameData.Prize=0;
			GameData.Gamble=0;
			renew_PrizeText();
		}
		private function gambleWin():void{
			GameData.Gamble*=2;
			renew_PrizeText();
		}
		
		private function gbM_plus(e:MouseEvent):void{
			if( GameData.Gamble<= ( GameData.Prize-GameData.rateArr[ GameData.betRate ] ) ){
				GameData.Money+=GameData.rateArr[ GameData.betRate ];
				GameData.Gamble+=GameData.rateArr[ GameData.betRate ];
				renew_MoneyText();
				renew_PrizeText();
			}
		}
		private function gbM_minus(e:MouseEvent):void{
			if( GameData.Gamble>=GameData.rateArr[ GameData.betRate ]){
				GameData.Money-=GameData.rateArr[ GameData.betRate ];
				GameData.Gamble-=GameData.rateArr[ GameData.betRate ];
				renew_MoneyText();
				renew_PrizeText();
			}
		}
		private function gambleBtnEnable(b:Boolean):void{
			btn_1to6.mouseEnabled=b;
			btn_1to6.mouseChildren=b;
			btn_8to13.mouseEnabled=b;
			btn_8to13.mouseChildren=b;
			btn_Left.mouseEnabled=b;
			btn_Left.mouseChildren=b;
			btn_Right.mouseEnabled=b;
			btn_Right.mouseChildren=b;
		}
		
	}
}