package
{
	public class MyTools
	{
		public function MyTools()
		{
		}
		static public function ArrRandomize(_arr:Array):void{
			var tmp:*;
			var randnum:int;
			for (var i:int = 0; i < _arr.length; i++) 
			{
				tmp=_arr[i];
				randnum=Math.random()*_arr.length;
				_arr[i]=_arr[randnum];
				_arr[randnum]=tmp;
			}
		}
		//随机打乱数组中元素位置
		
		static public function xyRandom(width:int,height:int,_arrX:Array,_arrY:Array):void{
			
			for(var c:int=0;c<=(width-1);c++)
			{
				for(var d:int=0;d<=(width-1);d++)
				{
					_arrX[d+width*c]=c;
				} 
			}

			for(var a:int=0;a<=(height-1);a++)
			{
				for(var b:int=0;b<=(height-1);b++)
				{
					_arrY[a+height*b]=a;
				} 
			}
		}
		//0000111122223333
		//0123012301230123
		//用于随机选择坐标。
		
		
	}
}
	