package
{
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	public class TextBlank extends TextField
	{
		public	var format:TextFormat=new TextFormat;
		public function TextBlank(Border:Boolean,x:int,y:int,hei:int,wid:int,Char:String="",s:int=35)
		{
			super();
		//	this.multiline=false;
			this.border=Border;
			this.x=x;
			this.y=y;
			this.height=hei;
			this.width=wid;
			format.size=s;
			this.selectable=false;
			this.text=Char;	
			this.setTextFormat(format);
			this.defaultTextFormat=format;

		}
	}
}