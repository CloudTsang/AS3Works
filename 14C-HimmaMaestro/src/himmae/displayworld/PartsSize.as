package himmae.displayworld
{
	import com.friendsofed.isometric.IsoUtils;
	import com.friendsofed.isometric.Point3D;
	
	import flash.geom.Point;
	import himmae.iterfaces.IPartsSize;
	
	public class PartsSize implements IPartsSize
	{
		private var _ofsX:int;
		private var _ofsY:int;
		private var _sH:int;
		private var _sW:int;
		private var _fW:int;
		private var _fH:int;
		private var _fsH:int;
		private var _size:int;
		/**这个类负责计算舞台上各个显示对象的尺寸和坐标
		 * @param size : 一个格子的大小
		 * @param cellX : x轴有多少个格子
		 * @param cellZ : z轴有多少个格子
		 * **/
		public function PartsSize(hud:int , sky:int , size:int , cellX:int , cellZ:int)
		{
			_size=size;
			_fH=size*(cellX+cellZ)/2;
			_fW=size*(cellX+cellZ);
			_sW=_fW+hud;
			_fsH=sky
			_sH=_fH+_fsH;
			
			_ofsX=(cellZ+ (cellX-cellZ))*size;
			_ofsY=size/2;
		}
		
		public function getBoxScreenPosition(x:int, z:int , y:int):Point
		{
			var pos:Point3D=new Point3D();
			var p2d:Point=new Point();
			pos.z=z*_size;
			pos.x=x*_size;
			pos.y=-y*_size;
			p2d=IsoUtils.isoToScreen(pos);
			return new Point(p2d.x+_ofsX , p2d.y+_ofsY+_fsH);			
		}
		
		public function get floorWidth():int
		{
			return _fW;
		}
		
		public function get floorHeight():int
		{
			return _fH;
		}
		
		public function get skyHeight():int
		{
			return _fsH;
		}
		
		public function get worldHeight():int
		{
			return _sH;
		}
		
		public function get worldWidth():int
		{
			return _sW;
		}
		
		public function get offsetX():int
		{
			return _ofsX;
		}
		
		public function get offsetY():int
		{
			return _ofsY;
		}
		
		public function get size():int{
			return _size;
		}		
	}
}