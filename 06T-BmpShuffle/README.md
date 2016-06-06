##洗牌效果

* [洗牌](#shuffle)
* [光球](#light)
* [测试](#test)

学习使用bitmap、bitmapdata、matrix等图像相关类的使用。

只是练习实现一些图像效果，代码写的十分杂乱。

###<p id="shuffle">洗牌</p>

1000张牌的同轴、随机速度、距离的洗牌效果，可以拖动1张牌。
同轴转动用的是flash pro那边的matrixtransfromer，比flash builder的matrix好用，不需要做太多矩阵计算。
```as3
MatrixTransformer.rotateAroundExternalPoint
(转动对象 ，轴x ， 轴y ， 转动速度);
```
主要的图像更新尝试了2种方法，

1是一张大bitmap
```as3
function plentyOfPokeSpinning(m:Vector.<Matrix> , p:Vector.<Point>, r:Vector.<Number>,n:int):BitmapData{		
				bmpd.fillRect(bmpd.rect, 0x00000000);
				for(var i:int=0;i<n;i++){
					MatrixTransformer.rotateAroundExternalPoint( m[i] , 600 , 300 , r[i] );
					bmpd.draw(f , m[i]);
				}			
				return bmpd;
			}	
```
2是1张牌1个bitmap
```as3
function plentyOfPokeSpinning2(m:Vector.<Matrix> , p:Vector.<Point>, r:Vector.<Number>,n:int):void{			
				var img:Bitmap;
				for(var i:int=0;i<n;i++){
					MatrixTransformer.rotateAroundExternalPoint( m[i] , 600 , 300 , r[i] );		
					imgvec[i].transform.matrix=m[i];
				}
			}	
```
虽然听说应该是1好，但是可能我写的方法还是有差，方法1要draw很多次而方法2只要计算并改掉每个bitmap的matrix就好，外加想到之后想做拖动扑克的效果还是决定每张牌单独处理。



###<p id="light">光球</p>

原本是想做光球向上飘浮的柔和、虚幻的效果。

结果却变成了一堆白球很鬼畜地向上窜...なにがおかしいと思う...
```as3
public function renewData():BitmapData{		
			this.fillRect(this.rect, 0x00000000);
			for(var i:int=mVec.length-1 ; i>=0 ; i--){
				mVec[i].ty-=Math.random()*20;
				mVec[i].tx+=Math.random()*4-2;
				this.draw(bmpd,mVec[i]);
			}
			return this;
		}
```
更新光球位置的代码，所谓漂浮也应该有一定的方向和规律的，这里做的完全随机了，而且移动的时间间隔也是用timer同步，光球一直在抖。。。

按z键可开关光球效果。

###<p id="test">测试</p>

cpu是i53230，牌面图案分辨率很低（原图太大），只有洗牌时50fps，加上光球40。

<img src="https://raw.githubusercontent.com/CloudTsang/AS3Works/master/picture/shuffle1.png"/>

*这里的50+fps其实是停止了光球效果*
