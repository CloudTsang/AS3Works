package
{
	import flash.geom.Rectangle;

	public class RectVec
	{
		private var  _vec:Vector.<Rectangle>;
		public function RectVec()
		{
			_vec=new Vector.<Rectangle>;
		}
		
		public function Renew(border1:Vector.<int> , border2:Vector.<int>) :void{
			if(border1==null || border2==null)return;
			var tmp:Vector.<Rectangle>=new Vector.<Rectangle>;
			var rect:Rectangle;
			for(var k:int=0 ; k<(border1.length-1) ; k+=2){
				rect=new Rectangle(border1[k] , border2[k] , border1[k+1]-border1[k] , border2[k+1]-border2[k]);
				if(rect.width< 100 || rect.height<100){
					continue;
				}
				tmp.push(rect);
			}
			if(tmp.length>0)_vec=tmp;
		}
		
		/**手部动作矩形的数组**/
		public function get Vec():Vector.<Rectangle>{
			return _vec;
		}
	}
}