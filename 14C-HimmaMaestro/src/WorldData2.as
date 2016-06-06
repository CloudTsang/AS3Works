package
{	
	import himmae.boxfactory.BoxFactory;
	import himmae.boxfactory.IExplodeHandler;
	import himmae.boxfactory.IExplosion;
	
	import himmae.displayworld.IWorld;
	import himmae.iterfaces.IWorldData;
	
	public final class WorldData2 implements IWorldData 
	{	
		/**地图每一格的数据**/
		private  var _cellData:Array;
		/**地图地板的数据**/
		private  var _floorData:Array;
		/**游玩时间**/
		private var _playTime:String;
		
		private var _width:int;
		private var _height:int;
		private var _world:IWorld;
		private var _explode:IExplodeHandler;
		
		public function WorldData2(box:Array , floor:Array , wid:int , hei:int , wo:IWorld=null , ex:IExplodeHandler=null)
		{
			var boxInd:int=0;
			var tileInd:int=0;
			
			_height=hei;
			_width=wid;
			
			_world=wo;
			_explode=ex;
			
			_cellData=new Array;
			_floorData=new Array;
			for(var i:int=0 ; i<_height ; i++){
				_cellData[i]=new Array;
				_floorData[i]=new Array;
				for(var j:int=0 ; j<_width ; j++){
					_cellData[i][j]=new Array;
					_floorData[i][j]=HM.WALK;
				}
			}
			
			for(var m:int=0 ; m<box.length ; m++){
				_cellData[ box[m].x  ][ box[m].z  ] = box[m].t;
				trace("{"+box[m].x+","+box[m].z+"="+box[m].t+"}");
			}
			for(var n:int=0 ; n<floor.length ; n++){
				_floorData[ floor[n].x ][ floor[n].z ] = floor[n].t;
			}
		}
		
		public  function cellMove(newX:int , newZ:int , oldX:int , oldZ:int , arr1:Array=null , arr2:Array=null ,explode:Boolean=false ,sort:Boolean=false):void{
			if(arr1) {
				arr1=specialTest(arr1,newX,newZ,explode,sort);
				_cellData[newX][newZ]=arr1;
			}
			else _cellData[newX][newZ]=_cellData[oldX][oldZ];
			if(arr2){
				arr2=specialTest(arr2,oldX,oldZ,explode,sort);
				_cellData[oldX][oldZ]=arr2;
			}
			else _cellData[oldX][oldZ]=new Array();
			renewStage();
		}
		
		public function setCellData(arr:Array, x:int, z:int ,explode:Boolean=false ,sort:Boolean=false):void
		{
			arr=specialTest(arr ,x ,z,explode ,sort);
			_cellData[x][z]=arr;
			renewStage();
		}
		
		
		public function getCellData(x:int, z:int):Array
		{
			return _cellData[x][z];
		}
		
		private function specialTest(arr:Array,x:int , z:int,explode:Boolean=false ,sort:Boolean=false ):Array{
			if(sort)arr=BoxFactory.instance.BoxSort(arr);
			if(explode)_explode.Explode(this , arr , x, z);
			return arr;
		}
		
		public function getFloorData(x:int , z:int):String{
			return _floorData[x][z];
		}
		
		public function renewStage():void{
			_world.renewWorld(_cellData);
		}
		
		public function get width():int{
			return _width;
		}
		public function get height():int{
			return _height;
		}
		public function get Cell():Array{
			return _cellData;
		}
		public function get Floor():Array{
			return _floorData;
		}
		//		public function get scoreLimit():int{
		//			return _scoreLimit;
		//		}
		//		public function get timeLimit():int{
		//			return _timeLimit;
		//		}
	}
}