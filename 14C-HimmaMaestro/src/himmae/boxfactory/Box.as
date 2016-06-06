package himmae.boxfactory
{
	import com.friendsofed.isometric.DrawnIsoBox;
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import flashx.textLayout.elements.BreakElement;
	import himmae.misc.Colors;

	public class Box extends DrawnIsoBox
	{	
		private var _txt:TextField;
		private var _format:TextFormat;
		private var _isTxt:Boolean=false;
		
		public function Box(type:Array , size:Number, height:Number)
		{
			color=Colors.instance.getColor(type[0]);
			super(size, color, height);
			if(type.length>1){
				drawTxt(type[1]);
				this.addChild(_txt);
			}			
		}
		
		public static function createBox(type:String , size:int ,hei:int):Box{
			var tmpArr:Array=type.split("&");
			return new Box(tmpArr , size , hei);
		}
		
		private function drawTxt(s:String):void{
			_txt=new TextField;
			_format=new TextFormat;
			_format.size=30;
			_format.bold=true;
			_format.color=0xffffff;
			_txt.defaultTextFormat=_format;
			_txt.x=-20;
			_txt.y=-30;
			_txt.text=s;
			_isTxt=true;
		}
	}
}