package
{
	import btnGamble_fla.btnChoose_4;
	
	import com.greensock.TweenLite;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.plugins.VolumePlugin;
	
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	
	public class BGM
	{		
		/**声音按钮**/
		public static var Volume:BtnBgmCtrl=new BtnBgmCtrl;
		
		private static var BgmChannelAmbient:SoundChannel=new SoundChannel;
		private static var BgmChannel:SoundChannel=new SoundChannel;
		private static var BgsChannel:SoundChannel=new SoundChannel;
		private static var RollingChannel:SoundChannel=new SoundChannel;
		
		private static var Trans:SoundTransform=new SoundTransform(0);
		
		private static var Ambient:BgmAmbient=new BgmAmbient;
		private static var FgStart:BgmFgTriger=new BgmFgTriger
		private static var FgAmbient:BgmFgAmbient=new BgmFgAmbient;
		private static var FgSum:BgmFgSummary=new BgmFgSummary;
		private static var SmallWin1:BgmSmallwin1=new BgmSmallwin1;
		private static var SmallWin2:BgmSmallwin2=new BgmSmallwin2;
		private static var MidWin1:BgmMidwin1=new BgmMidwin1;
		private static var MidWin2:BgmMidwin2=new BgmMidwin2;
		private static var BigWin1:BgmBigwin1=new BgmBigwin1;
		private static var BigWin2:BgmBigwin2=new BgmBigwin2;
		private static var Press:BgsBtns=new BgsBtns;
		private static var Rolling:BgsSpin=new BgsSpin;
		private static var Scatter:BgsSctTips=new BgsSctTips;
		private static var Start:BgsGameStart=new BgsGameStart;
		public function BGM()
		{
		}
		
		public static function Init():void{
		//	TweenPlugin.activate([VolumePlugin]);
			Volume.addEventListener(MouseEvent.CLICK,SoundCtrl);
		}	
		/**声音按钮静音切换函数**/
		private static function SoundCtrl(e:MouseEvent ):void{		
			Trans.volume=1-Trans.volume;				
			SoundMixer.soundTransform=Trans;
		}
		
		/**停止音乐的函数
		 * win=停止赢奖音乐
		 * rolling=停止滚轮音效
		 * **/
		public static function BgmStop(s:String):void{
			switch(s){
				case "ambient":
					BgmChannelAmbient.stop();
					break;
				case "win":
					BgmChannel.stop();
					break;
				case "rolling":
					RollingChannel.stop();
					break;
			}
		}
		/**其他音乐的播放函数
		 *  normal=普通音乐
		 * free game=免费游戏
		 * smallwin、midwin、bigwin、
		 * fgstart、fgend、
		 * rolling=转轮转动的效果音
		 * **/
		public static function BgmPlay(s:String):void{
			switch(s){
				case  "normal" :
					BgmChannelAmbient=Ambient.play(0,9999,Trans);
					break;
				case  "free game":
					BgmChannelAmbient=FgAmbient.play(0,9999);
					break;						
				case "smallwin":
					if(int(Math.random()*2==0))
					{
						BgmChannel=SmallWin1.play(0,1,Trans);
					}else
					{
						BgmChannel=SmallWin2.play(0,1);
					}
					break;
				case "midwin":
					if(int(Math.random()*2==0)){
						BgmChannel=MidWin1.play(0,1);
					}else{
						BgmChannel=MidWin2.play(0,1);
					}
					break;
				case "bigwin":
					if(int(Math.random()*2==0)){
						BgmChannel=BigWin1.play(0,1);
					}else{
						BgmChannel=BigWin2.play(0,1);
					}
					break;
				case "fgstart":
					BgmChannel=FgStart.play(0,1);
					break;
				case "fgend":
					BgmChannel=FgSum.play(0,1);
					break;			
			
			}
		}
		
		/**音效的函数
		 * btn=按键音效，
		 * startbtn=开始键音效，
		 * scatter=转轮有免费游戏时的停止音效。
		 * **/
		public static function BgsPlay(s:String):void{
			switch (s)
			{
				case "btn":					
					BgsChannel=Press.play(0,1);
					break;
				case "startbtn":
					BgsChannel=Start.play(0,1);
					break;
				case "scatter":
					BgsChannel=Scatter.play(0,1);
					break;		
				case"rolling":
					RollingChannel=Rolling.play(0,9999);
					break;
			}	
		}
	}
}