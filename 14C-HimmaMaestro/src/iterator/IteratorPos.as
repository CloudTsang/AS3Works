package iterator
{
	import com.greensock.plugins.Positions2DPlugin;
	
	import flash.geom.Point;

	/**将一格上的方块返回的迭代器**/
	public class IteratorPos implements IIterator
	{
		private var _arr:Array;
		private var _ix:int;
		private var _iz:int;
		public function IteratorPos(arr:Array)
		{
			_arr=arr;
			reset();
		}
		
		public function reset():void
		{
			_ix=0;
			_iz=0;
		}
		
		public function get Pos():Point{
			return new Point(_ix , _iz);
		}
		
		public function next():Object
		{
			return _arr[_ix][_iz++];
		}
		
		public function hasNext():Boolean
		{
			if(_iz==_arr[_ix].length){
				_ix++;
				if(_ix==_arr.length)return false;
				_iz=0;
			}
			return true;
		}
	}
}