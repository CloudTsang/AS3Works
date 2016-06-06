package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Button extends Sprite
	{
		public var switchOnOff:OnOffbtn=new OnOffbtn();
		public var switch123:btn123=new btn123();
		public var switch1to6:btn1to6=new btn1to6;
		public var Start:Startbtn=new Startbtn();
		public var Restart:REbtn=new REbtn;
		
		private var BGS:NewBgm=new NewBgm;
		
		public function Button()
		{
			switchOnOff.addEventListener(MouseEvent.CLICK,BGSon);
			switch123.addEventListener(MouseEvent.CLICK,BGSon);
			switch1to6.addEventListener(MouseEvent.CLICK,BGSon);
			Start.addEventListener(MouseEvent.CLICK,BGSon);
			Restart.addEventListener(MouseEvent.CLICK,BGSon);
		}
		
		private 	function BGSon(event:MouseEvent):void
		{
			BGS.bgmSwitch("BGS");
		}
		
	}
}