package com.friendsofed.isometric
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
/**基础的等角对象，没有可以用于显示的目标**/
	public class IsoObject extends Sprite
	{
		protected var _position:Point3D;
		protected var _size:Number;
		protected var _walkable:Boolean = false;
		protected var _vx:Number = 0;
		protected var _vy:Number = 0;
		protected var _vz:Number = 0;
		
		// a more accurate version of 1.2247...
		public static const Y_CORRECT:Number = Math.cos(-Math.PI / 6) * Math.SQRT2;

		public function IsoObject(size:Number)
		{
			_size = size;
			_position = new Point3D();
			updateScreenPosition();
		}
		
		/**
		 * 更新等角对象在屏幕上的坐标。
		 */
		protected function updateScreenPosition():void
		{
			var screenPos:Point = IsoUtils.isoToScreen(_position);
			//IsoObject继承了Sprite，用super.x和super.y设置屏幕位置
			super.x = screenPos.x;
			super.y = screenPos.y;
		}
		
		/**
		 * String representation of this object.
		 */
		override public function toString():String
		{
			return "[IsoObject (x:" + _position.x + ", y:" + _position.y + ", z:" + _position.z + ")]";
		}
		
		/**
		 * Sets / gets 等角空间中的横坐标x
		 */
		override public function set x(value:Number):void
		{
			_position.x = value;
			updateScreenPosition();
		}
		override public function get x():Number
		{
			return _position.x;
		}
		
		/**
		 * Sets / gets 等角空间中的高度y
		 */
		override public function set y(value:Number):void
		{
			_position.y = value;
			updateScreenPosition();
		}
		override public function get y():Number
		{
			return _position.y;
		}
		
		/**
		 * Sets / gets 等角空间中的纵坐标z
		 */
		override public function set z(value:Number):void
		{
			_position.z = value;
			updateScreenPosition();
		}
		override public function get z():Number
		{
			return _position.z;
		}
		
		/**
		 * Sets / gets 等角空间中的位置
		 * @return point3d
		 */
		public function set position(value:Point3D):void
		{
			_position = value;
			updateScreenPosition();
		}
		public function get position():Point3D
		{
			return _position;
		}
		
		/**
		 * get 深度
		 */ 
		public function get depth():Number
		{
			return (_position.x + _position.z) * .866 - _position.y * .707;
		}
		
		/**
		 * Indicates whether the space occupied by this object can be occupied by another object.
		 */
		public function set walkable(value:Boolean):void
		{
			_walkable = value;
		}
		public function get walkable():Boolean
		{
			return _walkable;
		}
		
		public function get screenX():int{
			return super.x;
		}
		public function get screenY():int{
			return super.y;
		}
		
		/**
		 * Returns the size of this object.
		 */
		public function get size():Number
		{
			return _size;
		}
		
		/**
		 * Returns the square area on the x-z plane that this object takes up.
		 */
		public function get rect():Rectangle
		{
			return new Rectangle(x - size / 2, z - size / 2, size, size);
		}
		
		/**
		 * Sets / gets the velocity on the x axis.
		 */
		public function set vx(value:Number):void
		{
			_vx = value;
		}
		public function get vx():Number
		{
			return _vx;
		}
		
		/**
		 * Sets / gets the velocity on the y axis.
		 */
		public function set vy(value:Number):void
		{
			_vy = value;
		}
		public function get vy():Number
		{
			return _vy;
		}
		
		/**
		 * Sets / gets the velocity on the z axis.
		 */
		public function set vz(value:Number):void
		{
			_vz = value;
		}
		public function get vz():Number
		{
			return _vz;
		}
	}
}