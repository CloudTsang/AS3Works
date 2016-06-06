package iterator
{
	public class Iterator1D implements IIterator
	{
		private var _arr:Array;
		private var _index:int;
		public function Iterator1D(arr:Array)
		{
			array=arr;
		}
		public function set array(arr:Array):void{
			_arr=arr;
			_index=0;
		}
		
		public function reset():void
		{
			_index=0;
		}
		
		public function next():Object
		{
			return _arr[_index++];
		}
		
		public function hasNext():Boolean
		{
			return _index<_arr.length;
		}
	}
}