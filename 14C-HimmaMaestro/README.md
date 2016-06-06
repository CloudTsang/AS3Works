##搬砖大师Himma Maestro
AS3的等角小游戏。

* [简介](#promo)
* [关卡](#stage)
* [菜单](#menu)
* [场地](#field)
* [乌鸦](#bird)
* [砖块](#brick)
* [道具](#item)
* [操作](#ctrl)

初看等角投影◇Isometric Projection的教程时，因为很喜欢*Final Fantay Tartics*，所以感觉要自己能做出来一个完整的什么东西的话就是用等角了，不过这个只是个2D小游戏，和*FFT*那样的3D SLG没有半毛钱关系...

对于不能旋转视角的2D等角，要怎样做到即使被方块遮住了视角也能愉快的玩耍呢？思考的结果就是这样的搬砖游戏，可以把方块搬开，也加入了在关卡开始时检视全部方块的功能等等。

##<p id="promo">简介</p>

游戏目的就是**把积木搬到相同颜色的格子**上

...等等这是**学龄前儿童的玩具**吗？

~~为了掩饰这个本质~~加入了简单的道具、时间和方块种类等要素。逐渐地成为了目前做过的最复杂的东西。

####玩法
游戏操作有4个，抬踩踢防。砖块的设计也是有些只能抬有些只能踩。

只能抬起力量值数量的砖块，1次只能抬1块，所以将眼前的一栋砖块
抬起再放下的话就可以倒置。

只能踩在低于主角身高的砖块上，会直接踩到整栋砖块上。

踢出会将踩着的最下面1块砖头放置到前面1个，相当于抬起的逆操作。

放下会将抬起的全部砖块放到前面一个，相当于踩的逆操作。

*(这次尝试写了一些接口、继承之类的东西，但是不能确定是不是真的有用到位...)*

<img src="https://raw.githubusercontent.com/CloudTsang/AS3Works/master/picture/Himmae2.png"/>

###<p id="stage">关卡</p>
并没有在关卡设计上下功夫，都是为了测试功能乱写的，

~~所以这个游戏大概实际上不能顺利游玩てへぺろ(•ω<)~~

配置文档的关卡信息格式是这样的
```as3
{
    "width": 宽多少格,
    "height": 长多少格,
    "size":格子尺寸,
    "hero":{"x": , "z":},主角的初始位置
    "timelimit":时间限制,
    "scorelimit":最低通关分数,
    "floor":
    [
    {"x": , "z": , "t":" "}得分地板坐标和颜色
    ],
    "box":
    [
    {"x": , "z": , "h": , "t":["  "] } 方块的坐标、高度、颜色，一定要x（z）小的排前面。
    ] ,
    "bird":
    [  
    {"time": , "direction": , "type":[" "], "target":{"x": , "z":} , "speed":}丢下砖头的时间、方向、颜色、目标、速度
    ]
  }
```

##<p id="menu">菜单</p>

玩过的应该能看得出是模仿The Phantom Pain的“道具选择-时间选择-出击”的菜单项。~~虽然其实只有BGM一样而已。~~

<img src="https://raw.githubusercontent.com/CloudTsang/AS3Works/master/picture/Himmae1.png"/>

*BGM:METAL GEAR SOLID PEACE WALKER Main Theme*

菜单主要功能是确定生成一个关卡需要的最低限度的信息：关卡编号、道具开放数量、出击时间
```as3
		function selUp():void;
		function selDown():void;
		function nextMenu():void;
		function prevMenu():void;
		function get stageInfo():StageInfo;
```

每层菜单是key-value，key是菜单名，value是选项的数组，每个菜单项就是这样1个Object：
```as3
{
"selection":"选项", 
"description":"描述" , 
"prev":null , 
"next":null , //指向上、下层菜单的名称
"id":null
} //当next是event时根据这个id来处理

```

##<p id="field">场地</p>
从网上找来的等角对象类，修改了一下用来做关卡，出现困难的地方主要在于，原类中用的sprite来画等角对象，坐标原点在正中间，这里因为个人的小执着想要用1个bitmap来做地板连砖块整个关卡，坐标原点只能是左上角，也不能有负坐标，经过一些计算之后写了一些偏移量之类的东西。
```as3
f=地板 s=地板上方的空间 ofs=偏移

public function PartsSize(hud:int , sky:int , size:int , cellX:int , cellZ:int)
		{
			_size=size;
			_fH=size*(cellX+cellZ)/2;
			_fW=size*(cellX+cellZ);
			_sW=_fW+hud;
			_fsH=sky
			_sH=_fH+_fsH;
			
			_ofsX=cellX*size;
			_ofsY=size/2;
		}
```
计算一些坐标数值，其实并不是什么严谨推导出来的算式，只是测试的时候“啊，长比宽多2格的时候就会偏掉这么多。”这样的情况然后
算了一下得到的。~~所以几乎直到最后阶段都仍然有需要调整的地方。~~


更新砖块的函数，在开始游戏时要按每一层来更新，代码稍有不同。
```as3
public final function renewWorld( arr:Array=null ):void
		{
			_bmpdBox.fillRect(_bmpdBox.rect , 0x000000);
			var box:Box; 
			var pos:Point3D=new Point3D;
			for(var i:int=0 ; i<arr.length ; i++){
				pos.x=i*_cellSize;
				for(var j:int=0 ; j<arr[i].length ; j++){
					pos.z=j*_cellSize;
					for(var h:int=0 ; h<arr[i][j].length ; h++){
						pos.y=-h*_cellSize;
						box=BoxFactory.instance.getBoxDisplay( arr[i][j][h] );
						box.position=pos;
						_bmpdBox.draw(box , new Matrix(1,0,0,1 , box.screenX+_offsetX , box.screenY+_offsetY+_bmpFloor.y));
					}
				}
			}
		}
```

##<p id="bird">乌鸦</p>

想到就这么搬砖就很无聊于是添加了一些事件，其中之一就是会有乌鸦把砖块丢下来。

~~Black Feather 丢砖头的卡拉斯~~

如果能正确判断砖头落下的位置在下面等着的话，就能无视力量值（高度）将砖头举起来（踩住）。看似很方便但是根据关卡设计也有可能造成困局。

因此虽然想做成乌鸦事件会随机出现，但是随机过头搞的过不了关的话就没意义，于是还是当做固定事件写进了配置档中，设计成一定几率会出现。

~~说了这么多害怕过不了关的话但是这个游戏没有关卡设计~~

出现乌鸦事件的函数

```as3
public function createBird():Bitmap{
			var targetPos:Point=new Point(_currentBird.target.x ,_currentBird.target.z)
			targetPos=_scal.getBoxScreenPosition( targetPos.x , targetPos.y ,  _world.getCellData(targetPos.x , targetPos.y).length );		
			_bmp=createBoxs(_currentBird.type);
			_bmp.x=_currentBird.direction*_stageWidth;
			_bmp.y=0;		
			_myTween=new TweenLite(_bmp , _currentBird.speed , {x:targetPos.x-_cellSize+HM.HUD_WIDTH , y:targetPos.y-_bmp.height , onComplete:onDropComplete})
			this.addChild(_bmp);
			return _bmp;
		}
```

##<p id="brick">砖块</p>

不同的砖块有不同的属性，一些能抬一些不能抬，所以不能出现类似“只能踩的砖块在只能抬的砖块上面”这种情况。于是做了一个排序函数，当乌鸦丢下的砖块落地时会自动整理成合理的情况。
```as3
/**将方块排序，自动将不能踩的方块放在上面，不能举的方块放下面**/
		public function BoxSort(arr:Array):Array{
			var sortArr:Array=new Array;
			var tmpArr:Array=new Array;
			for(var i:int=0; i<arr.length ; i++){
				tmpArr.push(
					{
						type:arr[i],
						value:getBoxProp( arr[i].split("&")[0] , HM.BOX_VALUE)
					}
				)
			}
			tmpArr.sortOn(HM.BOX_VALUE);
			for(i=0 ; i<tmpArr.length ; i++) sortArr.unshift( tmpArr[i].type );
			return sortArr;
		}
```

还设计了一些印有数字的砖块，当这些砖块上面的砖块数量超过的数字时，这个砖块就会“爆炸”然后发生加分扣时间之类的事件。最初设计这一种砖块时，只是想让一块不能被移动的砖块堵住下面的砖让人不得不想办法解决它，之后便逐渐想要增加一些特殊事件。

关于爆炸的处理意外的感到吃力，是到了大后期才成功运作的功能之一，面对一栋砖块里有多次爆炸的时候，要1块1块的来让人看清楚，代码如下：
```as3
for(_index ; _index<arr.length ; _index++){
					_tmp=getExplosion( arr[_index] );
					if(_tmp.isExplode(arr , _index)){
						_hook=true;
						setTimeout( Explode , 500 , world , arr , x , z );
						break;
					}
				}
```

爆炸事件要实现这个接口
```as3
public interface IExplosion
	{
		function Explode(arr:Array=null , h:int=0):Array;
		function isExplode(arr:Array=null , h:int=0):Boolean;
	}
```

只会自己爆掉的爆炸的类
```as3
        /**@param sub :  爆炸时改变的数值（时间/分数） ， 默认为null，没有改变
		 * @param type :  改变数值时的改变，这里只能传入1或-1，代表是“加”还是“减”，改变的数值是count
		 * @param bgs :  爆炸时的音效
		 * **/
		public function Explosion_Delete(count:int , bgs:String , sub:ISubject2=null , type:int=1)

        public function Explode(arr:Array=null , h:int=0):Array{
			arr.splice(h,1);
			if(_sub)	_sub.param+= (_count*_type);
			return arr;
		}

        public function isExplode(arr:Array=null , h:int=0):Boolean{
			return arr.length-h>_count;
		}

```

这样的话就算想要加入“爆炸时会整栋砖头消失”的行为也能很快地做到了。

于是砖头的特殊情况有“需要排序”和“可能爆炸”两种，在worlddata中写了这个函数处理：
```as3
		private function specialTest(arr:Array,x:int , z:int,explode:Boolean=false ,sort:Boolean=false ):Array{
			if(sort)arr=BoxFactory.instance.BoxSort(arr);
			if(explode)_explode.Explode(this , arr , x, z);
			return arr;
		}
```


##<p id="item">道具</p>
设计了3种道具效果：

力量砖块：游戏开始时直接踩着复数个力量砖块

捕鸟器：降低乌鸦出现几率

探照灯：能够在侧栏显示出正面复数列砖头的排列情况~~因为2D经常被遮住~~

道具要实现这一个接口
```as3
public interface IItem
	{
		function useItem():void;
		/**该道具是否有显示对象**/
		function haveDispObj():Boolean;
		/**获取显示对象,返回一个DisplayObject的向量**/
		function get DispObj():Vector.<DisplayObject>;
	}
```

其中探照灯是比较复杂的功能,单独写了Light类来继承
```as3
public class ItemLIGHT extends Light implements IItem
```
更新探照灯的函数
```as3
public function Renew(e:Event=null):void{
			if(_range==-1)return;
			_bmpd.fillRect(_bmpd.rect , 0x000000);
			var drc:Point=_hero.direction;
			var fpos:Point=_hero.front;
			if(fpos.x<0 || fpos.x>=_world.height || fpos.y<0 || fpos.y>=_world.width)return;
			var cpos:Point=new Point();
			var arr:Array;
			for(var i:int=-_range ; i<=_range ; i++){
				cpos.x=fpos.x+Math.abs(drc.y)*i;
				cpos.y=fpos.y+Math.abs(drc.x)*i;
				if(cpos.x<0 || cpos.x>=_world.height || cpos.y<0 || cpos.y>=_world.width)continue;
				arr=_world.getCellData(cpos.x , cpos.y);
				for(var j:int=0 ; j<arr.length ; j++){
					_cellBmpd=drawCell(arr[j]);
					_bmpd.copyPixels( _cellBmpd , _cellRect , new Point( i*CELLSIZE+_bmpd.width/2 , _bmpd.height-(j+1)*CELLSIZE));
				}
			}
			_bmp.bitmapData=_bmpd;
		}
```

##<p id="ctrl">操作</p>

看到了网上遥控器的例子做了这一部分，虽然感觉不错，但是**写了很多的Command类不禁有点心虚**...

标准的Command接口
```as3
public interface ICommand
	{
		function isExcutePermitt():Boolean;
		function excute():void;
	}
```
在controller中装载各种command
```as3
protected override function setCommand(...args):void{
			var world:IWorldData;
			var hero:IHero;
			var goal:IGoal;
			for(var i:String in args){
				if(args[i] is IWorldData) world=args[i];
				else if(args[i] is IHero) hero=args[i];
				else if(args[i] is IGoal) goal=args[i];
			}
			_command.push(
				new ActCommand_Walk(world ,hero ,0,-1),	
				new ActCommand_Walk(world ,hero ,0,1),	
				new ActCommand_Walk(world ,hero,-1,0),	
				new ActCommand_Walk(world ,hero ,1,0),	
				new ActCommand_Lift(world ,hero),
				new ActCommand_Step(world ,hero),
				new ActCommand_Down(world ,hero),
				new ActCommand_Kick(world ,hero),
				new ActCommand_Goal(goal)
			)		
		}
```


---
余下的就是将各个部分整合起来的关键成员。WorldCreatorさん 和 WorldData2さん了~~还有被抛弃的第1版WorldData~~

作为做过的最复杂的东西，是自我感觉代码写的最好也是最不好的一个，既使尽量细分各个功能，还是出现了不得不大段大段地来的情况，深刻感觉到自己还很鶸。

わたし、強くなりたい

~~一言不合就中二~~

---
这个作品其实是在中途才开始接触了一些所谓设计模式的教程想要尝试一下于是几乎整个重写了一遍，代码是改得比较多，但是乌鸦、道具、爆炸之类的其实一开始就定下来了。

~~之前的我可能会一堆if、switch写到死~~

这之后就是毕业设计了，并不收录在这个作品集之中，
也是一个在简简单单完成了基础功能之后又不断不断地变得更大型更复杂的作品，原因不一样就是了。
























