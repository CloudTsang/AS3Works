package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	public class LogPad extends Bitmap
	{
		private var bmpd:BitmapData;
		private var timer:Timer;
		private var phrases:Array;
		private var pIndex:int=0;
		private var words:Array;
		private var wIndex:int=0;
		private var tf:TextFormat=new TextFormat;
		private var  _d:Dialog;  
		private var _c:Vector.<uint>=new <uint>[0x000000 , 0x00ff00 , 0x00000cc];
		/**
		 * 设置对话文本框
		 * @param log：对话文本
		 * @param ifTalk：是否有说话人
		 * @param talker：说话人名字
		 * @param ifCenter：是否居中
		 * @param color：颜色 ，默认为黑色0，绿色1，蓝色2
		 * @param ifStress：是否强调，强调后字号变大为75
		 * */
		public function LogPad( log:String ,talker:String=" ", ifTalk:Boolean=true  , ifCenter:Boolean=false , color:int=0  , ifStress:Boolean=false )
		{
			super();				
			phrases=log.split("&&");
			//			trace(phrases);
			tf.color=_c[color];
			//	tf.leading=-50;
			if(ifCenter)tf.align="center";
			if(ifStress==true)tf.size=75;
			
			_d=new Dialog;
			_d.logTalker.visible=ifTalk;
			_d.logTalker.txtName.text=talker;
			_d.txtLog.setTextFormat(tf);	
			_d.txtLog.text="";			
			_d.txtLog.wordWrap=true;
			
			this.y=400;
			this.x=100;
			timer=new Timer(1);
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			txtSymb();
			timer.start();
		}
		
		private function timerHandler(e:TimerEvent):void{		
			
			
			_d.txtLog.appendText(words[wIndex]);
			
			bmpd=new BitmapData(_d.width , _d.height , true ,0);		
			bmpd.draw( _d , new Matrix(1,0,0,1,2,80));
			this.bitmapData=bmpd;	
			if(wIndex==words.length-1) {
				txtSymb();
				wIndex=0;	
				if (pIndex==phrases.length-1){
					timer.reset();
					return;
				}
				pIndex++;				
			}
			else{
				wIndex++;
			}		
		}
		
		private function txtSymb():void{
		
			switch(phrases[pIndex]){				
				case "/slow/":
					timer.delay=100;
					pIndex++;	
					break;
				case "/normal/":
					timer.delay=20;
					pIndex++;	
					break;
				case "/quick/":
					timer.delay=50;
					pIndex++;	
					break;
				case "/stress/":
					timer.delay=500;
					pIndex++;	
					break;
				case "/stop/":
					timer.reset();
					setTimeout( timer.start , 5000);
					pIndex++;	
					break;
				case "/instant/":			
					pIndex++;	
					words.splice(0,words.length,phrases[pIndex]);								
					return;
			}				
			words=phrases[pIndex].split("");
			trace(words);
			
		}
		
		public function dispose():void{
			this.bitmapData=null;
		}
	}
}