package Gestures
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import TestPixel.TestPixelNormal;
	import Scan.Scanner;
	
	public class GesToTest extends TemplateGesture //implements IGes
	{
		public function GesToTest(bmpd:BitmapData,  color:uint, sampDis:int=1)
		{
			_pixelArr=new Array();
			_itp=new TestPixelNormal;
			_isc=new Scanner(this);
			_totalPixel=0;
			_wid=bmpd.width;
			_hei=bmpd.height;
			Scan(bmpd , color ,sampDis);
		}
		
	}
}