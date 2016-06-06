package himmae.misc
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	public class DirectionIcon extends Bitmap
	{
		private var _right:directRight;
		private var _left:directLeft;
		private var _up:directUp;
		private var _down:directDown;
		public function DirectionIcon(xx:int=0 , yy:int=0 , bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false)
		{
			_right=new directRight;
			_down=new directDown;
			_left=new directLeft;
			_up=new directUp;
			
			super(_left, pixelSnapping, smoothing);
			this.x=xx;
			this.y=yy;
		}
		public function changeDirect(d:Point):void{
			if(d.y==-1) this.bitmapData=_up;
			else if(d.y==1) this.bitmapData=_down;
			else if(d.x==-1) this.bitmapData=_left;
			else if(d.x==1) this.bitmapData=_right;
		}
	}
}