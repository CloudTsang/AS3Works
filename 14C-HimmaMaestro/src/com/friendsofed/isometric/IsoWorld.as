package com.friendsofed.isometric
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class IsoWorld extends Sprite
	{
		private var _floor:Sprite;
		private var _objects:Array;
		private var _world:Sprite;
		
		private var sizeX:int;
		private var sizeZ:int;
		private var cellSize:int
		private var offsetX:int;
		private var offsetY:int;
		
		public function IsoWorld(wid:int , hei:int , size:int , xx:int=0 ,yy:int=0)
		{
			_floor = new Sprite();
			addChild(_floor);
			
			_world = new Sprite();
			addChild(_world);
			
			_objects = new Array();
			
			sizeX=wid;
			sizeZ=hei;
			cellSize=size;
			
			drawFloor();
			this.addEventListener(MouseEvent.CLICK , drawBox);
		}
		
		private function drawFloor():void{
			var tile:DrawnIsoTile;
			for(var i:int=0 ; i<sizeX ; i++)
			{
				for( var j:int=0 ; j<sizeZ ; j++)
				{
					tile=new DrawnIsoTile(cellSize , 0x00ff00);
					tile.position =new Point3D(i*cellSize , 0 ,j*cellSize);
					this.addChildToFloor(tile);
				}
			}
		}
		public function drawBox(e:MouseEvent):void{					
			var box:DrawnIsoBox=new DrawnIsoBox(cellSize , 0x0000ff , cellSize);
			var pos:Point3D=IsoUtils.screenToIso(new Point(mouseX, mouseY));
			pos.x=Math.round(pos.x/cellSize)*cellSize;
			pos.y=Math.round(pos.y/cellSize)*cellSize;			
			pos.z=Math.round(pos.z/cellSize)*cellSize;
			trace(pos.z/cellSize , pos.x/cellSize);
			box.position=pos;			
			addChildToWorld(box);
		}
		
		public function addChildToWorld(child:IsoObject):void
		{
			_world.addChild(child);
			_objects.push(child);
			sort();
		}
		
		public function addChildToFloor(child:IsoObject):void
		{
			_floor.addChild(child);
		}
		
		public function sort():void
		{
			_objects.sortOn("depth", Array.NUMERIC);
			for(var i:int = 0; i < _objects.length; i++)
			{
				_world.setChildIndex(_objects[i], i);
			}
		}
		/**
		 *对等角对象进行碰撞测试并返回Boolean值。
		 * 通过检测的条件有三个：
		 * 1.所检查的对象不是传入的对象；
		 * 2.所检查的对象的walkable为true；
		 * 3.计算出的偏移矩形与所检查对象的rect不相交。
		 * 
		 * @param obj：需要做碰撞检测的等角对象
		 *  @return 检测结果
		 **/
		public function canMove(obj:IsoObject):Boolean
		{
			var rect:Rectangle = obj.rect;
			rect.offset(obj.vx, obj.vz);
			for(var i:int = 0; i < _objects.length; i++)
			{
				var objB:IsoObject = _objects[i] as IsoObject;
				if(obj != objB && !objB.walkable && rect.intersects(objB.rect))
				{
					return false;
				}
			}
			return true;
		}
	}
}