package
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Reel extends Sprite
	{
		private static const speed:Number=0.1;
		/**一列三个标记的数组**/
		public var _reelArr:Vector.<Object>=new Vector.<Object>;
		public static var sct:int=0;
		/**控制转轮转动的timer**/
		public var _timer:Timer=new Timer(speed*500);
		
		/**转轮是否正在转动**/
		public var isSpin:Boolean=false;
		public static var sctEvent:Event=new Event("sctRoll");
		/**遮罩层，只显示Reel的三个标记**/
		private var _mask:Sprite=createPad(500,200);
		
		public function Reel(x:int,y:int)
		{
			this.x=x;
			this.y=y;
			this.addChild(createPad(500,200));
			_mask.x=this.x;
			_mask.y=this.y;
			this.mask=_mask;
			createMarks();
			_timer.addEventListener("timer",timerHandler);
		}
		
		/**
		 * 转轮滚动函数。
		 * 处理时点为0-2个标记滚动到遮罩层内。
		 * 将已经滚出遮罩层的3-5个标记删除后，生成3个新标记，并令原本的0-2个标记向下滚动。
		 * */
		private function timerHandler(event:TimerEvent):void{	
			//继续旋转中
			if(isSpin==true){
				if(_reelArr.length>3){
					for(var l:int=3;l<=5;l++){
						this.removeChild(_reelArr[l].dispObj);
					}
					_reelArr.splice(3,3);
				}
				createMarks();
				for(var k:int=3;k<=5;k++){
					TweenLite.to(_reelArr[k].dispObj,speed,{y:_reelArr[k].dispObj.y+500});
				}
				//停止旋转	
			}else{
				for(l=0;l<=2;l++){							
					getTips(l,true);		
				}
				for(l=3;l<=5;l++){
					this.removeChild(_reelArr[l].dispObj);
				}
				_reelArr.splice(3,3);
//				for(var m:int=0;m<=2;m++){
//					if(_reelArr[m].Name=="Free"){
//						dispatchEvent(sctEvent);
//						sct++;
//						break;
//					}
//				}
//				trace(sct);
				_timer.stop();	
			}			
		}
		/**
		 * 随机生成1列3个标记。
		 * 初始位置在遮罩层上3个标记的位置。
		 * 使用tweenlite向下滚动3个标记的位置。
		 * */
		public  function createMarks():void{
			for(var j:int=1;j<=3;j++){
				var tmpObj:Object=Slot.randomSlot();
				tmpObj.dispObj.y=-j*tmpObj.dispObj.height;
				TweenLite.to(tmpObj.dispObj,speed,{y:tmpObj.dispObj.y+500});
				this.addChild(tmpObj.dispObj);
				_reelArr.unshift(tmpObj);				
			}			
		}
		
		/**删除标记的函数**/
		public function delMarks():void{
			for(var i:int=_reelArr.length-1;i>=0;i--){
				this.removeChild(_reelArr[i].dispObj);
				_reelArr.splice(i,1);
			}
		}
		
		/**停止转轮函数,timer的停止在timer事件处理函数中**/
		public function stopReel():void{
			isSpin=false;
		}
		
		/**开始转轮函数，同时启动timer**/
		public function startReel():void{
			isSpin=true;
			_timer.start()
		}
		
		/**设置转动速度s(转动计时器的delay)**/
		public function set speed(s:int):void{
			speed=s;
		}
		
		/**获取第n行标记的种类**/
		public function getName(n:int):String{
			return _reelArr[n].Name;
		}
		
		/**获取第n行o个中奖标记的赔率**/
		public function getOdd(n:int,o:int):int
		{
			switch (o)
			{
				case 3:
					return _reelArr[n].Odds3;
				case 4:
					return _reelArr[n].Odds4;
				case 5:
					return _reelArr[n].Odds5;
			}
			return 0;
		}
		
		/**控制赔率叹号是否出现，true=出现**/
		public function getTips(n:int,s_h:Boolean):void{
			_reelArr[n].Tip.visible=s_h;
		}
		
		//画遮罩层
		private function createPad(h:int,w:int):Sprite{
			var tmp:Sprite=new Sprite;
			tmp.graphics.beginFill(0x000000);
			tmp.graphics.drawRect(0,0,w,h);
			tmp.visible=false;
			return tmp;
		}
		
	}
}