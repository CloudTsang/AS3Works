package himmae.observer
{
	import flash.text.TextFormatAlign;
	
	import himmae.misc.TextBlank;

	/**观察对象txt类**/
	public class TxtObserver extends TextBlank implements IObserver2
	{
		protected var _sub:ISubject2;
		/**@param it : 需要观察的对象**/
		public function TxtObserver(it:ISubject2 , Size:int=30, hei:int=35, wid:int=70, x:int=0, y:int=0, multiLine:Boolean=true, align:String=TextFormatAlign.LEFT, Border:Boolean=false, col:uint=0x000000, Type:int=2)
		{
			super(" ", Size, hei, wid, x, y, multiLine, align, Border, col, Type);
			_sub=it;
			_sub.regObserver(this);
			renewText( String(_sub.param as int) );
		}
		protected function renewText(s:String):void{
			this.text=s;
		}
		public function update(param:*):void
		{
			if(param is int) renewText(String(param));
		}
	}
}