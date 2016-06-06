package com.greensock.easing {
	public class Bounce {
		public static function easeOut (t:Number, b:Number, c:Number, d:Number):Number {
			if ((t/=d) < (1/2.75)) {
				return c*(7.5625*t*t) + b;
			} else if (t < (2/2.75)) {
				return c*(7.5625*(t-=(1.5/2.75))*t + .75) + b;
			} else if (t < (2.5/2.75)) {
				return c*(7.5625*(t-=(2.25/2.75))*t + .9375) + b;
			} else {
				return c*(7.5625*(t-=(2.625/2.75))*t + .984375) + b;
			}
		}
		public static function easeOut2 (t:Number, b:Number, c:Number, d:Number):Number {
			var i:Number=0;
			if ((t/=d) < (1/2.75)) {
				i=c*(7.5625*t*t) + b;
				trace("t : "+t+"  B : "+b+"  C : "+c+"  D : "+d+"第一 : "+i);
				return i;
			} else if (t < (2/2.75)) {
				i=c*(7.5625*(t-=(1.5/2.75))*t + .75) + b;
				trace("t : "+t+"  B : "+b+"  C : "+c+"  D : "+d+"第二 : "+i);
				return i;
			} else if (t < (2.5/2.75)) {
				i=c*(7.5625*(t-=(2.25/2.75))*t + .9375) + b;
				trace("t : "+t+"  B : "+b+"  C : "+c+"  D : "+d+"第三 : "+i);
				return i;
			} else {
				i= c*(7.5625*(t-=(2.625/2.75))*t + .984375) + b;
				trace("t : "+t+"  B : "+b+"  C : "+c+"  D : "+d+"第四 : "+i);
				return i;
			}
		}
		public static function easeIn (t:Number, b:Number, c:Number, d:Number):Number {
			return c - easeOut(d-t, 0, c, d) + b;
		}
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number):Number {
			if (t < d*0.5) return easeIn (t*2, 0, c, d) * .5 + b;
			else return easeOut (t*2-d, 0, c, d) * .5 + c*.5 + b;
		}
	}
}