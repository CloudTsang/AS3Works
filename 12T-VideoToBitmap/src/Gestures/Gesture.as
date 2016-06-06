package Gestures
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import TestPixel.TestPixelNull;
	import Scan.Scanner;
	
	public class Gesture extends TemplateGesture //implements IGes
	{
		private var _name:String;
		private var _data:Object;
		
		public function Gesture(obj:Object=null)
		{
			_itp=new TestPixelNull;
			_isc=new Scanner(this);
			
			if(obj==null)return ;
			_name=obj.name;
			_pixelArr=obj.pixelArr;
			_wid=obj.width;
			_hei=obj.height;
			_pixelRate=obj.pixelRate;
			_totalPixel=obj.totalPixel;
			
		}
		
		/**记录一个手势，将位图中RGB大于一定值的像素记为1，其余为0，储存到一个数组之中。
		 * @param rect : 包含这个手势的矩形
		 * @param bmpd : 识别手部的bitmapdata
		 * @param color : 手部的颜色
		 * @param sampDis : 取样距离
		 * **/
		public function storeGes(bmpd:BitmapData , color:uint , nam:String ,sampDis:int=5):void{
			_pixelArr=new Array();
			_totalPixel=0;
			_wid=bmpd.width;
			_hei=bmpd.height;
			Scan(bmpd  , color ,sampDis);
			_name=nam;
		}
		
		/**get the data object of a gesture**/
		public function get Data():Object{
			_data=
				{
					name:_name,
					pixelArr:_pixelArr,
					width:_wid,
					height:_hei,
					totalPixel:_totalPixel,
					pixelRate:_pixelRate
				};
			return _data;
		}
		
		public override function get Name():String{
			return _name;
		}
		
		/**获取手势矩形大小，并没有什么意义？**/
		public function get gesRecArea():int{
			return _wid*_hei;
		}
	}
}