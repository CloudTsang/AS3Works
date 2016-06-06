package
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	public class Character extends AnimationObject
	{
		/**加载图片**/
		private var loader:Loader;
		/**显示的bitmap**/
		public var img:Bitmap=new Bitmap;
		/**存储所有动作的bitmapData的二维数组**/
		private var imageArr:Array=new Array;
		/**当前一个动作在imageArr[movement]的索引**/
		private var currentIndex:int=0;
		/**当前一组动作在imageArr的索引**/
		private var movement:int=0;
		
		private	var hei:Number
		private	var wid:Number
		
		/**起始点**/
		private var start:Point;
		/**终点**/
		private var end:Point;	
		/**寻路路径**/
		private var astar:Vector.<Node>;
		/**节点索引**/
		private var astarIndex:int=0;
		
		private var timer:Timer=new Timer(100);
		private var distX:Number;
		private var distY:Number;
		private var xspeed:Number=10;
		private var yspeed:Number=10;
		
		private const Down:int=0;
		private const Left:int=1;
		private const Right:int=2;
		private const Up:int=3;
		private const Attack:int=4;
		
		public function Character()
		{
			super();
			LoadImage();
			timer.addEventListener(TimerEvent.TIMER,moveHandler);
		}
		
		/**加载spirit表**/
		private function LoadImage(u:String="image.png") :void
		{  
			loader=new Loader();
			var url:URLRequest=new URLRequest(u);  
			//加载  
			loader.load(url);  
			//注册加载事件,在加载完调用  
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onload);  
		}  	
		/**加载完毕后分割图表，添加到imageArr中**/
		private	function onload(evt:Event)  :void
		{  
			this.bitmapData=Bitmap(loader.content).bitmapData;  
			wid=this.bitmapData.width/4;
			hei=this.bitmapData.height/4;

			for(var i:int=0 ; i<=3 ; i++){
				imageArr.push(AnimationFactory.imgListFactory(this.bitmapData,i,4,wid,hei));
			}
			
			img.bitmapData=imageArr[0][0];
			this.dispatchEvent(new Event("load complete"));
		} 	
		
		/**鼠标点击的移动事件**/
		public function moveToHere(e:MouseEvent):void{		
			timer.stop();
			//生成起点和终点
			start=new Point( (img.x+img.width/2) , (img.y+img.width/2) );
			end=new Point(e.stageX,e.stageY);	
			img.x=start.x-wid/2;
			img.y=start.y-hei;
			astarIndex=0;		
			astar=Map.getRoute(start , end );
			if(astar!=null){
				PointToNextTarget(1)
				timer.start();
				dispatchEvent(new Event("path found"));
			}	
		}
		
		/**指向下一个目的节点的函数**/
		private function PointToNextTarget(t:int):void{
			end=astar[t].aNode;
			//目的节点的舞台坐标
			end.x*=Map.nodeDist;
			end.y*=Map.nodeDist;
			
			distX=end.x-img.x;
			distY=end.y-img.y;

			//左右方向
			if( Math.abs(distX) > Math.abs(distY) )
			{
				if(distX > 0) movement=Right;
				else movement=Left;
			}
				//上下方向
			else
			{
				if(distY > 0)movement=Down;
				else movement=Up;
			}
			
			var tan:Number=Math.atan2( distY , distX );
			xspeed = 20 * Math.cos(tan);
			yspeed = 20  * Math.sin(tan);	
		}
		
		private function moveHandler(e:TimerEvent):void{

			if( Point.distance(new Point(img.x , img.y) , end) <=20 ) {
				if(astarIndex==astar.length-1)	{
					timer.stop();
					img.bitmapData=imageArr[movement][0];
					return;
				}			
				astarIndex++;
				PointToNextTarget(astarIndex);
			}
			img.bitmapData=imageArr[movement][currentIndex];
			if(currentIndex<3)currentIndex++;
			else currentIndex=0;		
			img.x+=xspeed
			img.y+=yspeed
		}		
		
		private function playAction(m:int):void{
			
		}
		
	}
}