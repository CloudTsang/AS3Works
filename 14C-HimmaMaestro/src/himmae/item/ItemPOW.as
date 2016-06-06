package himmae.item
{
	
	import himmae.displayworld.IWorld;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import himmae.iterfaces.IHero;
	import himmae.iterfaces.IWorldData;
	
	public class ItemPOW implements IItem
	{
		private var _num:int;
		private var _hero:IHero;
		private var _world:IWorldData;
		public function ItemPOW(h:IHero , w:IWorldData , num:int)
		{
			_num=num;
			_hero=h;
			_world=w;
		}
		
		public function useItem():void
		{
			var pos:Point=_hero.position;
			var arr:Array=_world.getCellData( pos.x , pos.y ) ;
			for(var p:int=0 ; p<_num ; p++) {
				arr.unshift( HM.POWER );
			}
			_world.setCellData(arr , pos.x , pos.y);
			_hero.renew();
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