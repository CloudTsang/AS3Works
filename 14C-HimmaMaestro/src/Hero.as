package
{
	
	import flash.geom.Point;
	
	import iterator.IIterator;
	import iterator.Iterator1D;
	
	import himmae.misc.DirectionIcon;
	import himmae.iterfaces.IHero;
	import himmae.iterfaces.IWorldData;
	
	public class Hero implements IHero
	{
		private var _pos:Point;
		private var _index:int;
		private var _pow:int;
		private var _data:IWorldData;
		private var _direction:Point;
		private var _front:Point;
		
		private var _dIcon:DirectionIcon;
		
		public function Hero(d:IWorldData , px:int , pz:int)
		{
			_data=d;
			_pos=new Point(px , pz);
			_direction=new Point(0,-1);
			_front=new Point;
			_dIcon=new DirectionIcon();
			renewIndex( _data.getCellData(_pos.x , _pos.y) )
		}
		
		public function renew(arr:Array=null):void{
			var tmp:Array;
			if(arr)  tmp=arr;
			else tmp=_data.getCellData(_pos.x , _pos.y);		
			renewIndex(tmp);
		}
		
		private function renewIndex(arr:Array):void{
			var p:int=1;
			for(var i:int=0 ; i<arr.length ; i++){
				switch(arr[i]){
					case HM.HERO:
						_index=i;
					    _pow=p;
						return;
					case HM.POWER:
						p++;
						break;
				}
			}
		}
		
		public function get direction():Point{
			return _direction;
		}

		public function set direction(d:Point):void{
			_direction=d;
			_dIcon.changeDirect(_direction);
		}
		
		public function get front():Point{
			_front=_pos.add(_direction);
			return _front;
		}
		
		public function get position():Point
		{
			return _pos;
		}
		
		public function set position(p:Point):void
		{
			_pos=p;
		}
		
		public function get index():int
		{
			return _index;
		}
		
		public function set index(i:int):void
		{
			_index=i;
		}
		
		public function get power():int
		{
			return _pow;
		}
		
		public function set power(p:int):void
		{
			_pow=p;
		}
		public function get directIcon():DirectionIcon{
			return _dIcon;
		}
	}
}