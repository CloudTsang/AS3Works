package
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	public class SpVec
	{
		private var _vec:Vector.<Sprite>;
		public function SpVec()
		{
			_vec=new Vector.<Sprite>;
		}
		/**
		 * 创建活动区域矩形
		 * @return 一个MC类型的数组，里面是利用两次检测的结果作为边界的矩形
		 * **/
		public function Renew(rect:Vector.<Rectangle>):void{
			if(rect.length==0)return;
			_vec=new Vector.<Sprite>;
			var sp:Sprite;
			sp=new Sprite;
			sp.graphics.lineStyle(1,0x0000ff);
			for(var k:int=0 ; k<rect.length ; k++){
				sp.graphics.drawRect( rect[k].x , rect[k].y , rect[k].width , rect[k].height);
				_vec.push(sp);
			}
		}
		
		public function get Vec():Vector.<Sprite>{
			return _vec;
		}
	}
}