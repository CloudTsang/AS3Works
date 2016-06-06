##五轮老虎机
5 Reels Slot Machine

* [滚轮](#reel)
* [中奖](#prize)
* [赌博](#gamble)
* [金币](#coin)

20条兑奖线，赌博功能，可自由开放双向，中奖金币效果，奖金计算正确（大概|||）......

其实是第1个做得比较大且完整的作品，设计上有原型对照，图案使用了*《周刊少年jump》*的主角们，**怀着爱心将全部赔率都设得超高**地完成了。


但因为是完全随机出图，比起水果机的大奖频出，这个则是几乎不会赢钱てへぺろ(•ω<)


###<p id="reel">滚轮</p>

这个作品的时期还没有学习使用bitmap，滚轮的实现是不断生成3个mc往下滚，并删除超出范围的3个，换言之每个轮同时有6或9个mc，效率比较低。~~滚的时候眼都要晃瞎了...~~
```as3
TweenLite.to(_reelArr[k].dispObj,speed,{y:_reelArr[k].dispObj.y+500});
```
*这是第一次用TweenLite系列工具的作品。*

每个图案是这样的一个Object：
```as3
 temp=
 {
Name:"slotName",
dispObj:new SlotLogo,
Odds3:300,
Odds4:400,
Odds5:500
};
```
滚动时只需要"dispObj",计算赔率时只需要"Odds"，然而应用中不分情景地生成着有多余属性的对象，是做得不好的地方。

之后从专业人士处得知了生成1列毫无关系的标记bitmap用遮罩层露出3个然后开始滚动，并且在停止时再把**预先决定好**的结果插入的做法。


由于还有五轮滚动的间隔、BGM配合以及图案检测、兑奖计算之类的时间问题，要注意控制众多按键的mouseEnable，这时还不会用自定义事件，所以使用了很多setTimeOut和Timer,有着不少冗余绕弯和不严谨的地方。


###<p id="prize">中奖</p>

<img src="https://raw.githubusercontent.com/CloudTsang/AS3Works/master/picture/slot2.png"/>
沿着兑奖线检测标记，检测和计算奖金的部分并没有很花事件，时间精力都花在“会动的东西”上了，虽然应该不至于算错，但是算法可能写的比较笨拙。
```as3
/**
		 * 标记检测函数。
		 *@param strArr：五轮检测第几行的数组。
		 * @return
		 * 返回一个Object有以下属性：
		 * Count……该兑奖线中奖标记的个数，
		 * Odd……中奖标记的名称。
		 * */
public function markDetect(strArr:Array):Object
{
...
//去除wild标记，选择第一个不是wild的标记计算赔率 
			oddStr="Wild";
			var j:int=0;
			while(oddStr=="Wild" && j<5){
				oddStr=Reels[j].getName(strArr[j]-1);		
				j++;
			}
...
//中奖标记个数检测  
			for(var l:int=0;l<5;l++)
			{
				if(Reels[l].getName(strArr[l]-1)=="Wild" || oddStr==Reels[l].getName(strArr[l]-1)){
					tmpCount++;				
				}
				else
				{
					break;
				}	
			}
}

	/**
		 * free个数检测
		 * @return 获得的free game次数
		 * */
public function freeDetect():int{
			var FreeArr:Array=new Array(0);//储存每一轮scartter个数 	
			var FGC:int=1
			for(var m:int=0;m<5;m++)
            {
				var tmp:int=0;  
				for (var n:int=0;n<3;n++)
                {
					if(Reels[m].getName(n)=="Free") tmp++; 					
				}
				if(tmp>0)FreeArr.push(tmp);	
			}
...
}

```
百搭和免费游戏标记还有双向兑奖都是后来才加进来，免费游戏标记的检测是完全不一样的“只要有就算中”，双向兑奖没想太多就只是将单向的代码调整了一下再写一遍。

###<p id="gamble">赌博</p>

赢奖之后可以猜牌面，猜中了奖金翻倍，这样的赌博功能是有做的，但是因为和老虎机本身相对独立的功能，图标、按钮什么的很多，于是就分开来用FlashProCS6来做了，这里看不到代码。

此外几乎所有按钮、规则解释面板，都是在Pro里做好了再拿过来用。

<img src="https://raw.githubusercontent.com/CloudTsang/AS3Works/master/picture/slot1.png"/>

<img src="https://raw.githubusercontent.com/CloudTsang/AS3Works/master/picture/slot3.png"/>

###<p id="coin">金币</p>

用找来的素材做了旋转金币的效果，想要做成金币大小不同有透视立体的感觉，实际效果微妙。。。
```as3
private function getNewDot(i:int): CoinEffect{
			var c:CoinEffect=new CoinEffect;
            var scaleArr:Array=new Array;
            for(i;i<c;i++){
				scaleArr[i]=(Math.random()*2-1)/100;
			}
            scaleArr.sort(Array.NUMERIC);
			c.setScale(scaleArr[i]);
			this.addChild(c);
			return c;
		}

```
按数值大小排序scaleArr，让大金币出现在小金币上面。
```as3
		private	function tweenDot(dot:CoinEffect, delay:Number):void {
			TweenLite.to(dot, 3, {physics2D:{velocity:getRandom(150, 450), angle:getRandom(0, 180), gravity:400}, delay:delay, onComplete:tweenDot, onCompleteParams:[dot, 0]});
			}
```	
用tweenlite控制金币往下掉。
