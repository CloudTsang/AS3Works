package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;

	public class SpinningPoke
	{
		private var bmpd1:Poke_Spark=new Poke_Spark;
		private var bmpd2:Poke_Heart=new Poke_Heart;
		private var bmpdArr:Vector.<BitmapData>=new <BitmapData>[bmpd1 , bmpd2];
		private var  m:Matrix=new Matrix;
		private var current:int=0;
		private var sc:Number=0.1;
		public var img:Bitmap=new Bitmap(bmpd1);
		public function SpinningPoke()
		{
			m.translate(500,200);
			MatrixTransformer.setRotation(m , 30);
			img.transform.matrix=m;
		}
		public function Spinning():void{
			if(m.a==1.3877787807814457e-16){
			
				current=1-current;
				img.bitmapData=bmpdArr[current];
			}

			m.a+=sc;
			if(m.a>=1)sc=-0.1;
			else if(m.a<=-1)sc=0.1
			
			img.transform.matrix=m;
		}
	}
}