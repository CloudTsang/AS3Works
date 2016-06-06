package
{
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	public class TextBlank extends TextField
	{
		public	var format:TextFormat=new TextFormat;
		public function TextBlank(Border:Boolean, x:int, y:int, hei:int, wid:int, Type:int, Char:String="")
		{
			super();
			this.multiline=true;
			this.border=Border;
			this.x=x;
			this.y=y;
			this.height=hei;
			this.width=wid;
			format.size=25;
			if(Type==1)//可输入文本框
			{
				this.type=TextFieldType.INPUT;
			}
			else if(Type==2)//静态文本
			{
				this.text=Char;
			}			
			this.setTextFormat(format);
		}
	}
}