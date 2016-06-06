####躲避子弹

原来想做一个在范围内躲避敌人的子弹并且射击的小游戏，但是并没有做到最后，只是一个**双摇杆**的测试作品。

但是没有做多点触摸的功能所以不是真正的双摇杆...

点击左半边屏幕移动，右半边屏幕转身。

按S键会出现一个护罩（然而并没有什ry）。

当时还有想到给主角做hp、atk、buff等功能
```as3

public function MakeBuff(buff:String,buffRptCnt:int=1):void {
			switch(buff){
				case "poison":
					poisonTimer.repeatCount=10;
					poisonTimer.start();
				case "barrier":
					barrierTimer.repeatCount=10;
					barrierTimer.start();
					break;
				case "regen":					
					regenTimer.repeatCount=5;
					regenTimer.start();
					break;
			}
		}
```
这时候当然还不会什么接口、模板工厂之类的，所以全部buff都写到1个类。

<img src="https://raw.githubusercontent.com/CloudTsang/AS3Works/master/picture/bullet1.png"/>