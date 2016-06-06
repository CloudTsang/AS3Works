package himmae.iterfaces
{
	import flash.geom.Point;
/**这个是处理各种舞台尺寸计算的接口**/
	public interface IPartsSize
	{
		/**获取屏幕上第x排第z列的第y个砖头的屏幕坐标
		 * @param y : 默认为-1，计算这一栋砖头最上面一个的坐标
		 * @return Point类型的坐标
		 * **/
		function getBoxScreenPosition(x:int, z:int , y:int):Point;
		/**地板的像素宽度**/
		function get floorWidth():int;
		/**地板的像素高度**/
		function get floorHeight():int;
		/**天空的像素高度**/
		function get skyHeight():int;
		/**总体的像素高度**/
		function get worldHeight():int;
		/**总体的像素宽度**/
		function get worldWidth():int;
		/**横轴偏移量**/
		function get offsetX():int;
		/**纵轴偏移量**/
		function get offsetY():int;
		/**格子大小**/
		function get size():int;
	}
}