package Gestures
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;

	/**手势的接口，完成手势与测试中手势都必须具有以下方法才能进行对比**/
	public interface IGes
	{
		function createTestPixel(dis:int):Array;
		function Scan(bmpd:BitmapData , color:uint ,sampDis:int):void;
		/**手势的名称**/
		function get Name():String
		/**获取手势矩形宽度，比较时进行取样距离的缩放。*/
		function get Width():int;
		/**获取手势矩形高度，比较时进行取样距离的缩放。*/
		function get Height():int;
		/**获取手势数据数组**/
		function get pixelArr():Array;
		/**获取手势数据中1与0的比值，在对比手势前可以根据这个值进行筛选（？）
		 * 由于手型方向可能导致这个值改变，筛选的可靠性也会变低。
		 * **/
		function get pixelRate():Number;
		function set pixelRate(pr:Number):void;
		/**获取手势数据中1的总数量，在对比手势前可以根据这个值进行筛选（？）
		 * 由于拍摄距离时手型大小改变将导致这个值改变，筛选的可靠性也会变低。
		 * **/
		function get totalPixel():int;
		function set totalPixel(tp:int):void;
	}
}