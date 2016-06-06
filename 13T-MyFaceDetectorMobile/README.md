###面部识别

用网上找到的OpenCV移植到AS3的人脸识别工具做的小东西。

没有太深入研究图像算法，只是简单地用FileReference读取图片进行

识别。

要让图片以合适大小显示在界面上还写了一个更改图片尺寸的类。


```
bmp.bitmapData=resizer.changeImgSize( bmp.bitmapData );
detector.detect(tmp);			
```

准确度微妙...无论是先适配尺寸再检测还是反过来都会有不准确的情况。

*小黛无人权系列*

<img src="https://raw.githubusercontent.com/CloudTsang/AS3Works/master/picture/face1.png"/>

*又比如将Big Boss传进去可能会检测到眉间是人脸~~果然是假货~~*

大致上如果图片中人脸占得比较多~~比如非主流自拍大头照~~的时候就会失败，正常的站远一点照的相片识别度比较高。当然我也不理解OpenCV是怎么做这个的，只是做一个小玩意。