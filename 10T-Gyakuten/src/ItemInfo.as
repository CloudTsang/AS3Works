package
{
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	public class ItemInfo extends Bitmap
	{
		private var bmpd:BitmapData;
		private var padSp:ItemPad=new ItemPad;
		private var m:Matrix=new Matrix(1,0,0,1,43.5,43.5);
//		public function ItemInfo(_xml:XML)
//		{
//			super();
//			this.x=1024;
//			this.y=100;
//			padSp.itemName.text=_xml.Name;
//			padSp.itemDescript.text=_xml.Descript;
//			bmpd=new BitmapData( padSp.width , padSp.height );
//			bmpd.draw( padSp );
//			var tmpData:BitmapData=new BitmapData(160,160);		
//			bmpd.copyPixels( Resources.bmpdSheet , new Rectangle( _xml.x*160 , _xml.y*160 , 160 ,160 ) , new Point( 43.5 , 43.5 ) );
//			this. bitmapData=bmpd;
//			TweenLite.to(this , 0.25 , {x:210});	
//		}
		
		public function ItemInfo(_obj:Object)
		{
			super();
			this.x=1024;
			this.y=100;
			padSp.itemName.text=_obj.Name;
			padSp.itemDescript.text=_obj.Descript;
			bmpd=new BitmapData( padSp.width , padSp.height );
			bmpd.draw( padSp );
			var tmpData:BitmapData=new BitmapData(160,160);		
			bmpd.copyPixels( Resources.bmpdSheet , new Rectangle( _obj.x*160 , _obj.y*160 , 160 ,160 ) , new Point( 43.5 , 43.5 ) );
			this. bitmapData=bmpd;
			TweenLite.to(this , 0.25 , {x:210});	
		}
		
		public function moveOut():void{		
			TweenLite.to(this , 0.25 , {x:-650});	
			setTimeout(dispose , 250 );
		}
		private function dispose():void{
			this.bitmapData=null;	
		}
		
	}
}