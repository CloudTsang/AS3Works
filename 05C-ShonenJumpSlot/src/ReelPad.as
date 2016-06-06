package
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	public class ReelPad extends Sprite
	{
		/**五个转轮的数组**/
		public var Reels:Vector.<Reel>=new Vector.<Reel>();
		/***控制各个转轮开始、停止转动的timer，计数5次*/
		private var ctrlTimer:Timer=new Timer(1,5);
		/**是否双向兑奖，1=不是，2=是**/
		public static var isDuo:int=1;
		private  var sct:sctEffect=new sctEffect;		
		
		private var ttmp:int=0;
		public function ReelPad()
		{								
			Reels.push
				(
					new Reel(80,20),
					new Reel(285,20),
					new Reel(490,20),
					new Reel(695,20),
					new Reel(900,20)
				);		
			for ( var i:String in Reels){
			//	Reels[i].addEventListener("sctRoll",sctEffectHandler);
				this.addChild(Reels[i]);
			}
			sct.height=550;
			sct.width=250;
			
			ctrlTimer.addEventListener("timer",ctrlTimerHandler);
		}
		
		/**设置是否双向**/
		public static function setisDuo(e:MouseEvent):void{
			isDuo=3-isDuo;	
		}	
		private function sctEffectHandler(e:Event):void{
			
		}
		/**
		 * 转轮旋转的timer函数
		 * 通过改变转轮的isSpin的Boolean值控制转轮开始停止。
		 * */
		public function  ctrlTimerHandler(event:TimerEvent):void{
			ttmp=event.currentTarget.currentCount-1
			//最后一个轮转动、停止时，显示开始键
			if(Buttons.Start.McBlock.visible==true && ttmp==4 ){
				Buttons.Start.McBlock.visible=false;
			}
			
			if(Reels[ttmp].isSpin==false){
				Reels[ttmp].startReel();	
				if(ttmp==0){
					BGM.BgsPlay("rolling");
				}
			}
			else{
				Reels[ttmp].stopReel();    
//				if(Reel.sct>=2 && ttmp<4){
//					trace("here");				
//					ctrlTimer.delay=3000;	
//					sct.x=Reels[ttmp+1].x;
//					sct.y=30;
//					
//					this.addChild(sct);
//				}
				if(ttmp==4){
					BGM.BgmStop("rolling");					
					if(sct.stage!=null){			
						this.removeChild(sct);
					}
					this.dispatchEvent(new Event("Finish_Rolling"));
				}
			}			
		}
		
		/**转轮开始/停止的控制函数**/
		public function gameCtrl(state:Boolean):void{	
			ctrlTimer.reset();
			if(state==true){
				ctrlTimer.delay=30;//每隔30ms开始1个转轮
			}else{
				ctrlTimer.delay=500;//每隔500ms停止1个转轮
			}			
			ctrlTimer.start();		
		}
		
		/**
		 * 标记检测函数。
		 *@param strArr：五轮检测第几行的数组。
		 * @return
		 * 返回一个Object有以下属性：
		 * Count……该兑奖线中奖标记的个数，
		 * Odd……中奖标记的名称。
		 * */
		public function markDetect(strArr:Array):Object
		{
			var tmpCount:int;   //中奖标记数，小于2时在获取赔率时返回0  //
			var oddStr:String; 
			
			tmpCount=0;	
			//去除wild标记，选择第一个不是wild的标记计算赔率 
			oddStr="Wild";
			var j:int=0;
			while(oddStr=="Wild" && j<5){
				oddStr=Reels[j].getName(strArr[j]-1);		
				j++;
			}
			
			//中奖标记个数检测  
			for(var l:int=0;l<5;l++)
			{
				if(Reels[l].getName(strArr[l]-1)=="Wild" || oddStr==Reels[l].getName(strArr[l]-1)){
					tmpCount++;				
				}
				else
				{
					break;
				}	
			}
			
			/**返回标记检测结果
			 * Count：这条兑奖线中了多少个标记
			 * Odd：赔率
			 * revCount、revOdd:双向玩法时的中奖数和赔率，单向时设为0
			 * **/
			var retObj:Object={
				Count:tmpCount,
				Odd:Reels[j-1].getOdd(strArr[j-1]-1,tmpCount),
					revCount:0,
					revOdd:0
			}	
			
			//双向玩法
			if(isDuo==2){
				tmpCount=0
				//去除wild标记，选择第一个不是wild的标记计算赔率 
				oddStr="Wild";
				j=4
				while(oddStr=="Wild" && j>=0){
					oddStr=Reels[j].getName(strArr[j]-1);		
					//	trace(oddStr);
					j--;
				}
				
				//中奖标记个数检测  
				for(l=4;l>=0;l--)
				{
					if(Reels[l].getName(strArr[l]-1)=="Wild" || oddStr==Reels[l].getName(strArr[l]-1)){
						tmpCount++;
					}
					else
					{
						break;
					}	
				}				
				retObj.revCount=tmpCount;
				retObj.revOdd=Reels[j+1].getOdd(strArr[j+1]-1 ,tmpCount);
			}
			
			return retObj;
		}
		
		/**
		 * free个数检测
		 * @return 获得的free game次数
		 * */
		public function freeDetect():int{
			var FreeArr:Array=new Array(0);//储存每一轮scartter个数 	
			var FGC:int=1
			for(var m:int=0;m<5;m++){
				var tmp:int=0;  
				for (var n:int=0;n<3;n++){
					if(Reels[m].getName(n)=="Free")
					{
						tmp++; 
					}
				}
				if(tmp>0){
					FreeArr.push(tmp);
				}
			}
			if(FreeArr.length<3){
				return 0;
			}
			for(var o:int=0;o<FreeArr.length;o++){
				FGC*=FreeArr[o];
			}
			switch(FreeArr.length){		
				case 3:
					FGC*=0;
					break;
				case 4:
					FGC*=0;
					break;
				case 5:
					FGC*=0;
					break;
				
			}
			return FGC;
		}
		
	}
}