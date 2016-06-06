package
{
	import flash.display.Sprite;
	
	public class AStar extends Sprite
	{
		/**开放列表**/
		private var _open:Array;
		/**封闭列表**/
		private var _closed:Array;
		private var _grid:Grid;
		/**终点**/
		private var _endNode:Node;
		/**起点**/
		private var _startNode:Node;
		/**最终的路径节点**/
		public var path:Vector.<Node>=new Vector.<Node>;
		/**估计公式**/
		// private var _heuristic:Function = manhattan; 
		// private var _heuristic:Function = euclidian; 
		private var _heuristic:Function=diagonal;
		/**直线代价**/        
		private var _straightCost:Number=1.0; 
		/**对角线代价**/  
		private var _diagCost:Number=Math.SQRT2;       
		
		public function AStar()
		{
			
		}
		
		/**判断节点是否开放列表**/
		private function isOpen(node:Node):Boolean
		{
			for (var i:int=0; i < _open.length; i++)
			{
				if (_open[i] == node) return true;
			}
			return false;
		}
		
		/**判断节点是否封闭列表**/
		private function isClosed(node:Node):Boolean
		{
			for (var i:int=0; i < _closed.length; i++)
			{
				if (_closed[i] == node)return true;
			}
			return false;
		}
		
		/**对指定的网络寻找路径**/
		public function findPath(grid:Grid):Boolean
		{
			_grid=grid;
			_open=new Array();
			_closed=new Array();
			_startNode=_grid.startNode;
			_endNode=_grid.endNode;
			_startNode.g=0;
			_startNode.h=_heuristic(_startNode);
			_startNode.f=_startNode.g + _startNode.h;
			return search();
		}
		
		/**计算周围节点代价的关键处理函数**/
		public function search():Boolean
		{
			var _t:uint =1;
			var node:Node=_startNode;
			//如果当前节点不是终点
			while (node != _endNode)
			{
				//找出相邻节点的x,y范围
				var startX:int=Math.max(0, node.x - 1);
				var endX:int=Math.min(_grid.numCols - 1, node.x + 1);
				var startY:int=Math.max(0, node.y - 1);
				var endY:int=Math.min(_grid.numRows - 1, node.y + 1);               
				
				//循环处理所有相邻节点
				for (var i:int=startX; i <= endX; i++)
				{
					for (var j:int=startY; j <= endY; j++)
					{
						var test:Node=_grid.getNode(i, j);                      
						//如果是当前节点，或者是不可通过的，且排除水平和垂直方向都是障碍物节点时的特例情况
						if (test == node || !test.walkable || !_grid.getNode(node.x, test.y).walkable || !_grid.getNode(test.x, node.y).walkable)
						{
							continue;
						}
						
						var cost:Number=_straightCost;                      
						//如果是对象线，则使用对角代价
						if (!((node.x == test.x) || (node.y == test.y)))
						{
							cost=_diagCost;
						}                       
						
						//估算test节点的总代价                      
						var g:Number=node.g + cost * test.costMultiplier;
						var h:Number=_heuristic(test);                      
						var f:Number=g + h;                 
										
						//如果该点在open或close列表中
						if (isOpen(test) || isClosed(test))
						{
							//如果本次计算的代价更小，则以本次计算为准
							if (f<test.f)
							{
						//		trace("\n第",_t,"轮，有节点重新指向，x=",i,"，y=",j,"，g=",g,"，h=",h,"，f=",f,"，test=",test.toString());                              
								test.f=f;
								test.g=g;
								test.h=h;
								test.parent=node;//重新指定该点的父节点为本轮计算中心点
							}
						}
						else//如果还不在open列表中，则除了更新代价以及设置父节点，还要加入open数组
						{
							test.f=f;
							test.g=g;
							test.h=h;
							test.parent=node;
							_open.push(test);
						}
					}
				}      
				_closed.push(node);//把处理过的本轮中心节点加入close节点               
				
//				辅助调试，输出open数组中都有哪些节点
//				for(i=0;i<_open.length;i++){
//	                	trace(_open[i].toString());   
//				}
				
				if (_open.length == 0)
				{
					trace("没找到最佳节点，无路可走!");
					return false
				}
				_open.sortOn("f", Array.NUMERIC);//按总代价从小到大排序
				node=_open.shift() as Node;//从open数组中删除代价最小的结节，同时把该节点赋值为node，做为下次的中心点
		//		trace("第",_t,"轮取出的最佳节点为：",node.toString());
				_t++;
			}
//			markIndex++;
			//循环结束后，构建路径
			buildPath();
			return true;
		}
		
		/**根据父节点指向，从终点反向连接到起点**/
		private function buildPath():void
		{
			
			path=new Vector.<Node>;
			var node:Node=_endNode;
			path.push(node);
			while (node != _startNode)
			{
				node=node.parent;
				path.push(node);
			}
			path.reverse();
		}
		
		/**曼哈顿估价法**/
		private function manhattan(node:Node):Number
		{
			return Math.abs(node.x - _endNode.x) * _straightCost + Math.abs(node.y - _endNode.y) * _straightCost;
		}
		
		/**几何估价法**/
		private function euclidian(node:Node):Number
		{
			var dx:Number=node.x - _endNode.x;
			var dy:Number=node.y - _endNode.y;
			return Math.sqrt(dx * dx + dy * dy) * _straightCost;
		}
		
		/**对角线估价法**/
		private function diagonal(node:Node):Number
		{
			var dx:Number=Math.abs(node.x - _endNode.x);
			var dy:Number=Math.abs(node.y - _endNode.y);
			var diag:Number=Math.min(dx, dy);
			var straight:Number=dx + dy;
			return _diagCost * diag + _straightCost * (straight - 2 * diag);
		}
		
		/**返回所有被计算过的节点(辅助函数)**/
		public function get visited():Array
		{
			return _closed.concat(_open);
		}
		
		/**返回open数组**/
		public function get openArray():Array{
			return this._open;
		}
		
		/**返回close数组**/
		public function get closedArray():Array{
			return this._closed;
		}
		
	}
}