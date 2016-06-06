package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ConvolutionFilter;
	import flash.geom.Point;

	public class Firework
	{
		public function Firework()
		{
						//创建一个跟舞台默认大小一样的BitmapData对象，填充黑色，并通过Bitmap将其显示到舞台上
						var BitmapData0:BitmapData = new BitmapData(550, 400, false, 0x0);
						var Bitmap0:Bitmap = new Bitmap(BitmapData0);
						addChild(Bitmap0);
						//存放“粒子”的数组
						var dotArr:Array = new Array();
						//监听点击舞台的事件
						stage.addEventListener(MouseEvent.MOUSE_DOWN,mouse_down);
						//舞台点击事件响应时调度
						function mouse_down(evt:MouseEvent) {
							//给烟花分配一个随机的颜色（方式：全随机）
							var color:Number = 0xff000000+int(Math.random()*0xffffff);
							//循环500次，也就是为每朵烟花创建500个“粒子”
							for (var i:Number = 0; i<500; i++) {
								//粒子运动速度的大小，在0到10的范围内随机
								var v:Number = Math.random()*10;
								//粒子的运动方向：随机（用弧度指定）
								var a:Number =Math.random()*Math.PI*2;
								//根据产生的速度和方向的数值，算得“粒子”的x和y坐标，并将其对齐到鼠标所点击到的位置上
								var xx:Number = v*Math.cos(a)+stage.mouseX;
								var yy:Number = v*Math.sin(a)+stage.mouseY;
								//将鼠标点击的位置存放到一个Point对象中
								var mouseP:Point=new Point(stage.mouseX,stage.mouseY);
								//产生的“粒子”有40%的概率是白色，60%的概率是color所指定的值。因此运行的时候会看到每朵烟花都会有白色的成分。
								if (Math.random()>0.6) {
									var cc:Number = 0xffffffff;
								} else {
									cc= color;
								}
								/* 将“粒子”加入到数组中
								第一项：xx，粒子当前的x坐标
								第二项：yy，粒子当前的y坐标
								第三项：v*Math.cos(a)，粒子在x轴方向上的速度
								第四项：v*Math.sin(a)，粒子在y轴方向上的速度
								第五项：cc，粒子的颜色
								第六项：mouseP，当前粒子产生的源位置，即鼠标点击的位置
								*/
								dotArr.push([xx, yy, v*Math.cos(a), v*Math.sin(a), cc,mouseP]);
							}
						}
						//创建卷积滤镜，该滤镜实现的是模糊（原理可以查看第二章关于卷积滤镜的介绍）
						var cf:ConvolutionFilter = new ConvolutionFilter(3, 3, [1, 1, 1, 1, 32, 1, 1, 1, 1], 40,0);
						//监听enterFrame事件（对于帧频24的影片而言，该事件每1/24秒发送一次）
						stage.addEventListener(Event.ENTER_FRAME,enter_frame);
						//enterFrame事件响应时调度
						function enter_frame(evt:Event) {
							//循环所有粒子
							for (var i:Number = 0; i<dotArr.length; i++) {
								//在粒子的当前位置给BitmapData设置粒子所指定的颜色值
								BitmapData0.setPixel32(dotArr[0],dotArr[1],dotArr[4]);
								//粒子当前位置按粒子指定的速度移动（为了让粒子的运动不至于太生硬，代码的原创者给速度加入了随机因子）
								dotArr[0] += dotArr[2]*Math.random();
								dotArr[1] += dotArr[3]*Math.random();
								//为当前点的坐标创建一个Point对象
								var dotPoint=new Point(dotArr[0],dotArr[1]);
								//然后运用Point的distance方法判断起点跟当前点的距离是否超过80像素
								var b1:Boolean=Point.distance(dotPoint,dotArr[5])>80;
								//判断x方向和y方向的速度大小之和是否小于0.5
								var b2:Boolean=Math.abs(dotArr[2])+Math.abs(dotArr[3])<0.5;
								//如果粒子已经运动了超过80像素，或者运动速度已经比较慢，小于0.5像素/帧，则有10%的概率将粒子删除。
								if ((b1 || b2) && Math.random()>0.9) {
									dotArr.splice(i,1);
								}
							}
							//对整张位图应用模糊滤镜，使得位图中的每个像素点扩散并逐渐消失
							BitmapData0.applyFilter(BitmapData0.clone(),BitmapData0.rect,new Point(0, 0),cf);
						}
		}
	}
}