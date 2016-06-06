###手势识别
课程设计之一，一个没什么高深图像算法的、识别度微妙的手势识别应用。

将视频画面做模糊处理

```_vid.filters = [new BlurFilter(10,10 , 1)];```

转换为BitmapData后，对新旧两帧图像做混合帧处理得出运动中手部的大致范围矩形

``` as3
_blendFrame.draw(_newFrame, null, null, BlendMode.DIFFERENCE);
			_blendFrame.threshold(_blendFrame, _blendFrame.rect, new Point(), "<", 0x00330000, 0xff000000, 0x00FFffff, true);
```

*~~旋转和拉伸？あんなものどうでもいい！~~*

扫描矩形内的RGB，与阈值比较得到二维数组，然后进行模板匹配。

此外还做了即使捕捉并存储手势的功能。

因为是简单粗暴的做法，识别效果受环境光和背景对比度影响严重，性能也很低。

<img src="https://raw.githubusercontent.com/CloudTsang/AS3Works/master/picture/cap1.png"/>
