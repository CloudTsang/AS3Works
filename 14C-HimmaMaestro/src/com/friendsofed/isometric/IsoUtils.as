package com.friendsofed.isometric
{
	import flash.geom.Point;
	/**提供3D等角坐标与2D屏幕坐标互换的静态方法**/
	public class IsoUtils
	{
		// a more accurate version of 1.2247...
		public static const Y_CORRECT:Number = Math.cos(-Math.PI / 6) * Math.SQRT2;
		public static var IsoScale:Number=0.5
		/**
		 * 将3D坐标点转换为2D坐标
		 * @param pos 要转换的point3D对象
		 * @return Point
		 */
		public static function isoToScreen(pos:Point3D):Point
		{
			var screenX:Number = pos.x - pos.z;
			var screenY:Number = pos.y * Y_CORRECT + (pos.x + pos.z) *IsoScale;
			return new Point(screenX, screenY);
		}
		
		/**
		 * 2D转3D，高度y为0
		 * @param point 要转换的Point对象
		 * @return Point3D
		 */
		public static function screenToIso(point:Point):Point3D
		{
			var xpos:Number = point.y + point.x *IsoScale;
			var ypos:Number = 0;
			var zpos:Number = point.y - point.x *IsoScale;
			return new Point3D(xpos, ypos, zpos);
		}
		
//		public static function 
		
	}
}