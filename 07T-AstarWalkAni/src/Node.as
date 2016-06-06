package {   
	import flash.geom.Point;
	import flash.globalization.NumberFormatter;

	public class Node
	{
		public var x:int;
		public var y:int;
		/**节点的总代价**/
		public var f:Number;
		/**从指定节点到相邻节点的代价**/
		public var g:Number;
		/**从指定节点到目标节点估算出来的代价**/
		public var h:Number;
		/**标记该节点是否为障碍物**/
		public var walkable:Boolean;//是否可穿越（通常把障碍物节点设置为false）
		/**相对于周边的节点来讲，自身节点称为它们的父节点**/
		public var parent:Node;
		public var costMultiplier:Number=1.0;//代价因子
		
		public function Node(x:int, y:int)
		{
			this.x=x;
			this.y=y;
			walkable=true;
		}
		public function get aNode():Point{
			return new Point(this.x ,this.y);
		}
//		//方便调试输出用的toString函数
//		public function toString():String{  
//			var fmr:NumberFormat = new NumberFormat();
//			fmr.mask = "#.0";
//			return "x=" + this.x.toString() + ",y=" + this.y.toString() + ",g=" + fmr.format(this.g) + ",h=" + fmr.format(this.h) + ",f=" + fmr.format(this.f);
//		}
	}
}