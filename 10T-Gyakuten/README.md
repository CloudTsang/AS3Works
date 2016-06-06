###模仿*逆转裁判*的调查系统


####目的
这个作品的目的是学习配置文档的使用，xml和json都试过，文档什么时候应该用loader加载还是Embed内嵌完全看心情。

####设想
原来是想做成一个**盗窃游戏**，在场景中调查事物，见到合心意的就**“偷走”**，背包的**“重量”**会不断增加，超过临界值就gameover，之后按照设定好的**“价值”**计算分数。

不用说这个并没有做到最后...

按A/S键切换两个场景，按着Ctrl点击背景可以**“收下”**（可以被收下的）财物。

虽然文字播放效果只做了最基本的一种，但是像不像*逆转*呢？我觉得看到**“收下”**操作的时候应该能够感受到这是在模仿*逆转*了吧。
<img src="https://raw.githubusercontent.com/CloudTsang/AS3Works/master/picture/gyakuten2.png"/>
<img src="https://raw.githubusercontent.com/CloudTsang/AS3Works/master/picture/gyakuten1.png"/>
```as3
/**
		 * 设置对话文本框
		 * @param log：对话文本
		 * @param ifTalk：是否有说话人
		 * @param talker：说话人名字
		 * @param ifCenter：是否居中
		 * @param color：颜色 ，默认为黑色0，绿色1，蓝色2
		 * @param ifStress：是否强调，强调后字号变大为75
		 * */
		public function LogPad( log:String ,talker:String=" ", ifTalk:Boolean=true  , ifCenter:Boolean=false , color:int=0  , ifStress:Boolean=false )
```


由于本来目的只是学习使用json，在实现调查系统上没有很花心思，
只是画了一张图，用不同的颜色区分物件的点击区域，将颜色作为物件的id进行检索。

```as3
for(var i:int=0 ; i<itemJs[scene].length ; i++)
{			
   if( itemJs[scene][i].id==color)return itemJs[scene][i];		
}
return itemJs.Blank;
```

......想来这样做下去会使应用无端多出大量的图片数据吧。
