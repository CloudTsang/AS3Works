package {
	import Gestures.GesToTest;
	import Gestures.Gesture;
	import Gestures.IGes;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.FrameLabel;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.filters.ConvolutionFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.net.SharedObject;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	import flash.text.ReturnKeyLabel;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import flashx.textLayout.elements.SpecialCharacterElement;
	
	[SWF(width="1300", height="600",  backgroundColor="0xFFFFFF" , frameRate="30")]
	public class VideoToBitmap extends Sprite
	{
		private var _cam:Camera;
		private var _vid:Video;
		
		private var _matrix:Matrix
		private var _newFrame:BitmapData;
		private var _oldFrame:BitmapData;
		/**old与new不一样的地方会在这一帧显示出来**/
		private var _blendFrame:BitmapData;
		private var _bmp:Bitmap;
		private var _bmp2:Bitmap;
		
		private var _red:Array;
		private var _green:Array;
		private var _blue:Array;
		
		private var _timer:Timer;
		/**手势矩形的数组**/
		private var _rV:RectVec;
		/**手势矩形Sprite的数组，在实现中并不需要**/
		private var _sV:SpVec;
		
		/**取样距离，需要更精确地识别时，应当让这个值按照比例放缩，然而可能导致效率明显下降？**/
		private const DOT:int=5;
		/**匹配像素的比值下限**/
		private const SUCCESS_RATE:Number=0.30;
		/**不匹配像素的比值上限**/
		private const FAILED_RATE:Number=0.10;
		
		private const CAM_WIDTH:int=640;
		private const CAM_HEI:int=480;
		
		public  var testColor:uint=12632256;
		private var SO:SharedObject=SharedObject.getLocal("StoredGesture");
		private var gesVec:Vector.<Gesture>;
		
		private var panel:CtrlPanel;
		
		public function VideoToBitmap()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			//			SO.clear();
			if(SO.data.gesture==undefined) SO.data.gesture=new Vector.<Object>;
			gesVec=new Vector.<Gesture>;
			for(var i:int=0 ; i<SO.data.gesture.length ; i++){
				trace(SO.data.gesture[i].name+"已装载");
				gesVec.push(new Gesture(SO.data.gesture[i]));
			}
			
			setTimeout(init , 100);
		}
		
		private function init():void{
			//			Security.showSettings(SecurityPanel.PRIVACY);
			_cam = Camera.getCamera();
			_cam.setMode(CAM_WIDTH, CAM_HEI, 15);
			_vid = new Video(CAM_WIDTH, CAM_HEI);
			_vid.attachCamera(_cam);
			_vid.filters = [new BlurFilter(10,10 , 1)];
			//			_vid.filters = [new ConvolutionFilter(1, 3, [0, 4, -4]),new BlurFilter()]; //edge tracking
			
			_newFrame = new BitmapData(CAM_WIDTH, CAM_HEI, false);
			_oldFrame = _newFrame.clone();
			_blendFrame = _newFrame.clone();
			//			_bmp=new Bitmap(_newFrame);
			_bmp=new Bitmap(_blendFrame);
			//			_bmp2=new Bitmap(_newFrame); 
			//			_bmp2.x=645;
			//									_bmp=new Bitmap(_oldFrame);
			addChild(_bmp);
			//			addChild(_bmp2);
			
			_matrix=new Matrix(-1,0,0,1,_newFrame.width ,0);
			_rV=new RectVec;
			_sV=new SpVec;
			
			makePaletteArrays();
			
			_timer=new Timer(100);
			//			_timer.addEventListener(TimerEvent.TIMER , onEnterFrame);
			
			panel=new CtrlPanel;
			panel.y=500;
			panel.Btn_Cap.addEventListener(MouseEvent.CLICK , Capture);
			panel.Btn_Pause.addEventListener(MouseEvent.CLICK , Pause);
			addChild(panel);
			
			//			_timer.start();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(MouseEvent.CLICK, onClick);		
			addChild(new Stats);	
		}
		
		private function Pause(e:Event=null):void{
			//			if(_timer.running)_timer.stop();
			//			else _timer.start();				
			if(hasEventListener(Event.ENTER_FRAME)){
				removeEventListener(Event.ENTER_FRAME , onEnterFrame);
			}
			else addEventListener(Event.ENTER_FRAME , onEnterFrame);
		}
		
		/**颜色减少处理**/
		private function makePaletteArrays():void
		{
			_red = new Array();
			_green = new Array();
			_blue = new Array();
			var levels:int = 4;
			var div:int = 256 / levels;
			for(var i:int = 0; i < 256; i++)
			{
				var value:Number = Math.floor(i / div ) * div; 
				_red[i] = value << 16;
				_green[i] = value << 8;
				_blue[i] = value
			}
		}
		
		/**获取检测颜色**/
		private function onClick(event:MouseEvent):void
		{
			if(mouseX>CAM_WIDTH || mouseY>CAM_HEI)return;
			testColor = _bmp2.bitmapData.getPixel(mouseX, mouseY);
			trace(testColor);
		}
		
		private function Capture(e:Event=null):void{
			var rec:Rectangle = _rV.Vec[0];			
			var tmp:BitmapData=new BitmapData(rec.width , rec.height);
			tmp.copyPixels(_newFrame , rec , new Point());
			var ges:Gesture=new Gesture();
			ges.storeGes(tmp , testColor , panel.Txt_Input.text);			
			gesVec.push(ges);
			SO.data.gesture.push(ges.Data);
			trace("——————手势已储存——————");
			trace(ges.Name+"      "+ges.pixelRate);
			trace("—————————————————");
		}
		
		public function Compare(bmpd:BitmapData):String{
			var result:String="未匹配";
			if(gesVec.length==0)return result;
			var tmpGes:IGes=new GesToTest(bmpd , testColor);
			var arr:Array=new Array();
			for(var i:int=0 ; i< gesVec.length ; i++){
				if(tmpGes.pixelRate >= gesVec[i].pixelRate-0.1
					&& tmpGes.pixelRate <= gesVec[i].pixelRate+0.1){
					arr.push(i);
				}
			}
//			trace(arr.length+"个手势候选");
			if(arr.length==0)return result;
			var tmpGes2:IGes;
			var d:int;
			var arrG1:Array;
			var arrG2:Array;
			var matchP:int=0;
			var failP:int=0
			var matchR:Number=SUCCESS_RATE;
			var tmr:Number;
			var failR:Number=FAILED_RATE;
			var tfr:Number;
			for(var j:int=0 ; j<arr.length ; j++){
				tmpGes2=gesVec[ arr[j] ];
				d=int(DOT*(tmpGes.Width/tmpGes2.Width));
				arrG1=tmpGes.createTestPixel(d);
				arrG2=tmpGes2.pixelArr;
				var m:int;
				var n:int;
				for(m=0 ; m<arrG1.length ; m++){
					if(m>=arrG2.length)break;
					for(n=0 ; n<arrG1[m].length ; n++){
						if(n>=arrG2[m].length)break;
						if(arrG1[m][n]==arrG2[m][n]==1)matchP++;
						else if(arrG1[m][n]!=arrG2[m][n]) failP++;
					}
				}				
				tmr=matchP/(m*n);
				tfr=failP/(m*n);
				if(tmr>matchR
//					&& tfr<failR
				){
					result=tmpGes2.Name; 
					matchR=tmr;
					failR=tfr;
				}
				matchP=0;
				failP=0;
			}
			return result;
		}
		
		private function onEnterFrame(event:Event):void
		{
			_blendFrame.draw(_oldFrame);
			_newFrame.draw(_vid, _matrix);
			_oldFrame.draw(_newFrame);
			
			_blendFrame.draw(_newFrame, null, null, BlendMode.DIFFERENCE);
			_blendFrame.threshold(_blendFrame, _blendFrame.rect, new Point(), "<", 0x00330000, 0xff000000, 0x00FFffff, true);
						_newFrame.paletteMap(_newFrame, _newFrame.rect, new Point(), _red, _green, _blue);
			
			//						var moverec:Rectangle=_blendFrame.getColorBoundsRect(0xFFFFFF , 0x000000 , false);
			//						var arr1:Vector.<int>=borderTest_MOTION(_blendFrame , moverec);
			var arr1:Vector.<int>=borderTest_MOTION(_blendFrame);
			var arr2:Vector.<int>=borderTest_MOTION2(_blendFrame , arr1);
			_rV.Renew(arr1 , arr2);
			var arr3:*=_rV.Vec;
			_sV.Renew(arr3);
			var arr4:*=_sV.Vec;
			for(var a:int=0 ; a<arr4.length ; a++) _blendFrame.draw(arr4[a]);
			drawPoint(arr3 , _blendFrame , _newFrame);
			//return ;
			if(_rV.Vec.length>=1)outputResult(_newFrame , _rV.Vec[0] , panel.Txt_OutputL);
			if(_rV.Vec.length==2)outputResult(_newFrame, _rV.Vec[1],panel.Txt_OutputR);
		}
		
		private function outputResult(bmpd:BitmapData , rec:Rectangle , txt:TextField):void{
			var tmp:BitmapData=new BitmapData(rec.width , rec.height);
			tmp.copyPixels(bmpd , rec ,new Point);
			txt.text=Compare(tmp);
		}
		
		/**纵向像素检测，只用于检测Y轴上有没有颜色，不检测数目
		 * @param bmpd：检测对象，应当是混合帧_blendframe
		 * **/
		private function borderTest_MOTION(bmpd:BitmapData , mR:Rectangle=null):Vector.<int>{
			var borderArr:Vector.<int>=new Vector.<int>;
			var emptyNum:int=0;
			/**连续5列有没有颜色**/
			var flag1:Boolean=false;
			/**这1列有没有颜色**/
			var flag2:Boolean;
			for(var i:int=0 ; i<stage.stageWidth ; i+=DOT){
				flag2=false;
				for(var j:int=0 ; j<stage.stageHeight ; j+=DOT){
					if(bmpd.getPixel(i,j)>0x000000) {
						flag2=true;
						emptyNum=0;
						if(flag1==false){
							borderArr.push(i);//isColor为false时，这一列为有颜色的第一列，放入数组中
							flag1=true;
						}
						break;//这一列有颜色时中断至下一个循环，
					}
				}
				if(flag2==false){
					//扫描过一列之后isColor依然为true时这一列没有颜色,连续5列没有颜色时视为一个边界
					emptyNum++;
					if(emptyNum==5 && flag1==true){
						borderArr.push(i-5*DOT);
						emptyNum=0;
						flag1=false;
					}
				}
			}
			if(borderArr.length==0)return null;
			if(borderArr.length%2==1)borderArr.push(stage.stageWidth);
			return borderArr;
		}
		
		/**
		 * 横向像素检测，只用于检测X轴上有没有颜色，不检测数目
		 * @param bmpd：检测对象，应当是混合帧_blendframe
		 * @param border1：Y轴检测结果，该检测只在Y轴检测得出的边界范围内进行
		 * **/
		private function borderTest_MOTION2(bmpd:BitmapData , border1:Vector.<int>):Vector.<int>{
			if(border1==null)return null;
			var left:int;
			var right:int;
			var up:int;
			var down:int;
			var vec:Vector.<int>=new Vector.<int>;
			for(var i:int=0 ; i<(border1.length-1) ; i+=2)
			{
				up=stage.stageHeight;
				down=0;
				for(var j:int=border1[i] ; j<border1[i+1] ; j++)
				{
					for(var u:int=0 ; u<up ; u++)
					{
						if(bmpd.getPixel(j , u)>0x000000 && u<up) 
						{
							up=u;
							break;
						}
					}
					for(var d:int=stage.stageHeight ; d>down ; d--){
						if(bmpd.getPixel(j , d)>0x000000 && d>down)
						{
							down=d;
							break;
						}
					}
				}
				vec.push(up ,down);
			}
			return vec;
		}
		
		/**将手势显示出来的功能 ， 这个功能在实现中并不需要**/
		private function drawPoint(vec:Vector.<Rectangle> , bmpd1:BitmapData , bmpd2:BitmapData):void{
			if(vec==null)return;	
			var tmp:Rectangle;
			var pos:Point=new Point;
			for(var i:int=0 ; i<vec.length ; i++){
				tmp=vec[i]
				for(var m:int=0 ; m<tmp.width ; m+=DOT){
					pos.x=tmp.x+m;
					for(var n:int=0 ; n<tmp.height ; n+=DOT){
						pos.y=tmp.y+n
//						if(bmpd2.getPixel(pos.x , pos.y)<testColor )bmpd1.setPixel(pos.x , pos.y ,0x0000FF);
						if(bmpd2.getPixel(pos.x , pos.y)<testColor+100 && bmpd2.getPixel(pos.x , pos.y)>testColor-100  )bmpd1.setPixel(pos.x , pos.y ,0x0000FF);
					}
				}
			}
		}
	}
}