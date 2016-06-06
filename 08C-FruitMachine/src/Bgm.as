package
{
	import flash.events.Event;
	import flash.media.SoundChannel;
	
	public class Bgm
	{
		private static var BgsCh:SoundChannel=new SoundChannel;
		private static var ding:Blip=new Blip;
		private static var roll:Rolling=new Rolling;
		public static var bgsCtrlString:String="bgsCtrl"
		public  static var playEvent:Event=new Event(bgsCtrlString);
		public function Bgm()
		{
		}
		public static function BgsPlay(e:Event):void{
			BgsCh=ding.play(0,1);
		}
		public static function playRolling(b:Boolean):void{
			if(b) BgsCh=roll.play(0,9999);
			else BgsCh.stop();		
		}
		
	}
}