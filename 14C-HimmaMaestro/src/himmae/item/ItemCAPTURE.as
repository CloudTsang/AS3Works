package himmae.item
{
	import flash.display.DisplayObject;
	import himmae.iterfaces.IBird;
	
	public class ItemCAPTURE implements IItem
	{
		private var _level:int;
		private var _bird:IBird;
		public function ItemCAPTURE(level:int , b:IBird)
		{
			_level=level;
			_bird=b;
		}
		
		public function useItem():void
		{
			_bird.Rate+=_level;
		}
		
		public function haveDispObj():Boolean
		{
			return false;
		}
		
		public function get DispObj():Vector.<DisplayObject>
		{
			return null;
		}
	}
}