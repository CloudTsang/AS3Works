package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.net.NetConnection;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	import org.osmf.events.TimeEvent;
	
	[SWF(width="1200", height="600",  backgroundColor="0xffffff" , frameRate="60")]
	public class AstarPrac extends Sprite
	{		
		private var gridView:GridView=new GridView(new Grid(1,1));
		public var hero:Character;
		private var time1:int;
		public function AstarPrac()
		{
			if(stage){
				stage.align = StageAlign.TOP_LEFT;
				stage.scaleMode = StageScaleMode.NO_SCALE;
			}
			
			startGame();
		}		
		
		private function startGame():void{
			hero=new Character();
			hero.addEventListener("path found",showPath);
			hero.addEventListener("load complete",showHero);
			Map.init2();
		}
		private	function showHero(e:Event):void{
			stage.addEventListener(MouseEvent.CLICK,hero.moveToHere);
			hero.img.x=0;
			hero.img.y=0;
			addChild(hero.img);
		}
		private function showPath(e:Event):void{
			time1=getTimer();
			if(gridView.stage!=null)removeChild(gridView);
			gridView=new GridView(Map.grid);
			gridView.drawGrid();
			gridView.findPath();
			addChildAt(gridView,0);
			trace(getTimer()-time1);
		}
		
	}
}