package Scan
{
	import flash.display.BitmapData;
	import Gestures.IGes;

	public class Scanner implements IScanner
	{
		private var _ges:IGes;
		public function Scanner(ges:IGes)
		{
			_ges=ges;
		}
		
		public function Scan(bmpd:BitmapData , color:uint , dis:int):void
		{
			var m:int=0;
			var n:int;
			for(var i:int=0 ; i<_ges.Width ; i+=dis){
				_ges.pixelArr[m]=new Array();
				n=0;
				for(var j:int=0 ; j<_ges.Height ; j+=dis){
					if(bmpd.getPixel(i,j) < color+100 && bmpd.getPixel32(i,j) > color+100)
					{
						_ges.totalPixel++;
						_ges.pixelArr[m][n]=1;
					}
					else
					{
						_ges.pixelArr[m][n]=0;
					}
					n++;
				}
				m++;
			}
			_ges.pixelRate=_ges.totalPixel / (m*n);
		}
	}
}