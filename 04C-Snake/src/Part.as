package
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Part extends Sprite
	{
		public function Part(number:int,colour:uint)
		{
			super();
			this.graphics.lineStyle(0,0x000000);
			this.graphics.beginFill(colour);
			this.graphics.drawRect(0,0,30,30);
			var txt:TextField=new TextField;
			var format:TextFormat=new TextFormat;
			format.size=15;
			format.bold=true;
			txt.border=false;
			txt.x=this.x;
			txt.y=this.y;
			txt.text=String(number);
			txt.setTextFormat(format);
			this.addChild(txt);
		}
	}
}