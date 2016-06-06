package himmae.iterfaces
{
	import flash.display.Bitmap;

	public interface IBird
	{
		/**大鸟出现几率，默认值为1，关卡时间为1800和0000时为默认值，0600时为0**/
		function set Rate(r:Number):void;
		function get Rate():Number;
		/**t时间是否有大鸟出现**/
		function isBirdComing(t:int):Boolean;
		/**创建大鸟丢砖的bmp**/
		function createBird():Bitmap;
		/**暂停/继续大鸟丢下来的砖头**/
		function fallingCtrl(f:Boolean):void;
		/**停止并删除大鸟丢下来的砖头**/
		function stopFalling():void;
		/**大鸟丢砖头事件结束**/
		function onDropComplete():void;
	}
}