package
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.FileFilter;
	import flash.net.FileReference;

	public class TemplateFileLoader extends EventDispatcher
	{
		protected var _file:FileReference;
		protected var _filter:FileFilter;
		protected var _loader:Loader;
		public function TemplateFileLoader(fil:FileFilter)
		{
			_file=new FileReference();
			_file.browse([fil]);
			_file.addEventListener(Event.SELECT,onSelect);  
		}
		protected function onSelect(e:Event):void{
			_file.load();  
			_file.addEventListener(Event.COMPLETE,onComplete);  
			_file.removeEventListener(Event.SELECT,onSelect);  
		}
		protected function onComplete(e:Event):void{
			_file.removeEventListener(Event.COMPLETE,onComplete);  
			_loader=new Loader;
			_loader.loadBytes(_file.data);  
			_loader.contentLoaderInfo.  
			addEventListener(Event.COMPLETE,onLoadComplete);  
		}
		protected  function onLoadComplete(e:Event):void{		
			throw new Error("You should override this function");
		}
		protected function completeNotice():void{
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onLoadComplete);  
			dispatchEvent(new Event("LoadComplete"));
		}
	}
}