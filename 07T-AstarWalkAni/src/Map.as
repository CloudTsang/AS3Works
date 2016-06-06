package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLRequest;
	
	public class Map
	{
		public static var grid:Grid
		/**节点间的距离**/
		public static const nodeDist:int=40;
		private static var loader:Loader;
		public function Map()
		{
			
		}
		/**地图初始化函数
		 * @param x和y：地图的长和宽的节点坐标
		 * @param isblock：是否设置障碍物，默认为false，即地图上没有障碍物
		 * @param block：障碍物节点坐标的Point数组**/
		public static function  init(x:int , y:int , isblock:Boolean=false , block:Vector.<Point>=null ):void{
			grid=new Grid(x , y);
			if(isblock==true){
				if(block==null)block=randBlock();
				for(var i:int=block.length-1 ; i>=0 ; i--){
					grid.setWalkable(block[i].x , block[i].y , false);
				}
			}		
		}
		
		public static function  init2():void{
			loadMap();
		}
		/**加载“地图”**/
		private static function loadMap(u:String="map.png"):void{
			loader=new Loader();
			
			//加载  
			loader.load(new URLRequest(u) );  
			//注册加载事件,在加载完调用  
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onload);  
		}
		private static function onload(e:Event):void{
				var bmp:BitmapData=Bitmap(loader.content).bitmapData;
			var i:int=bmp.width/nodeDist;
			var j:int=bmp.height/nodeDist;
			grid=new Grid(i , j);
			for(i=bmp.width/nodeDist ; i>0 ; i--)
			{
				for(j=bmp.height/nodeDist ; j>0 ; j--)
				{				
					if(bmp.getPixel( i*nodeDist , j*nodeDist ) == 0x000000) grid.setWalkable(i -1, j-1 , false);
				}
			}
			
		}
		
		/**地图初始化函数，像素版**/
		public static function  initPixel(x:int , y:int , isblock:Boolean=false , block:Vector.<Point>=null ):void{
			grid=new Grid(x/nodeDist , y/nodeDist);
			if(isblock==true){
				if(block==null)block=randBlock();
				for(var i:int=block.length-1 ; i>=0 ; i--){
					grid.setWalkable(block[i].x/nodeDist , block[i].y/nodeDist , false);
				}
			}		
		}
		
		/**随机生成障碍物坐标的函数
		 * @return 障碍物节点坐标Point数组**/
		private static function randBlock():Vector.<Point>{	
			var vec:Vector.<Point>=new Vector.<Point>;
			for(var l:int=int(Math.random()*20+20) ; l>=0 ; l--){
				vec.push(new Point( int(Math.random()*grid.numCols) , int(Math.random()*grid.numRows) ) );			
			}
			return vec;
		}
		/**AStar寻路
		 * @param start：起始地点，要先用坐标生成Point类型
		 * @param end：目的地点
		 * @return 计算得节点路径的数组**/
		public static function getRoute(start:Point , end:Point):Vector.<Node>{
			var astar:AStar=new AStar;
			grid.setStartNode( start.x/nodeDist , start.y/nodeDist );
			grid.setEndNode(end.x/nodeDist , end.y/nodeDist);
			if(astar.findPath(grid)==true)return astar.path
			else return null;
		}
	}
}