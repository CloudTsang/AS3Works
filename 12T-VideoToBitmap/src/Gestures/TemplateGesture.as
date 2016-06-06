package Gestures
{
	import flash.display.BitmapData;
	import TestPixel.ITestPixel;
	import Scan.IScanner;
	
	public class TemplateGesture implements IGes
	{
		protected var _wid:int;
		protected var _hei:int;
		protected var _totalPixel:int;
		protected var _pixelRate:Number;
		protected var _pixelArr:Array;
		protected var _itp:ITestPixel;
		protected var _isc:IScanner;
		public function TemplateGesture()
		{
		}
		
		public function createTestPixel(dis:int):Array
		{
			return _itp.createTestPixel(dis , _pixelArr);	
		}
		
		public function Scan(bmpd:BitmapData, color:uint, sampDis:int):void
		{
			_isc.Scan(bmpd , color , sampDis);
		}
		
		public function get Name():String
		{
			throw new Error("This function should be overrided.");
			return null;
		}
		
		public final function get Width():int
		{
			return _wid;
		}
		
		public final function get Height():int
		{
			return _hei;
		}
		
		public final function get pixelArr():Array
		{
			return _pixelArr;
		}
		
		public final function get pixelRate():Number
		{
			return _pixelRate;
		}
		
		public final function set pixelRate(pr:Number):void
		{
			_pixelRate=pr;
		}
		
		public final function get totalPixel():int
		{
			return _totalPixel;
		}
		
		public final function set totalPixel(tp:int):void
		{
			_totalPixel=tp;
		}
	}
}