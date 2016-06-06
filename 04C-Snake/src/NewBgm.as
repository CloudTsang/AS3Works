package
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.clearInterval;
	
	public class NewBgm
	{
		public var BgmChannel:SoundChannel=new SoundChannel;
		private var Title:title=new title;
		private var Snake1:snk1=new snk1;
		private var Snake2:snk2=new snk2;
		private var Snake3:snk3=new snk3;
		private var Engage:engage=new engage;
		private var btn:btnBGS=new btnBGS;
		private var GameOver:over=new over;
		private var GPad:padBGS=new padBGS;
		private var Eat:eatBGS=new eatBGS;
		private var Grow:growBGS=new growBGS;
		public function NewBgm()
		{
		}
		public function bgmSwitch(Phrase:String):void
		{
			BgmChannel.stop();
			switch (Phrase)
			{
				case "Title":
					BgmChannel=Title.play(0,9999);
					break;
				case "BGS":
					BgmChannel=btn.play();
					break;
				case "GamePad":
					BgmChannel=GPad.play();
					break;
				case "Game Start":
					BgmChannel=Engage.play();
				case "One Snake":
					BgmChannel=Snake1.play(0,9999);
					break;
				case "Two Snakes":
					BgmChannel=Snake2.play(0,9999);
					break;
				case "Three Snakes":
					BgmChannel=Snake3.play(0,9999);
					break;
				case "Gem":
					BgmChannel=Eat.play();
					break;
				case "Grow":
					BgmChannel=Grow.play();
					break;
				case "Game Over":
					BgmChannel=GameOver.play(0,9999);
					break;
			}
		}
	}
}