package himmae.observer
{	

	/**在更新时会传出一个参数的观察对象**/
	public class Subject2 implements ISubject2
	{
        protected var _vec:Vector.<IObserver2>;
		protected var _param:*;
		
		public function Subject2(p:*=null)
		{
			_vec=new Vector.<IObserver2>;
			_param=p;
		}
		
		public function regObserver(obs:IObserver2):void
		{
			_vec.push(obs);
		}
		
		public function delObserver(obs:IObserver2):void
		{
			var i:int = _vec.indexOf( obs );
			if(i>=0) _vec.splice(i,1);
		}
		
		public function callObserver():void
		{
			for(var i:int=0 ; i<_vec.length ; i++){
				_vec[i].update(_param);
			}
		}
		public function set param(p:*):void{
			_param=p;
			callObserver();
		}
		public function get param():*{
			return _param;
		}
	}
}