package Scan
{
	import flash.display.BitmapData;

	public interface IScanner
	{
		function Scan(bmpd:BitmapData , color:uint , dis:int):void;
	}
}