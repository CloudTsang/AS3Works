package com.friendsofed.isometric
{
	import flash.desktop.InvokeEventReason;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Endian;
	
	public class IsoWorldBmp extends Sprite
	{
		private var _objects:Array;
		
		private var bmpdBox:BitmapData;
		public var bmpBox:Bitmap;
		private var bmpdFloor:BitmapData;
		public var bmpFloor:Bitmap;
		private var fMc:Sprite;
		private var bmpdClick:BitmapData;
		
		private var worldHeight:int;
		private var worldWidth:int;
		private var floorHeight:int;
		private var floorWidth:int;
		private var skyHeight:int;
		
		private var boxLimit:int;
		
		private var sizeX:int;
		private var sizeZ:int;
		private var cellSize:int
		private var offsetX:int;
		private var offsetY:int;
		
		private var floorArr:Array;
		
		public function IsoWorldBmp(wid:int , hei:int , size:int  , wW:int=0 ,wH:int=600 , scrDivide:Boolean=false)
		{			
			floorArr=new Array();
			sizeX=wid;
			sizeZ=hei;
			cellSize=size;
			
			worldHeight=wH;
			floorHeight=cellSize*(sizeX+sizeZ)/2;
			skyHeight=worldHeight-floorHeight;
			
			floorWidth=cellSize*(sizeX+sizeZ);
			if(scrDivide==true)worldWidth=wW;
			else if(wW<floorWidth) worldWidth=floorWidth;		
			else worldWidth=wW;
			
			boxLimit=int( skyHeight /cellSize)-1;
						
			offsetX=sizeZ*cellSize;
			offsetY=cellSize/2;
			
//			bmpdFloor=new BitmapData( floorWidth , floorHeight , false , 0xffffffff);
			bmpdFloor=new BitmapData( floorWidth , floorHeight , true , 0);
			//			bmpdFloor=new BitmapData(cellSize*(sizeX+sizeZ) , floorHeight , true , 0x00);
			bmpdClick=new BitmapData( floorWidth , floorHeight , false , 0xffffffff);
			bmpDrawFloor();
			fMc=new Sprite;
			fMc.y=skyHeight;
			fMc.x=-floorWidth/2;
			fMc.addEventListener(MouseEvent.CLICK , bmpDrawBox);
			fMc.addChild(bmpFloor);
			this.addChild(fMc);
			
			
			bmpdBox=new BitmapData(bmpdFloor.width , worldHeight ,true ,0x00);
			bmpBox=new Bitmap();
			bmpBox.bitmapData=bmpdBox;
			bmpBox.x=-floorWidth/2;
			this.addChild(bmpBox);		
		}
		
		private function bmpDrawFloor():void{	
			var tile:DrawnIsoTile=new DrawnIsoTile(cellSize , 0x00ff00);
			//						var tmpbmpd:BitmapData=new BitmapData(2*cellSize , cellSize , true , 0x00);
			//						tmpbmpd.draw(tile ,  new Matrix(1,0,0,1 , cellSize , cellSize/2));
			var tileClick:DrawnIsoTile=new DrawnIsoTile(cellSize , 0x000000);
			for(var i:int=0 ; i<sizeX ; i++)
			{
				floorArr[i]=new Array();
				for( var j:int=0 ; j<sizeZ ; j++)
				{
					floorArr[i][j]=0;
					tile.position =new Point3D(i*cellSize , 0 ,j*cellSize);
					bmpdFloor.draw(tile , new Matrix(1,0,0,1 , tile.screenX+offsetX ,tile.screenY+offsetY));
					bmpdClick.draw(tileClick , new Matrix(1,0,0,1 , tile.screenX+offsetX ,tile.screenY+offsetY));
					//										bmpdFloor.copyPixels(tmpbmpd ,tmpbmpd.rect , new Point(tile.screenX+offsetX-cellSize ,tile.screenY+offsetY-0.5*cellSize) , tmpbmpd , new Point(0,0) , true);
				}
			}
//			for(var k:int=0 ; k<floorArr.length ; k++)trace(floorArr[k]);
			bmpFloor=new Bitmap(bmpdFloor);		
		}
		
		public function bmpDrawBox(e:MouseEvent):void{
			//			trace(bmpdClick.getPixel(fMc.mouseX , fMc.mouseY));
			if(bmpdClick.getPixel(fMc.mouseX , fMc.mouseY)==0xffffff)return;
			var pos:Point3D=IsoUtils.screenToIso(new Point(fMc.mouseX , fMc.mouseY));			
			pos.x=int(pos.x/cellSize-sizeZ/2);
			pos.z=int(pos.z/cellSize+sizeZ/2); 	
			if(e.ctrlKey==true){
		bmpdBox.fillRect(bmpdBox.rect , 0x000000);
				floorArr[pos.x][pos.z]=0;
			}
			else if(floorArr[pos.x][pos.z]<boxLimit) floorArr[pos.x][pos.z]+=1 ;	
			else return;
			renewWorld();
		}
		
		public function renewWorld():void{
			var tile:DrawnIsoTile=new DrawnIsoTile(cellSize , 0x00ff00);
			var box:DrawnIsoBox=new DrawnIsoBox(cellSize , 0x0000ff , cellSize);
			var pos:Point3D=new Point3D;
			
			for(var i:int=0 ; i <floorArr.length ; i++){
				for(var j:int=0 ; j<floorArr[i].length ; j++){
					pos.z=j*cellSize;
					if(floorArr[i][j]==0) continue;
					else if(floorArr[i][j]>=1){
						pos.x=i*cellSize;						
						for(var h:int=0;h<floorArr[i][j];h++)
						{						
							pos.y=-h*cellSize;
							box.position=pos;		
							bmpdBox.draw(box , new Matrix(1,0,0,1 , box.screenX+offsetX , box.screenY+offsetY+skyHeight));
						}
					}
				}
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