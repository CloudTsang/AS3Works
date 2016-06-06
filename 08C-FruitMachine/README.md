###水果机
又称“小玛丽”（？）

在做完老虎机之后再做一个同类的东西。

由于年龄问题完全没见过这东西(•ω<)，规则也不甚明了，但却是很快地就完成了...

当然作为一部赌博游戏机的本质完全没有体现，只是做成可以玩的程度，各种大奖随便出。

要做出转盘的“加速-最高速-减速”的过程，以及BGS的配合。
```as3                                                                                                       
private var  delayArr:Vector.<int>=new <int>[1000,800,600,300,200,200,100,100,200,200,300,600,800,500];
```
直接设了这样的数组，预先决定好转动结果，在提前几个格子开始改变转动timer的delay来减速。

下注方式比老虎机要复杂...等等一些难点，但这个作品做的比较简单。


送灯的时候，虽然做了一下计算，大致划分了顺时针和逆时针的情况，但是24个标记是循环的，并没有完全做到一定沿最短路径点灯，
但是送大奖的时候不会兜一大圈去点亮旁边的灯我就满足了。
```as3
/**送灯，包含结束游戏的处理**/
		public function Prize(e:TimerEvent):void{			
			if(prizeTimer.currentCount==TargetArr.length){
				prizeTimer.reset();
				trace("闪烁标记：",sparkArr);
				GameData.Gamble=GameData.Prize;
				renew_PrizeText();
				renew_MoneyText();
				sparkTimer.start();
				gambleBtnEnable(true);
				this.dispatchEvent(new Event("gameset"));
				return;
			}
			McArr[ TargetArr[prizeTimer.currentCount-1] ].normal();
			gotoTarget(TargetArr[prizeTimer.currentCount]);
		}
		
		/**旋转至目标**/
		public function gotoTarget(t:int):void{
			mcTarget=t;			
			if(Math.abs((mcTarget+13-mcOn))>=10) spinClockWise();
			else spinAntiClockWise();			
		}
```
<img src="https://raw.githubusercontent.com/CloudTsang/AS3Works/master/picture/fruit1.png"/>
