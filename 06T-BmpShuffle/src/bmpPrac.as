package
{
	//import fl.motion.MatrixTransformer;	
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Bounce;
	import com.greensock.plugins.BezierPlugin;
	import com.greensock.plugins.BezierThroughPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.debugger.enterDebugger;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.FrameLabel;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.ConvolutionFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import flashx.textLayout.utils.CharacterUtil;
	
	import org.osmf.elements.LightweightVideoElement;
	import org.osmf.media.DefaultMediaFactory;
	
	//[SWF(width="1000", height="665", backgroundColor="0x000000")]
	[SWF(width="1000", height="665", backgroundColor="0xffffff")]
	public class bmpPrac extends Sprite
	{
		public function bmpPrac()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var loader:Loader=new Loader;
			loader.load(new URLRequest("a1.jpg"));		
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onload);  
			
			var timer:Timer=new Timer(10);			
			
			var a:BitmapData=new BitmapData(2000,1000,false,0x00ffff00);		
			var b:Bitmap=new Bitmap(a);
			var f:BitmapData;//扑克data
			//	var f2:BitmapData;
			var imgg:Bitmap=new Bitmap;
			
			var num:int
			function onload(e:Event):void{
				f=Bitmap(loader.content).bitmapData
				num=1000;
				pvec=rand1000P(num);
				rvec=rand1000R(num);
				mvec=rand1000M(num);
				//				addChild(img);
				//				addChild(imgg);	
				//	plentyOfPokeSpinning2(mvec , pvec , rvec ,num );
				for(var k:int=0 ; k<num ; k++){
					imgvec[k]=new Bitmap(f);
				}
				plentyOfPokeSpinning2(mvec , pvec , rvec ,num );
				showImg();
				addChild(new Stats());
				timer.addEventListener(TimerEvent.TIMER,spinHandler);
				timer.addEventListener(TimerEvent.TIMER,LPTimer);
				timer.start();
				
				stage.addEventListener(KeyboardEvent.KEY_DOWN , ctrl);
				stage.frameRate=60;
				parent.stage.addEventListener(MouseEvent.MOUSE_DOWN,bmpStartDrag);
				parent.stage.addEventListener(MouseEvent.MOUSE_UP,bmpStopDrag);
			}
			function switchLP(e:Keyboard):void{
				
			}
			
			var lpb:Boolean=true;
			var pkb:Boolean=true;
			function ctrl(e:KeyboardEvent):void{
				if(e.keyCode==Keyboard.Z){
					if(!lpb){
						timer.addEventListener(TimerEvent.TIMER,LPTimer);
						lpb=true;
					}
					else{
						timer.removeEventListener(TimerEvent.TIMER,LPTimer);
						lpb=false;
					}
				}
				else if(e.keyCode==Keyboard.X){
					if(!pkb){
						timer.addEventListener(TimerEvent.TIMER,spinHandler);
						pkb=true;
					}
					else{
						timer.removeEventListener(TimerEvent.TIMER,spinHandler);
						pkb=false;
					}
				}
			}
			
			
			var img:Bitmap
			var lpp:LightPointPath=new LightPointPath(1000,800);
			lpp.randMatrix(10);
			img=new Bitmap(lpp.renewData());
			
			
			var spp:SpinningPoke=new SpinningPoke;
			//addChild(spp.img);
			//timer.addEventListener(TimerEvent.TIMER,pokeSpin)
			
			function pokeSpin(e:TimerEvent):void{
				spp.Spinning();
			}			
					
			function LPTimer(e:Event):void{
				
				if(img.stage!=null)	removeChild(img);
				
				if(timer.currentCount%30==0){
					lpp.randMatrix(10);
				}
				img=new Bitmap(lpp.renewData());
				addChild(img);
			}
			
			function rand1000M(n:int):Vector.<Matrix>{
				var vec:Vector.<Matrix>=new Vector.<Matrix>
				for(var i:int=0;i<n;i++){
					//					var mtr:Matrix=new Matrix(0.1,0,0,0.1,Math.random()*100+600 , Math.random()*100+300);				
										var mtr:Matrix=new Matrix(0.1,0,0,0.1,Math.random()*900+300 , Math.random()*400+200);		
//					var mtr:Matrix=new Matrix(0.1,0,0,0.1,Math.random()*100+300 , Math.random()*100+200);		
					vec.push(mtr);
				}
				return vec;
			}
			function rand1000P(n:int):Vector.<Point>{
				var vec:Vector.<Point>=new Vector.<Point>;
				for(var i:int=0;i<n;i++){
					vec.push(new Point(Math.random()*200+200 , Math.random()*200+200));
				}
				return vec;
			}
			function rand1000R(n:int):Vector.<Number>{
				var vec:Vector.<Number>=new Vector.<Number>;
				for(var i:int=0;i<n;i++){
					vec.push(Math.random()*2+1);
				}
				return vec;
			}
			
			var mvec:Vector.<Matrix>
			var pvec:Vector.<Point>=rand1000P(num);
			var rvec:Vector.<Number>=rand1000R(num);
			
			var bmpd:BitmapData=new BitmapData(1000,800,true,0xff);			
			bmpd.colorTransform(new Rectangle(0,0,width,height) , new ColorTransform(1,1,1,0));
			function plentyOfPokeSpinning(m:Vector.<Matrix> , p:Vector.<Point>, r:Vector.<Number>,n:int):BitmapData{		
				bmpd.fillRect(bmpd.rect, 0x00000000);
				for(var i:int=0;i<n;i++){
					MatrixTransformer.rotateAroundExternalPoint( m[i] , 600 , 300 , r[i] );
					bmpd.draw(f , m[i]);
				}			
				return bmpd;
			}	
			
			
			var imgvec:Vector.<Bitmap>=new Vector.<Bitmap>; 
			
			function plentyOfPokeSpinning2(m:Vector.<Matrix> , p:Vector.<Point>, r:Vector.<Number>,n:int):void{			
				var img:Bitmap;
				for(var i:int=0;i<n;i++){
					MatrixTransformer.rotateAroundExternalPoint( m[i] , 600 , 300 , r[i] );		
					//	MatrixTransformer.rotateAroundExternalPoint( m[i] , p[i].x , p[i].y , r[i] );								
					//		imgvec[i]=new Bitmap(f);
					
					imgvec[i].transform.matrix=m[i];
//			addChild(imgvec[i]);
				}
			}	
			
			function showImg():void{
				for(var i:int=0 ; i<imgvec.length ;  i++){
					addChild(imgvec[i]);
				}
			}
			
			function spinHandler(e:Event):void{		
//				for(var k:int=0 ; k<imgvec.length ; k++){
//					removeChild(imgvec[k]);
//				}
				//			removeChildren(2);
				plentyOfPokeSpinning2(mvec , pvec , rvec ,num );
				
				//				trace(imgvec[0].transform.matrix.tx , imgvec[0].transform.matrix.ty);
				//				imgg.bitmapData=(plentyOfPokeSpinning(mvec , pvec , rvec ,num ));
			}
			
			var tmpX:int;
			var tmpY:int;
			var dragTimer:Timer=new Timer(10);
			var tmpObj:Object=new Object;
			tmpObj.swt=false;

			dragTimer.addEventListener(TimerEvent.TIMER,dragHandler);
			
			function bmpStartDrag(e:MouseEvent):void{
				var mP:Point=new Point(mouseX,mouseY);	
				for(var ii:int=imgvec.length-1 ; ii>=0 ; ii--){
//				for(var ii:int=0 ; ii<imgvec.length ; ii++){
					//if(imgvec[ii].bitmapData.hitTest(  (new Point(imgvec[ii].x , imgvec[ii].y)) , 0 ,mP ) ){
					if(  imgvec[ii].hitTestPoint( mP.x , mP.y )  ){
						tmpX=mouseX-imgvec[ii].x;
						tmpY=mouseY-imgvec[ii].y;		
						tmpObj.bmp=imgvec.splice(ii,1)[0];
						addChild(tmpObj.bmp);
						tmpObj.matrix=mvec.splice(ii,1)[0];
						tmpObj.rot=rvec.splice(ii,1)[0];
						tmpObj.swt=true;
						num-=1;
						dragTimer.start();
						return;
					}
				}
			}
			function bmpStopDrag(e:MouseEvent):void{
				if( tmpObj.swt==true){
					var mP:Point=new Point(mouseX,mouseY);
					tmpObj.matrix.tx=mP.x-tmpX;
					tmpObj.matrix.ty=mP.y-tmpY;
					imgvec.unshift(tmpObj.bmp);
					mvec.unshift(tmpObj.matrix);
					rvec.unshift(tmpObj.rot);
					tmpObj.swt=false;
					num+=1;
					dragTimer.stop();
				}
			}
			function dragHandler(e:TimerEvent):void{
				tmpObj.bmp.x=mouseX-tmpX;
				tmpObj.bmp.y=mouseY-tmpY;
			}
		}
	}
}