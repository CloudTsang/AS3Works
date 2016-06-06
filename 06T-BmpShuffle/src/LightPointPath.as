package
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	public class LightPointPath extends BitmapData
	{
		private var mVec:Vector.<Matrix>=new Vector.<Matrix>;
		private var bmpd:BitmapData=new LightPoint();
		public function LightPointPath(width:int, height:int, transparent:Boolean=true, fillColor:uint=4.294967295E9)
		{
			super(width, height, transparent, fillColor);
			this.colorTransform(new Rectangle(0,0,width,height) , new ColorTransform(1,1,1,0));
		}
		public function renewData():BitmapData{
			
			this.fillRect(this.rect, 0x00000000);
			for(var i:int=mVec.length-1 ; i>=0 ; i--){
				mVec[i].ty-=Math.random()*20;
				mVec[i].tx+=Math.random()*4-2;
				//mVec[i].a-=0.1;
				//mVec[i].scale(Math.random() , Math.random());
				//bmpd=new LightPoint();
				this.draw(bmpd,mVec[i]);
			}
			return this;
		}
		public function  randMatrix(n:int):void{
			for(n ; n>=0 ; n--){
				mVec.unshift(new Matrix(1,0,0,1,Math.random()*1000,800));
			}
		}
	}
}