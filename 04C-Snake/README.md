###抢食蛇

最多可以同时控制3条蛇的贪吃蛇游戏。

*~~但是因为是手机项目场地没法做得很大，真的玩起3条蛇来根本就是無理ゲーム...挑战一下吧~~*

这里学习了SharedObject和Sound相关类的使用，成为**第一个有BGM**和记录功能的作品。

开始会自己写类，而且做得比较完整，标题菜单+游戏+game set处理都有了，还有一些设置项，做的比以前的作品复杂得多。

还在继续练习使用数组，碰撞情况并没有俄罗斯方块复杂，但是写多条蛇的碰撞检测时还是很笨拙地用了很长的判断语句
```as3
while(
TouchTest(Gems.gemsARR,snake1.snake,"GemSnake")==true 
|| TouchTest(Gems.gemsARR,snake2.snake,"GemSnake")==true 
|| TouchTest(Gems.gemsARR,snake3.snake,"GemSnake")==true)
```
*如果再多加几条蛇的话我大概会一直写下去...*

做得时候还是没有很好地考虑全局，将整个场地+蛇+宝石做成一个二维数组，而是想到什么就先做了，于是碰撞检测也分开了做，还做成了
```as3
场地边缘 type=="Field"
蛇与宝石 type=="SnakeGem"
蛇与蛇 type=="SnakeSnake"
宝石与蛇（判断宝石有没有生成在蛇身上）type=="GemSnake"
```
4种主从有别的情况，做检测时也要轮流调用4种type的函数，变得很复杂。

<img src="https://raw.githubusercontent.com/CloudTsang/AS3Works/master/picture/snake1.png"/>
<img src="https://raw.githubusercontent.com/CloudTsang/AS3Works/master/picture/snake2.png"/>
