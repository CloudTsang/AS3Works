# 01C-Ballgame
撞球游戏

初学as3时做的一个撞球游戏，包含Timer、鼠标事件、碰撞检测和简单的绘图等等，但是没有做碰撞和加速度的物理计算，球碰到挡板反弹的入射和出射角是一样的，所以只要鼠标跟着球动就不会gameover:-D

``` as3
if(ball.x-R<=bar3.x+bar3.width && ball.y+R>=bar3.y && ball.y-R<=bar3.y+bar3.height)
```
此外碰撞检测也做的很简单，这个时候连hitpixel、hitTest之类的方法都还不会用，虽然这里玩起来应该是没什么问题，但是偶尔看上去会有球嵌进了挡板中的景象
还有像这样的代码

``` as3
if(ball.x>rightborder+20 || ball.x<leftborder-20 || ball.y<upborder-20 || ball.y >downborder+20)
```
可能是当时想着球一直在运动所以如果没有±20的话在做出球飞出界gameover的时候画面上看起来球还是在界内的。

<img src="https://raw.githubusercontent.com/CloudTsang/AS3Works/master/picture/ballgame1.PNG" width="500"/>