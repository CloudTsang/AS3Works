package
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Analog extends Sprite
	{
		public  var anlCtrl:Sprite=new Sprite;//摇杆本体
        public var cp:Point=new Point;
		private var rect:Rectangle;//限制摇杆的区域
		public function Analog()
		{
			super();
			anlCtrl=drawCircle(0x000000,1,60,0,0,true);
			
			rect=new Rectangle(this.x-100,this.y-100,180,180);
			this.addChild(anlCtrl);
			this.addChild(drawCircle(0x000000,0.5,100,0,0,false));
		}
		private function drawCircle(color:uint,alp:Number,rad:int,x:int,y:int,fill:Boolean):Sprite{
			var sth:Sprite=new Sprite;
			if(fill==true){
				sth.graphics.beginFill(color);
			}
			sth.graphics.lineStyle(1,0x000000);
			sth.alpha=alp;
			sth.graphics.drawCircle(x,y,rad);
			return sth;
		}
		public function Drag(ifMove:Boolean):void{
			if(ifMove==true){
				anlCtrl.startDrag(false,rect);

			}else{
				anlCtrl.stopDrag();
				cp=new Point(this.anlCtrl.x,this.anlCtrl.y);
				trace(cp);
				trace(localToGlobal(cp));
				this.x=0;
				this.y=0;
				anlCtrl.x=0;
				anlCtrl.y=0;
			}		
		}
	}
}