//
// Project Marilena
// Object Detection in Actionscript3
// based on OpenCV (Open Computer Vision Library) Object Detection
//
// Copyright (C) 2008, Masakazu OHTSUKA (mash), all rights reserved.
// contact o.masakazu(at)gmail.com
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
//   * Redistribution's of source code must retain the above copyright notice,
//     this list of conditions and the following disclaimer.
//
//   * Redistribution's in binary form must reproduce the above copyright notice,
//     this list of conditions and the following disclaimer in the documentation
//     and/or other materials provided with the distribution.
//
// This software is provided by the copyright holders and contributors "as is" and
// any express or implied warranties, including, but not limited to, the implied
// warranties of merchantability and fitness for a particular purpose are disclaimed.
// In no event shall the Intel Corporation or contributors be liable for any direct,
// indirect, incidental, special, exemplary, or consequential damages
// (including, but not limited to, procurement of substitute goods or services;
// loss of use, data, or profits; or business interruption) however caused
// and on any theory of liability, whether in contract, strict liability,
// or tort (including negligence or otherwise) arising in any way out of
// the use of this software, even if advised of the possibility of such damage.
//
package jp.maaash.ObjectDetection
{
	import flash.display.BitmapData;
	
	public class TargetImage{
		private var debug :Boolean;
		public  var bd    :BitmapData;
		public  var _ii   :Vector.<Number>;	// IntegralImage
		public  var _ii2  :Vector.<Number>;	// IntegralImage of squared pixels
		public  var iiw   :int;
		public  var iih   :int;

		public function TargetImage( d :Boolean = true ){
			debug   = d;
		}

		public function set bitmapData(bitmapData:BitmapData):void{
			bd = bitmapData;

			// build IntegralImages
			// IntegralImage is 1 size larger than image
			// all 0 for the 1st row,column
			
			var a:int = bd.width+1;
			var b:int = bd.height+1;
			
			if( a != iiw || b!=iih ){
//				_ii  = new Vector.<Number>(a*b);
//				_ii2 = new Vector.<Number>(a*b);
				
				_ii  = new Vector.<Number>();
				_ii2 = new Vector.<Number>();
			}
			iiw = a;
			iih = b;
			
			for(  i=0; i<iiw; i+=1 ){
				_ii[i] = 0;
				_ii2[i] = 0;
			}
			for( var j:int=1; j<iih; j+=1 ){
				var index:int = j*iiw;
				_ii[ index ] = 0;
				_ii2[ index] = 0;
				for( var i:int=1; i<iiw; i+=1 ){
					var pix :Number = bd.getPixel(i-1,j-1)>>16;
					var index2:int = iiw*(j-1)+i;
					_ii[ index+i ] = _ii[index2]  + _ii[index+i-1]  + pix     - _ii[index2-1];
					_ii2[ index+i ] = _ii2[index2] + _ii2[index+i-1] + pix*pix - _ii2[index2-1];
				}
			}
		}

		public function getSum(x:int,y:int,w:int,h:int):Number{
			var y_iiw   :Number = y     * iiw;
			var yh_iiw  :Number = (y+h) * iiw;
			return _ii[y_iiw  + x    ] +
				   _ii[yh_iiw + x + w] -
				   _ii[yh_iiw + x    ] -
				   _ii[y_iiw  + x + w];
		}

		// sum of squared pixel
		public function getSum2(x:int,y:int,w:int,h:int):Number{
			var y_iiw   :Number = y     * iiw;
			var yh_iiw  :Number = (y+h) * iiw;
			return _ii2[y_iiw  + x    ] +
				   _ii2[yh_iiw + x + w] -
				   _ii2[yh_iiw + x    ] -
				   _ii2[y_iiw  + x + w];
		}

		public function getII(x:int,y:int):Number{
			return _ii[y*iiw+x];
		}

		public function getII2(x:int,y:int):Number{
			return _ii2[y*iiw+x];
		}

		public function get width():int{
			return bd.width;
		}

		public function get height():int{
			return bd.height;
		}

		private function logger(... args):void{
			if(!debug){ return; }
			log(["[TargetImage]"+args.shift()].concat(args));
		}
	}
}
