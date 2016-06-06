package himmae.item
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import flashx.textLayout.operations.CreateListOperation;
	import himmae.iterfaces.IHero;
	import himmae.iterfaces.IWorldData;
	
	public class ItemLIGHT extends Light implements IItem
	{
		/**探照灯
		 * @param range : 照射范围，最大为3，默认为0，传入0时不会创建探照灯，可以调用useItem()>Renew()但不会有操作，需要创建时可以使用changeRange()**/
		public function ItemLIGHT(hero:IHero , world:IWorldData,range:int=0)
		{			
			super(hero , world , range);
		}
		
		public function useItem():void
		{
			Renew();
		}
		
		public function haveDispObj():Boolean
		{
			if(_range==-1)return false;
			return true;
		}
		
		public function get DispObj():Vector.<DisplayObject>
		{
			return Vector.<DisplayObject>([this]);
		}
	}
}