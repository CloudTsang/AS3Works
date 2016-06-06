package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	public class BoardBmp extends Bitmap
	{
		private var bmpd:BitmapData;
		public var bottom:BitmapData ;
		/**单个格子的bitmap**/
		private var bmpWhite:Bitmap;
		private var bmpBlack:Bitmap;
		private var bmpEmpty:Bitmap;
		
		public function BoardBmp(bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false)
		{
			super(bitmapData, pixelSnapping, smoothing);
			bmpWhite=new Bitmap(new White);
			bmpBlack=new Bitmap(new Black);
			bmpEmpty=new Bitmap(new Empty);	
			bmpd=new BitmapData(640 , 640 ,true);	
			this.x=150;
		}
		
		public function getPoint():Object{		
			if(bottom.getPixel(mouseX , mouseY)==0xFFFFFF) 	{
				var p:Object={x:int((mouseX)/80) ,y:int((mouseY)/80)};
				return p;
			}
			return null;
		}
		
		/**翻转棋子函数
		 * @param col：棋子颜色 ，  -1：黑棋 ， 1：白棋
		 * @param vec：要翻转棋子的位置
		 * **/
		public function renewBoard(col:int , toRenew:Array):String{	
			var tmp:BitmapData
			switch (col){
				case GameData.white:
					tmp=bmpWhite.bitmapData;
					break;
				case GameData.black:
					tmp=bmpBlack.bitmapData;
					break;				
			}	
			for(var k:int=0 ; k<toRenew.length ; k++){				
				bmpd.draw( tmp , new Matrix( 1 , 0 , 0 , 1 , toRenew[k].x*80 , toRenew[k].y*80));	
			}
			this.bitmapData=bmpd;		
			return "棋盘已更新";
		}
		/**棋盘初始化函数
		 * @param b ： 棋盘函数**/
		public function initBoard(b:Array):String{		
			for(var k:int=0 ; k<=7 ; k++){				
				for(var l:int=0 ; l<=7 ; l++){					
					switch (b[k][l]){
						case 0:
							bmpd.draw( bmpWhite.bitmapData , new Matrix( 1 , 0 , 0 , 1 , k*80 , l*80));
							break;
						case 1:
							bmpd.draw( bmpBlack.bitmapData , new Matrix( 1 , 0 , 0 , 1 , k*80 , l*80));					
							break;
						case 2:
							bmpd.draw( bmpEmpty.bitmapData , new Matrix( 1 , 0 , 0 , 1 , k*80 , l*80));
							break;	
					}				
				}
			}
			this.bitmapData=bmpd;		
			bottom=new BitmapData(640,640,true,0xFFFFFFFF);
			dispatchEvent(new Event("Board Init Complete"));
			return "棋盘已初始化。"
		}
	}
}