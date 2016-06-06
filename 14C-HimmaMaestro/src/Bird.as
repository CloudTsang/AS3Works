package
{
	import himmae.boxfactory.Box;
	import himmae.boxfactory.BoxFactory;
	
	import com.friendsofed.isometric.IsoWorld;
	import com.friendsofed.isometric.Point3D;
	import com.greensock.TweenLite;
	
	import himmae.iterfaces.IPartsSize;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import himmae.misc.BGM;
	
	import himmae.observer.IObserver2;
	import himmae.observer.ISubject2;
	import himmae.iterfaces.IBird;
	import himmae.iterfaces.IWorldData;
	
	public class Bird extends Sprite implements IObserver2 , IBird
	{
		private var _timeSub:ISubject2;		
		private var _world:IWorldData;
		private var _scal:IPartsSize;
		
		private var _bird:Array;
		private var _index:int;
		private var _currentBird:Object;
		
		private var _stageWidth:int;
		private var _stageHeight:int;
		private var _cellSize:int;
		
		private var _bmp:Bitmap;
		private var _myTween:TweenLite;
		/**本关卡还有没有大鸟**/
		private var _isBird:Boolean;
		
		private   var _rate:Number;
		/**
		 * @param wid,hei : 舞台尺寸
		 * @param arr ： 鸟事件数组
		 * @param it : 时间观察对象
		 * **/
		public function Bird(arr:Array=null , it:ISubject2=null , id:IWorldData=null , sizecal:IPartsSize=null)
		{
			_world=id;
			
			_scal=sizecal;
			_stageHeight=_scal.worldHeight;		
			_stageWidth=_scal.worldWidth
			_cellSize=_scal.size;
			
			_timeSub=it;
			_timeSub.regObserver(this);
			
			_bird=arr;
			_index=0;			
			_rate=1;
			if(_bird.length>0)_isBird=true;
			prepareNextBird();
		}
		
		private function prepareNextBird():void{
			if(!_isBird)return;
			if(_index == _bird.length ) _isBird=false;
			_currentBird=_bird[_index];
			_index++;
		}
		
		public function update(param:*):void{
			if(param is int){
				if(isBirdComing(param)) createBird();
			}
		}
		
		public function isBirdComing(t:int):Boolean{		
			if(!_isBird)return false;
			if(_currentBird.time==t-_currentBird.speed) {
				BGM.instance.birdCome(_currentBird.direction);
				return false;
			}
			if(_currentBird.time!=t) return false;
			if(int(Math.random()*4)<_rate) return false;
			return true;
		}
		
		public  function set Rate(r:Number):void{
			_rate=r;
		}
		public function get Rate():Number{
			return _rate;
		}
		
		public function createBird():Bitmap{
			var targetPos:Point=new Point(_currentBird.target.x ,_currentBird.target.z)
			targetPos=_scal.getBoxScreenPosition( targetPos.x , targetPos.y ,  _world.getCellData(targetPos.x , targetPos.y).length );		
			_bmp=createBoxs(_currentBird.type);
			_bmp.x=_currentBird.direction*_stageWidth;
			_bmp.y=0;		
			_myTween=new TweenLite(_bmp , _currentBird.speed , {x:targetPos.x-_cellSize+HM.HUD_WIDTH , y:targetPos.y-_bmp.height , onComplete:onDropComplete})
			this.addChild(_bmp);
			return _bmp;
		}
		
		public function fallingCtrl(f:Boolean):void{
			if(_myTween)_myTween.paused=f;
		}
		
		public function stopFalling():void{
			if(_myTween) {
				removeChild(_bmp);
				_myTween.kill();
				_myTween=null;
			}
		}
		
		public function onDropComplete():void{ 
			stopFalling();
			var tmp:Array=_world.getCellData( _currentBird.target.x ,  _currentBird.target.z);
			tmp=tmp.concat(_currentBird.type);
	//		tmp=BoxFactory.instance.BoxSort(tmp);
			_world.setCellData(tmp , _currentBird.target.x , _currentBird.target.z , true , true);	
			//_world.renewStage();
			prepareNextBird();
			dispatchEvent(new Event(HM.FINISH_DROPING));
		}
		
		private function createBoxs(arr:Array):Bitmap{
			var fbmpd:BitmapData=new BitmapData(_cellSize*2+1, (1.25*_cellSize)*(arr.length+1) , true , 0x00000000);
			var box:Box;
			var p:Point3D=new Point3D;
			var tmpArr:Array;
			var ofsX:Number=_cellSize;
			var ofsY:Number=-_cellSize*0.75+fbmpd.height;
			for(var i:int=0; i<arr.length;i++){
				box=BoxFactory.instance.getBoxDisplay(arr[i]);
				p.y=-i*box.height;				
				box.position=p;
				fbmpd.draw( box, new Matrix(1,0,0,1,box.screenX+ofsX ,box.screenY+ofsY) );
			} 
			return new Bitmap(fbmpd);
		}	
	}
}