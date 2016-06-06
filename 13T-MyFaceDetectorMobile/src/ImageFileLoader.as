package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;

	public class ImageFileLoader extends TemplateFileLoader
	{
		private var _bmp:Bitmap;		
		public function ImageFileLoader(bmp:Bitmap)
		{
			super(new FileFilter("Images","*.jpg;*.png;*.bmp"));
			_bmp=bmp;
		}
		protected override function onLoadComplete(e:Event):void{
			var _bmpd:BitmapData=new BitmapData (_loader.width,_loader.height,false);  
			_bmpd.draw(_loader);  
			_bmp=new Bitmap(_bmpd);  		
			_bmp.width=_bmpd.width;
			_bmp.height=_bmpd.height;
			completeNotice();
		}
		public function get Bmp():Bitmap{
			return _bmp;
		}
	}
}