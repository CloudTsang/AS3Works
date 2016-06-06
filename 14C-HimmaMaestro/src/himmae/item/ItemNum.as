package himmae.item
{

	public class ItemNum implements IItemNum
	{
		protected var _pow:int;
		protected var _cap:int;
		protected var _light:int;
		
		private const COST_itemPow:int=5;
		private const COST_itemLight:int=3;
		private const COST_itemBirdCapture:int=9;
		
		public function ItemNum(pow:int=0 , cap:int=0 , light:int=0)
		{
			_pow=pow;
			_cap=cap;
			_light=light;
		}
		
		public final function cost():int{
			return _pow*COST_itemPow + _cap*COST_itemBirdCapture + _light*COST_itemLight;
		}
		public final function get cost_itemPow():int{
			return COST_itemPow;
		}
		public final function get cost_itemLight():int{
			return COST_itemLight;
		}
		public final function get cost_itemBirdCapture():int{
			return COST_itemBirdCapture;
		}
		
		public final function reset():void{
			_pow=0;
			_cap=0;
			_light=0;
		}
		/**开场时踩着的增强方块**/
		public final function get numPow():int
		{
			return _pow;
		}
		
		public final function set numPow(i:int):void
		{
			_pow=i;
		}
		/**捕鸟器**/
		public final function get numBirdCapture():int
		{
			return _cap;
		}
		
		public final function set numBirdCapture(i:int):void
		{
			_cap=i;
		}
		/**探照灯**/
		public final function get numLight():int
		{
			return _light;
		}
		
		public final function set numLight(i:int):void
		{
			_light=i;
		}
	}
}