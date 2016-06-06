package iterator
{
	import flash.geom.Point;
	
	/**将同一高度的方块返回的迭代器**/
	public class IteratorHeight implements IIterator
	{
		private var _arr:Array;
		private var _ix:int;
		private var _iz:int;
		private var _ih:int;
		private var _mh:int;
		private var _itor:IteratorPos;
		
		public function IteratorHeight(arr:Array)
		{
			_arr=arr;
			_mh=0;
			_itor=new IteratorPos(_arr);
			var h:int;
			while(_itor.hasNext()){
				h=_itor.next().length;
				if(h>_mh) _mh=h;
			}
			_itor.reset();
			reset();
		}
		
		public function reset():void
		{
			_ix=0;
			_iz=0;
			_ih=0;
		}
		
		public function next():Object
		{
			var res:Array=new Array;
			var tmp:Array=new Array;
			var p:Point;
			while(_itor.hasNext()){
				p=_itor.Pos;
				tmp=_itor.next();
				if(_ih>tmp.length){
					res.push({x:p.x , z:p.y , type:tmp[_ih]});
				}
			}
			return res;
		}
		
		public function hasNext():Boolean
		{
			return _ih<_mh;
		}
	}
}