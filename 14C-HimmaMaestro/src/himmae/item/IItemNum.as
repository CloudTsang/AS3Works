package himmae.item
{
	public interface IItemNum
	{
		function reset():void;
		function cost():int;	
		function get cost_itemPow():int;
		function get cost_itemBirdCapture():int;
		function get cost_itemLight():int;
		function get numPow():int;
		function set numPow(i:int):void;
		function get numBirdCapture():int;
		function set numBirdCapture(i:int):void;
		function get numLight():int;
		function set numLight(i:int):void;
	}
}