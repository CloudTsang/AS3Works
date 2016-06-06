package
{
	
	import com.adobe.serialization.json.JSON;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	
	
	public class Resources extends Sprite
	{
		//		[Embed(source="SceneUrlIndex.xml", mimeType="application/octet-stream")]
		[Embed(source="SceneUrlIndex.txt", mimeType="application/octet-stream")]
		private var urlIndex:Class;
		private var sceneJs:Array=com.adobe.serialization.json.JSON.decode(new urlIndex) ;
		//				private var xmlUrlIndex:XML=new XML(new urlIndex); 	
		private var picLoader:Loader=new Loader;
		private var blockLoader:Loader=new Loader;
		private var sheetLoader:Loader=new Loader;
		private var xmlLoader:URLLoader=new URLLoader;
		private var jsLoader:URLLoader=new URLLoader;
		
		public static var xmlItem:XML;
		public static var bmpScene:Bitmap=new Bitmap;
		public static var bmpdScene:BitmapData;
		public static var bmpdSheet:BitmapData;
		public static var itemJs:Object;
		public static var currentLocate:String;
		
		
		public function Resources()
		{
		}
		public static function Init():void{
			
		}
		public function SceneSwitch(name:String ):void{
			trace(sceneJs);
			for(var i:int=0 ; i<sceneJs.length ; i++){
				trace(sceneJs[i].id);
				if(sceneJs[i].id==name){
					jsLoader.load(new URLRequest( sceneJs[i].Json ) );
					blockLoader.load(new URLRequest( sceneJs[i].Block ) );
					sheetLoader.load(new URLRequest( sceneJs[i].ItemSheet ) );
					picLoader.load(new URLRequest( sceneJs[i].Picture ) );
					picLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComp);
					currentLocate=name;
					return;
				}
			}
			//			var tmpXml:XML=new XML( xmlUrlIndex.Scene.(@id==tmp) );
			//			jsLoader.load(new URLRequest( tmpXml.Json) );
			//			xmlLoader.load(new URLRequest( tmpXml.Item ) );
			//			blockLoader.load(new URLRequest( tmpXml.Block ) );
			//			sheetLoader.load(new URLRequest(tmpXml.ItemSheet) );
			//			picLoader.load(new URLRequest( tmpXml.Picture) );
			//			picLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComp);
		}
		
		private function loadComp(e:Event):void{
			xmlItem=new XML(xmlLoader.data);
			bmpdSheet=Bitmap(sheetLoader.content).bitmapData;
			bmpScene.bitmapData=Bitmap(picLoader.content).bitmapData;
			bmpdScene=Bitmap(blockLoader.content).bitmapData;		
			itemJs=com.adobe.serialization.json.JSON.decode( URLLoader(jsLoader).data );
			//	trace(itemJs.Scene1Item[3].Markable);
			this.dispatchEvent(new Event("loadTotallyComplete"));
		}
		
		public static function idSearch(color:int , scene:String):Object{
			for(var i:int=0 ; i<itemJs[scene].length ; i++){			
				if( itemJs[scene][i].id==color){
					return itemJs[scene][i];
				}
			}
			return itemJs.Blank;
		}
		
		/*
		{
		"id": ,
		"Name": "" ,
		"Lacate": ""  ,
		"Markable":  ,
		"ifMark": ,
		"x":  ,
		"y":  ,
		"Descript" : ""  ,
		"Search": ""    
		} ,
		*/
		
		
	}
}