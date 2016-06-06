package himmae.item
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import himmae.misc.TextBlank;
	import himmae.iterfaces.IHero;
	import himmae.iterfaces.IWorldData;
	import himmae.misc.Colors;
	
	public class Light extends Sprite
	{		
		private var _hero:IHero;
		private var _world:IWorldData;
		/**一个砖头的图形**/
		private var _cellBmpd:BitmapData;
		private var _cellRect:Rectangle;
		/**改变每个砖头颜色的ColorTransForm**/
		private var _colorTrans:ColorTransform;
		/**应用_colorTrans的矩形范围，为了分割每个砖头，比_cellRect小一点以露出边界**/
		private var _colorRect:Rectangle;
		/**探照灯显示范围**/
		protected var _range:int;
		/**整个探照灯的BitmapData**/
		private var _bmpd:BitmapData;
		/**整个探照灯的Bitmap**/
		private var _bmp:Bitmap;
		
		private var _txt:TextField;
		private var _format:TextFormat;
		
		private const CELLSIZE:int=25;
				
		/**探照灯
		 * @param range:显示范围==探照灯道具的开放数量1-3
		 * **/
		public function Light(hero:IHero , world:IWorldData,range:int=0) 
		{
			_hero=hero;
			_world=world;
			_range=range-1;
			if(_range==-1)return;
		    createLight();
		}
		
		public function createLight():void{
			_cellBmpd=new BitmapData(CELLSIZE , CELLSIZE ,false);
			_cellRect= new Rectangle(0,0,CELLSIZE , CELLSIZE);
			_colorRect=new Rectangle(2,2,CELLSIZE-4 , CELLSIZE-4);
			_colorTrans=new ColorTransform;
			_bmpd=new BitmapData(6*CELLSIZE , 10*CELLSIZE ,true , 0x00ffffff);//显示范围为6x10个砖头，游戏中的上限是5xN?
			_bmp=new Bitmap();
			
			var _cellMc:Sprite=new Sprite();
			_cellMc.graphics.beginFill(0x000000);
			_cellMc.graphics.drawRect(0,0,CELLSIZE , CELLSIZE);
			_cellMc.graphics.endFill();
			_cellBmpd.draw(_cellMc);
			
			_bmp.bitmapData=_bmpd;
			addChild(_bmp);
		}
		
		/**改变探照灯范围，之前范围是0，现在大于0时会创建探照灯**/
		public function rangeChange(r:int):void{
			if(_range==-1) createLight();
			_range=r-1;
		}
		
		public function Renew(e:Event=null):void{
			if(_range==-1)return;
			_bmpd.fillRect(_bmpd.rect , 0x000000);
			var drc:Point=_hero.direction;
			var fpos:Point=_hero.front;
			if(fpos.x<0 || fpos.x>=_world.height || fpos.y<0 || fpos.y>=_world.width)return;
			var cpos:Point=new Point();
			var arr:Array;
			for(var i:int=-_range ; i<=_range ; i++){
				cpos.x=fpos.x+Math.abs(drc.y)*i;
				cpos.y=fpos.y+Math.abs(drc.x)*i;
				if(cpos.x<0 || cpos.x>=_world.height || cpos.y<0 || cpos.y>=_world.width)continue;
				arr=_world.getCellData(cpos.x , cpos.y);
				for(var j:int=0 ; j<arr.length ; j++){
					_cellBmpd=drawCell(arr[j]);
					_bmpd.copyPixels( _cellBmpd , _cellRect , new Point( i*CELLSIZE+_bmpd.width/2 , _bmpd.height-(j+1)*CELLSIZE));
				}
			}
			_bmp.bitmapData=_bmpd;
		}
		
		private function drawCell(type:String):BitmapData{
			var tmparr:Array=type.split("&");
			var tmp:BitmapData=new BitmapData(CELLSIZE , CELLSIZE);
			tmp.copyPixels( _cellBmpd , _cellRect , new Point(0,0) );
			_colorTrans.color=Colors.instance.getColor(tmparr[0]);
			tmp.colorTransform(_colorRect , _colorTrans);
			if(tmparr.length>1){
				var text:TextBlank=new TextBlank(String(tmparr[1]) , 15 , CELLSIZE,CELLSIZE,0,0,false,TextFormatAlign.LEFT,false,0xffffff);
				tmp.draw(text , new Matrix(1,0,0,1, 4,1));
			}
			return tmp;
		}
	}
}