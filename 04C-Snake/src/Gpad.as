package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Gpad extends Sprite
	{			
		public  var upbtn:UPbtn=new UPbtn;
		public  var downbtn:DOWNbtn=new DOWNbtn;
		public var leftbtn:LEFTbtn=new LEFTbtn;
		public  var rightbtn:RIGHTbtn=new RIGHTbtn;
		
		private var BGS:NewBgm=new NewBgm;
		
		public function Gpad(color:uint,name:String)
		{
			super();
			this.graphics.beginFill(color);
			this.graphics.drawRect(0,0,168,220);
			var Nametxt:TextField=new TextField;
			var Nameformat:TextFormat=new TextFormat;
			//Nameformat.font="mgs4brush";
			Nameformat.size=25;
			Nameformat.color=0x000000;
			Nametxt.width=170;
			Nametxt.text=name;
			Nametxt.x=x;
			Nametxt.y=y+170;
			Nametxt.setTextFormat(Nameformat);
			this.addChild(Nametxt);
			//底版
			
			//按键
			upbtn.x=x+56;
			upbtn.y=y;
			upbtn.width=56;
			upbtn.height=56;
			upbtn.addEventListener(MouseEvent.CLICK,BGSon);
			leftbtn.x=x;
			leftbtn.y=y+56;
			leftbtn.width=56;
			leftbtn.height=56;
			leftbtn.addEventListener(MouseEvent.CLICK,BGSon);
			rightbtn.x=x+112;
			rightbtn.y=y+56;
			rightbtn.width=56;
			rightbtn.height=56;
			rightbtn..addEventListener(MouseEvent.CLICK,BGSon);
			downbtn.x=x+56;
			downbtn.y=y+112;
			downbtn.width=56;
			downbtn.height=56;
			downbtn.addEventListener(MouseEvent.CLICK,BGSon);
			this.addChild(upbtn);
			this.addChild(rightbtn);
			this.addChild(leftbtn);
			this.addChild(downbtn);
		}
		private function BGSon(event:MouseEvent):void{
			BGS.bgmSwitch("GamePad");
		}
	}
}