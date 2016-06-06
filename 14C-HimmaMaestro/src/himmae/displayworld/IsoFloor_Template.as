package himmae.displayworld
{
	import himmae.boxfactory.Box;
	import himmae.boxfactory.BoxFactory;
	
	import com.friendsofed.isometric.DrawnIsoTile;
	import com.friendsofed.isometric.Point3D;
	
	import himmae.controllercommand.IControllerSwitch;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	import himmae.observer.IObserver2;
	import himmae.iterfaces.IPartsSize;

	public class IsoFloor_Template extends Sprite implements IWorld
	{
		protected var _bmpdBox:BitmapData;
		protected var _bmpBox:Bitmap;
		protected var _bmpdFloor:BitmapData;
		protected var _bmpFloor:Bitmap;
		
		protected  var _offsetX:int;
		protected  var _offsetY:int;
		protected  var _cellSize:int;
		
		protected var _ctrl:IControllerSwitch;
		
		public function IsoFloor_Template(sc:IPartsSize , ctrl:IControllerSwitch)
		{
			_ctrl=ctrl;
			_cellSize=sc.size;			
			_offsetX=sc.offsetX;
			_offsetY=sc.offsetY;
			
			_bmpdFloor=new BitmapData( sc.floorWidth , sc.floorHeight , true , 0);
			_bmpFloor=new Bitmap(_bmpdFloor);
			_bmpFloor.y=sc.skyHeight;
			this.addChild(_bmpFloor);
			
			_bmpdBox=new BitmapData(_bmpdFloor.width+5 , sc.worldHeight ,true ,0x00);
			_bmpBox=new Bitmap(_bmpdBox);
			this.addChild(_bmpBox);	
			this.x=HM.HUD_WIDTH;
		}			
		
		public function createFloor( arrTile:Array=null , arrBox:Array=null ):void
		{
			throw new Error("This function should be overrided!");
		}
		
		public final function renewWorld( arr:Array=null ):void
		{
			_bmpdBox.fillRect(_bmpdBox.rect , 0x000000);
			var box:Box; 
			var pos:Point3D=new Point3D;
			for(var i:int=0 ; i<arr.length ; i++){
				pos.x=i*_cellSize;
				for(var j:int=0 ; j<arr[i].length ; j++){
					pos.z=j*_cellSize;
					for(var h:int=0 ; h<arr[i][j].length ; h++){
						pos.y=-h*_cellSize;
						box=BoxFactory.instance.getBoxDisplay( arr[i][j][h] );
						box.position=pos;
						_bmpdBox.draw(box , new Matrix(1,0,0,1 , box.screenX+_offsetX , box.screenY+_offsetY+_bmpFloor.y));
					}
				}
			}
		}
		
		public final function finishCreate():void{
			_ctrl.pressable();
			dispatchEvent(new Event(HM.FINISH_OPENING));
		}
		
		protected final function bmpDrawFloor(arr:Array=null):void{	
			var tile:Tile;
			var tileClick:DrawnIsoTile=new DrawnIsoTile(_cellSize , 0x000000);
			for(var i:int=0 ; i<arr.length ; i++)
			{				
				for( var j:int=0 ; j<arr[i].length ; j++)
				{	
					tile=new Tile(arr[i][j] , _cellSize);
					tile.position =new Point3D(i*_cellSize , 0 ,j*_cellSize);
					_bmpdFloor.draw(tile , new Matrix(1,0,0,1 , tile.screenX+_offsetX ,tile.screenY+_offsetY));
				}
			}
		}
	}
}