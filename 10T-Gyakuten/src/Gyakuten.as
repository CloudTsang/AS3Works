package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Scene;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.Responder;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	import flash.utils.setTimeout;
	
	import flashx.textLayout.operations.MoveChildrenOperation;
	
	[SWF(width="1024", height="683",  backgroundColor="0xffffff" , frameRate="60")]
	public class Gyakuten extends Sprite
	{
		private var GameStage:Resources=new Resources();
		public function Gyakuten()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;					
			GameStage.SceneSwitch("BedRoom");
		
			GameStage.addEventListener("loadTotallyComplete",renew_Stage);
//			addChild(new Stats());			
		}
		private function renew_Stage(e:Event):void{
			if(Resources.bmpScene.stage==null)addChildAt(Resources.bmpScene,0);		
			stage.addEventListener(MouseEvent.CLICK , SearchHandler);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,stage_Change);
		}
		
		private function stage_Change(e:KeyboardEvent):void{
			switch (e.keyCode){
				case Keyboard.A:
					GameStage.SceneSwitch("LivingRoom");
					break;
				case Keyboard.S:
					GameStage.SceneSwitch("BedRoom");
					break;
			}
		}
		private function SearchHandler(e:MouseEvent):void{
			var tmpObj:Object=Resources.idSearch(Resources.bmpdScene.getPixel(mouseX,mouseY) , Resources.currentLocate);		
			if(e.ctrlKey==true && tmpObj.Markable==true){
				var pad:ItemInfo=new ItemInfo(tmpObj);
				stage.removeEventListener(MouseEvent.CLICK , SearchHandler);
				stage.addEventListener(MouseEvent.CLICK , itemConfirm);
				addChild(pad);
				return;
			}
	//		var tmpxml:XML=new XML(Resources.xmlItem.Item.( @id==Resources.bmpdScene.getPixel(mouseX,mouseY)) );
//			if(tmp != 16777215)
//			{		
//				if(e.ctrlKey==true && tmpxml.Markable==true){				
//					var pad:ItemInfo=new ItemInfo(tmpxml)
//					stage.removeEventListener(MouseEvent.CLICK , SearchHandler);
//					stage.addEventListener(MouseEvent.CLICK , itemConfirm);
//					addChild(pad);
//					return;
//				}				
//			}		
			
			var log:LogPad=new LogPad( tmpObj.Search , "我"  );
			addChild(log);
			stage.removeEventListener(MouseEvent.CLICK , SearchHandler);
			stage.addEventListener(MouseEvent.CLICK , logConfirm);
			
			function itemConfirm(e:Event):void{
				pad.moveOut();
				stage.removeEventListener(MouseEvent.CLICK , itemConfirm);
				stage.addEventListener(MouseEvent.CLICK , SearchHandler);
			}		
			function logConfirm(e:Event):void{
				log.dispose();
				stage.removeEventListener(MouseEvent.CLICK , logConfirm);
				stage.addEventListener(MouseEvent.CLICK , SearchHandler);
			}		
		}
		
	}	
}
