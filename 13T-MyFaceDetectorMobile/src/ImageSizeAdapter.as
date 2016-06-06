package
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	public class ImageSizeAdapter
	{
		private var _wid:int;
		private var _hei:int;
		private var _mt:Matrix;
		private var _scale:Number;
		public function ImageSizeAdapter(width:int , height:int)
		{
			_wid=width;
			_hei=height;
			_scale=1;
		}
		public function changeImgSize(bmpd:BitmapData):BitmapData{
			var sX:Number=1;
			var sY:Number=1;
			if(bmpd.width>_wid) sX=_wid/bmpd.width;
			if(bmpd.height>_hei) sY=_hei/bmpd.height;
			if(sX<sY) _scale=sX;
			else _scale=sY;
			trace("图像缩放   "+_scale+"倍");
			var tmp:BitmapData=new BitmapData(_scale*bmpd.width , _scale*bmpd.height);
			_mt=new Matrix(_scale , 0 , 0 ,_scale);
			tmp.draw(bmpd , _mt);
			return tmp;
		}
		public function get Scale():Number{
			return _scale;
		}
		public function changeSize(param:*):*{
			if(param.x==undefined || param.width==undefined) throw new Error("Wrong param!");
			trace(_scale);
			param.x*=_scale;
			param.y*=_scale;
			param.width*=_scale;
			param.height*=_scale;
			return param;
		}
	}
}