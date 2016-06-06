##A*寻路+步行动画
A星自动寻路的入门

* [步行动画](#anime)

* [astar](#astar)

* [地图](#map)


###<p id="anime">步行动画</p>

从*RPG Maker*处找来的任务行走素材图，切割成16格放在一个二维数组中播放。
```as3
imageArr.push(AnimationFactory.imgListFactory(this.bitmapData,i,4,wid,hei));
...
img.bitmapData=imageArr[movement][currentIndex];
```
然而效果微妙...或许由于找来的素材并不能很好地切割成16份，角色走起来一顿一顿的~~迷之带感~~明显不连贯。

移动相关的2个函数，没有处理得很严谨，设计成角色会移动到下一个目标格子的左上角坐标，于是在走到最后1格或者找不到路径时角色会“瞬移”到格子的左上角，也不会很精确地避开障碍物。
```as3
public function moveToHere(e:MouseEvent):void{		
			timer.stop();
			//生成起点和终点
			start=new Point( (img.x+img.width/2) , (img.y+img.width/2) );
			end=new Point(e.stageX,e.stageY);	
			img.x=start.x-wid/2;
			img.y=start.y-hei;
			astarIndex=0;		
			astar=Map.getRoute(start , end );
			if(astar!=null){
				PointToNextTarget(1)
				timer.start();
				dispatchEvent(new Event("path found"));
			}	
		}

private function moveHandler(e:TimerEvent):void{

			if( Point.distance(new Point(img.x , img.y) , end) <=20 ) {
				if(astarIndex==astar.length-1)	{
					timer.stop();
					img.bitmapData=imageArr[movement][0];
					return;
				}			
				astarIndex++;
				PointToNextTarget(astarIndex);
			}
			img.bitmapData=imageArr[movement][currentIndex];
			if(currentIndex<3)currentIndex++;
			else currentIndex=0;		
			img.x+=xspeed
			img.y+=yspeed
		}		
```

###<p id="astar">astar</p>

虽然看教程原理是好理解的，但是基本的A星代码并不能应对各种情况，性能也有待优化，只是做出来一个效果并不能说明什么。
```as3
public static function getRoute(start:Point , end:Point):Vector.<Node>{
			var astar:AStar=new AStar;
			grid.setStartNode( start.x/nodeDist , start.y/nodeDist );
			grid.setEndNode(end.x/nodeDist , end.y/nodeDist);
			if(astar.findPath(grid)==true)return astar.path
			else return null;
		}
```


###<p id="map">地图</p>

为了测试astar简单地还做了加载地图的功能，但只是1张图片，在白色背景上拉了几个黑方框。扫描时将黑方框部分节点设为不可行。
```as3
		private function onload(e:Event):void{
			var bmp:BitmapData=Bitmap(loader.content).bitmapData;
			var i:int=bmp.width/nodeDist;
			var j:int=bmp.height/nodeDist;
			grid=new Grid(i , j);
			for(i=bmp.width/nodeDist ; i>0 ; i--)
			{
				for(j=bmp.height/nodeDist ; j>0 ; j--)
				{				
					if(bmp.getPixel( i*nodeDist , j*nodeDist ) == 0x000000) grid.setWalkable(i -1, j-1 , false);
				}
			}		
		}
```

<img src="https://raw.githubusercontent.com/CloudTsang/AS3Works/master/picture/astar1.png"/>