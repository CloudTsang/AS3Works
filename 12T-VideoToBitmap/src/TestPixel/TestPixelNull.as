package TestPixel
{
	public class TestPixelNull implements ITestPixel
	{
	    /**创建测试用数组，但这个方法并不会返回值，使用与本身已经是测试用的储存手势**/
		public function TestPixelNull()
		{
		}
		
		public function createTestPixel(d:int, pixel:Array):Array
		{
			return null;
		}
	}
}