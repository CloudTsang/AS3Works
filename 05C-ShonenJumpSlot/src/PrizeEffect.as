package
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.plugins.BezierPlugin;
	import com.greensock.plugins.Physics2DPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	public class PrizeEffect extends Sprite
	{
		/**一段时间后将赢奖效果清除的timer**/
		private var timer:Timer=new Timer(10000,1);
		public function PrizeEffect()
		{
			TweenPlugin.activate([Physics2DPlugin]);			
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			this.x=600;
			this.y=-100;
		}
		/**赢奖的牌子+飞金币的效果
		 * @param m=奖金
		 * @param c=金币数**/
		public function winEffect(m:int,c:int):void{
			var wEffect:WinEffect=new WinEffect;
			var cEffect:Coins=new Coins(c);	
			wEffect.setMoney(m);
			wEffect.y=1000;			
			TweenLite.to(wEffect,2,{y:300,scaleX:1.5, scaleY:1.5, ease:Back.easeOut});	
			this.addChild(wEffect);
			this.addChild(cEffect);
			timer.start();
		}
		private function timerHandler(e:TimerEvent):void{
			clear();
		}
		/**清除效果的函数**/
		public function clear():void{
			if(this.numChildren!=0){
				this.removeChildren();
				timer.reset();
			}
		}
	}
}