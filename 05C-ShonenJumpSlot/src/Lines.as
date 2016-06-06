package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Lines
	{
		/**放置20个兑奖线按钮的panel**/
		public var linesBtn:LineBtnsPanel=new LineBtnsPanel;
		
		/**20条兑奖线的数组**/
		public var linesArr:Vector.<Object>=new Vector.<Object>()
		public function Lines()
		{			
			super();	
			linesArr.push
				(
					 LineObj(1,"1 1 1 1 1"),
					 LineObj(2,"1 2 1 2 1"),
					 LineObj(3,"1 2 3 2 1"),
					 LineObj(4,"1 3 1 3 1"),
				   	 LineObj(5,"2 2 2 2 2"),
					 LineObj(6,"2 1 2 1 2"),
					 LineObj(7,"2 3 2 3 2"),
					 LineObj(8,"3 3 3 3 3"),
					 LineObj(9,"3 2 3 2 3"),
					LineObj(10,"3 2 1 2 3"),
					
					LineObj(11,"1 3 3 3 1"),
					LineObj(12,"1 2 2 2 3"),
					LineObj(13,"1 2 3 1 1"),
					LineObj(14,"2 3 3 2 1"),
					LineObj(15,"2 1 2 3 2"),
					LineObj(16,"2 2 3 3 3"),
					LineObj(17,"2 3 2 1 2"),
					LineObj(18,"3 2 1 1 2"),
					LineObj(19,"3 1 3 1 2"),
					LineObj(20,"3 1 1 1 3")
				);
			linesBtn.x=35;
			linesBtn.y=40;
			for(var k:int=1;k<=20;k++){
				linesBtn.drawLine(linesArr[k-1].Mark,k);
			}
		}
		
		/**设置第no条线的c中奖标记数与p中奖金额**/
		public function setCountPrize(no:int,c:int, rc: int ,p:Number):void{
			linesArr[no].Count=c;
			linesArr[no].revCount=rc;
			linesArr[no].Prize=p;
		}
		
		/**返回标记行数**/
		public function getMark(m:int):String{
			return linesArr[m].Mark;
		}
		
		/**返回投注线数据**/
		public function getLineData(no:int):Object{
			var tmp:Array=new Array(
				"\n线编号",linesArr[no].No,
				"\n标记行数",linesArr[no].Mark,
				"\n正向中奖标记个数",linesArr[no].Count,
				"\n反向中奖标记个数",linesArr[no].revCount,
				"\n彩金",linesArr[no].Prize,
				"\n线有效",linesArr[no].Switch);
			return tmp;
		}
		
		/**返回彩金**/
		public function getPrize(no:int):Number{
			return linesArr[no].Prize;
		}
		
		/**设置有效投注线数**/
		public function setLine(no:int):void{
			for(var i:int=0;i<no;i++){
				linesArr[i].Switch=true;
			}
			for(i=no;i<20;i++){
				linesArr[i].Switch=false;
			}
		}
		
		/**设置兑奖线按钮的状态**/
		public function setLines(arr:Array,s:String):void{
			for(var i:int=0;i<arr.length;i++){
				linesBtn.lineBtnsArr[arr[i]+1].setState(s);
			}
		}
		
		/**
		 * No:线编号
		 * Mark:标记行数
		 * Prize:彩金
		 * Count:中奖标记个数
		 * revCount:从右到左的中奖标记个数
		 * Switch:线有效?
		 **/
		private  function LineObj(no:int,mark:String,c:int=0,rc:int=0,prize:Number=0,swit:Boolean=false):Object{
			var tmpObj:Object={
				No:no,              
				Mark:mark,
				Count:c,
				revCount:rc,
				Prize:prize,
				Switch:swit			
			}
			return tmpObj;
		}
		
	}
}