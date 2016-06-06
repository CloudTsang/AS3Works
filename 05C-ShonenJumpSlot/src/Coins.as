package
{
	import com.greensock.*;
	import com.greensock.plugins.Physics2DPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.Shape;
	import flash.display.Sprite;
/**金币有改变大小的enterframe函数**/
	public class Coins extends Sprite
	{
		private var scaleArr:Array=new Array;
		public function Coins(c:int)
		{
			createArr(c);
			for (var i:int = 0; i < c; i++) {
				tweenDot(getNewDot(i), getRandom(0, 3));
			}			
		}		
		private	function tweenDot(dot:CoinEffect, delay:Number):void {
			TweenLite.to(dot, 3, {physics2D:{velocity:getRandom(150, 450), angle:getRandom(0, 180), gravity:400}, delay:delay, onComplete:tweenDot, onCompleteParams:[dot, 0]});
		//	TweenLite.to(dot, 3, {physics2D:{velocity:getRandom(150, 450), angle:getRandom(180, 360), gravity:400}, delay:delay, onComplete:tweenDot, onCompleteParams:[dot, 0]});
			}	
		
		private 	function getRandom(min:Number, max:Number):Number {
				return min + (Math.random() * (max - min));
			}
		private function getNewDot(i:int): CoinEffect{
			var c:CoinEffect=new CoinEffect;
			c.setScale(scaleArr[i]);
			this.addChild(c);
			return c;
		}
		
		private function createArr(c:int,i:int=0):void{
			for(i;i<c;i++){
				scaleArr[i]=(Math.random()*2-1)/100;
			}
			scaleArr.sort(Array.NUMERIC);
		}
	}
}