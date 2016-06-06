package himmae.displayworld
{
	import himmae.boxfactory.Box;
	import himmae.boxfactory.BoxFactory;
	
	import com.friendsofed.isometric.Point3D;
	
	import himmae.controllercommand.IControllerSwitch;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.utils.Timer;
	import himmae.iterfaces.IPartsSize;

	/**有开场检视方块的世界**/
	public class IsoFloor_Gradual extends IsoFloor_Template
	{
		private var _timer:Timer;
		/**砖头生成到第几层的索引**/
		private var _index:int;
		/**是否已经生成全部方块**/
		private var _isMaking:Boolean;
		private var _tmpw:Array;
		public function IsoFloor_Gradual(sc:IPartsSize , ctrl:IControllerSwitch)
		{
			super(sc ,ctrl);
			_timer=new Timer(1000);
		}
		
		public override function createFloor(  arrTile:Array=null , arrBox:Array=null ):void{
			dispatchEvent(new Event(HM.UNPRESSABLE));
			bmpDrawFloor(arrTile);
			_tmpw=arrBox;
			_timer.delay=1000;
			_timer.addEventListener(TimerEvent.TIMER , timerHandler);
			_timer.start();
		}
		private function stopCreate():void{
			_timer.removeEventListener(TimerEvent.TIMER , timerHandler);
			_timer.reset();
			finishCreate();
		}
		private function timerHandler(e:TimerEvent):void{
			if(_timer.currentCount==1) _index=0;
			_isMaking=false;
			newBrick();
			if(_isMaking==false)stopCreate();
			_index++;
		}
		private function newBrick():void{
			var box:Box;
			var pos:Point3D=new Point3D;
			pos.y=-_index*_cellSize;
			for(var i:int=0 ; i<_tmpw.length ; i++){
				pos.x=i*_cellSize;
				for(var j:int=0 ; j<_tmpw[i].length ; j++){			
 					if(_tmpw[i][j].length<=_index)continue;
					pos.z=j*_cellSize;
//					box=Box.createBox(_tmpw[i][j][_index] , _cellSize , _cellSize);
					box=BoxFactory.instance.getBoxDisplay( _tmpw[i][j][_index] );
					box.position=pos;
					_bmpdBox.draw(box , new Matrix(1,0,0,1 , box.screenX+_offsetX , box.screenY+_offsetY+_bmpFloor.y));
					_isMaking=true;
				}
			}
		}
		
	}
}