package
{
	import flash.geom.Point;
	
	public class Canon extends DaPao
	{
		public var ONOFF:Boolean;
		public var Num:int;
		public var BulletNum:int;
		public var blt:Bullet
		public var bltArr:Array=new Array;
		public function Canon(x:int,y:int)
		{			
			super();
			this.x=x;
			
			this.y=y;			
		}
		public function Shot():void
		{
			blt=new Bullet;
			this.addChild(blt);
			bltArr.push(blt);
		}
		public function Switch(bool:Boolean):void{
			ONOFF=bool;
			if(bool==true){
				this.gotoAndStop(2);
			}
			else {
				this.gotoAndStop(1);
			}
		}
		
	}
}