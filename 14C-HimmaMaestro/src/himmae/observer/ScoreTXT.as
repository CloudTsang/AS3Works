package himmae.observer
{
	import flash.text.TextFormatAlign;

	/**显示关卡现有分数与通关最低分数的txt**/
	public class ScoreTXT extends TxtObserver
	{
		private var _sl:String;
		public function ScoreTXT(it:ISubject2 , score:int=0  , Size:int=30, hei:int=35, wid:int=150, x:int=0, y:int=0, multiLine:Boolean=true, align:String=TextFormatAlign.LEFT, Border:Boolean=false, col:uint=0x000000, Type:int=2)
		{
			scoreLimit=score;
			super(it , Size, hei, wid, x, y, multiLine, align, Border, col, Type);
		}
		protected override function renewText(s:String):void{
			this.text=s+_sl;
		}
		
		public function set scoreLimit(s:int):void{
			_sl="  /  "+String(s);
		}
	}
}