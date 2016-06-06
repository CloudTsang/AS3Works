package himmae.misc
{
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class TextBlank extends TextField
	{
		private var _format:TextFormat;
		public function TextBlank(Char:String="" ,Size:int=30 , hei:int=-1 , wid:int=-1  , x:int=0 , y:int=0 , multiLine:Boolean=true, align:String=TextFormatAlign.LEFT,Border:Boolean=false ,col:uint=0x000000, Type:int=2)
		{
			super();
			this.border=Border;
			this.x=x;
			this.y=y;
			if(hei==-1)this.height=Size;
			else this.height=hei;
			if(wid==-1)this.width=Char.length*Size;
			else this.width=wid;
			_format=new TextFormat;
			_format.size=Size;
			_format.color=col;
			_format.align=align;
			this.multiline=true;
			this.multiline=multiLine;
			this.wordWrap=multiLine;
			this.defaultTextFormat=_format;
			this.selectable=false;
			if(Type==1)//可输入文本框
			{
				this.type=TextFieldType.INPUT;
			}
			else if(Type==2)//静态文本
			{
				
				this.text=Char;
			}			
			//this.setTextFormat(format);
		}
	}
}