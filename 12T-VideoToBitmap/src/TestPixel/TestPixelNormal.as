package TestPixel
{
	public class TestPixelNormal implements ITestPixel
	{
		/**测试用数组创建器**/
		public function TestPixelNormal()
		{
		}
		/**
		 * @param d : 取样距离
		 * @param pixel : 原数组
		 * @return Array适合进行对比的数组
		 * */
		public function createTestPixel(d:int, pixel:Array):Array
		{
			var pA:Array=new Array;
			var x:int=0;
			var y:int=0;
			for(var i:int=0 ; i<pixel.length ; i+=d){
				pA[x]=new Array;
				y=0;
				for(var j:int=0 ; j<pixel[i].length ; j+=d){
					pA[x][y]=pixel[i][j];
					y++;
				}
				x++;
			}
			return pA;
		}
	}
}