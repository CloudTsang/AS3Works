package himmae.item
{
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import himmae.iterfaces.IBird;
	import himmae.iterfaces.IHero;
	import himmae.iterfaces.IWorldData;
	
	public class ItemCollection extends ItemNum implements IItem , IItemCollect
	{
		private var _ipower:IItem;
		private var _icapture:IItem;
		private var _ilight:IItem;
		private var _itemVec:Vector.<IItem>;
		private var _dispObjVec:Vector.<DisplayObject>;
		public function ItemCollection(inum:IItemNum , w:IWorldData , h:IHero , b:IBird)
		{
			super(inum.numPow , inum.numBirdCapture , inum.numLight);	
			_itemVec=new Vector.<IItem>;
			_dispObjVec=new Vector.<DisplayObject>;
			
			if(_pow>0){
				_ipower=new ItemPOW(h , w , _pow);
				_itemVec.push(_ipower);
			}
			if(_cap>0){
				_icapture=new ItemCAPTURE(_cap , b);
				_itemVec.push(_icapture);
			}
			if(_light>0){
				_ilight=new ItemLIGHT(h , w ,_light);
				_itemVec.push(_ilight);
			}
			
			for  (var i:String in _itemVec){
				if( _itemVec[i].haveDispObj() )_dispObjVec=_dispObjVec.concat(_itemVec[i].DispObj);
			}
		}
		
		/**使用道具的函数**/
		public function useItem():void{
			for (var i:String in _itemVec){
				_itemVec[i].useItem();
			}
		}
		
		public function haveDispObj():Boolean{
			return _itemVec.length>0;
		}
		
		public function get DispObj():Vector.<DisplayObject>{
			return _dispObjVec;
		}
		
		/**更新探照灯**/
		public function useLight(e:Event=null):void{
			_ilight.useItem();
		}
		
		public function get itemLight():IItem{
			return _ilight;
		}
		public function get itemPow():IItem{
			return _ipower;
		}
		public function get itemCapture():IItem{
			return _icapture;
		}
		
	}
}