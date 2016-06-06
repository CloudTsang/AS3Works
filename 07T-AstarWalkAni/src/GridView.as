package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class GridView extends Sprite
	{
		private var _cellSize:int=Map.nodeDist;
		private var _grid:Grid;
		
		//构造函数
		public function GridView(grid:Grid)
		{
			_grid=grid;
//			drawGrid();			
//			findPath();
	//		addEventListener(MouseEvent.CLICK, onGridClick);
		}
		
		/**画格子**/
		public function drawGrid():void
		{
			graphics.clear();
			for (var i:int=0; i < _grid.numCols; i++)
			{
				for (var j:int=0; j < _grid.numRows; j++)
				{
					var node:Node=_grid.getNode(i, j);
					graphics.lineStyle(0);
					graphics.beginFill(getColor(node));
					graphics.drawRect(i * _cellSize, j * _cellSize, _cellSize, _cellSize);
				}
			}
		}
		
		/**取得节点颜色**/
		private function getColor(node:Node):uint
		{
			if (!node.walkable)
			{
				return 0;
			}
			if (node == _grid.startNode)
			{
				return 0xffff00;
			}
			if (node == _grid.endNode)
			{
				return 0xff0000;
			}
			return 0xffffff;
		}
		
		/**网格点击事件**/
		private function onGridClick(event:MouseEvent):void
		{
			var xpos:int=Math.floor(event.localX / _cellSize);
			var ypos:int=Math.floor(event.localY / _cellSize);
			_grid.setWalkable(xpos, ypos, !_grid.getNode(xpos, ypos).walkable);
			drawGrid();
			findPath();
		}
		
		/**寻找路径**/
		public function findPath():void
		{
			var astar:AStar=new AStar;
			if (astar.findPath(_grid))
			{
				showVisited(astar);
				showPath(astar);
			}
		}
		
		/**显示open列表与close列表**/
		private function showVisited(astar:AStar):void
		{			
			
			var opened:Array=astar.openArray;
			for (var i:int=0; i < opened.length; i++)
			{
				var node:Node = opened[i] as Node;
				
				graphics.beginFill(0xcccccc);
				if (node==_grid.startNode){
					graphics.beginFill(0xffff00);
				}
				
				graphics.drawRect(opened[i].x * _cellSize, opened[i].y * _cellSize, _cellSize, _cellSize);
				graphics.endFill();
			}
			
			var closed:Array=astar.closedArray;
			for (i=0; i < closed.length; i++)
			{
				node = opened[i] as Node;			
				graphics.beginFill(0xffff00);               
				graphics.drawRect(closed[i].x * _cellSize, closed[i].y * _cellSize, _cellSize, _cellSize);
				graphics.endFill();
			}
		}
		
		/**显示路径**/
		private function showPath(astar:AStar):void
		{
			var path:Vector.<Node>=astar.path;
			for (var i:int=0; i < path.length; i++)
			{
				graphics.lineStyle(0);
				graphics.beginFill(0);
				graphics.drawCircle(path[i].x * _cellSize + _cellSize / 2, path[i].y * _cellSize + _cellSize / 2, _cellSize / 3);
			}
		}
	}
}