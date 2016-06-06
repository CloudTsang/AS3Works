package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class LineBtnsPanel extends Sprite
	{
		/**存放按键的数组 **/
		public var lineBtnsArr:Array=new Array;
		/**显示1条兑奖线的数组**/
		private var linesArr:Array=new Array;

		private var cell:LineBtn;
		
		public function LineBtnsPanel()
		{
			for(var i:int=1;i<=2;i++){
				for(var j:int=1;j<=10;j++){
					var cell:LineBtns=new LineBtns;
					cell.NumTxt.text=String((i-1)*10+j);
					cell.y=(j-1)*47;
					cell.x=(i-1)*1070;
				
					cell.addEventListener(MouseEvent.ROLL_OVER,mouseHandlerON);
					cell.addEventListener(MouseEvent.ROLL_OUT,mouseHandlerOFF);				
					this.addChild(cell);
					lineBtnsArr[(i-1)*10+j]=cell;
				}
			}
		}
		
		//鼠标移入移出显示兑奖线的函数
		private function mouseHandlerON(event:MouseEvent):void{
			//查找鼠标按下的按钮在数组中的位置
			var tmp:int=lineBtnsArr.indexOf(event.target);
			lineBtnsArr[tmp].goShow();
			this.addChild(linesArr[tmp]);
		}		
		private function mouseHandlerOFF(event:MouseEvent):void{
			var tmp:int=lineBtnsArr.indexOf(event.target);
			lineBtnsArr[tmp].goFps();
			this.removeChild(linesArr[tmp]);
		}
		
		/**画兑奖线函数
		 * @param mark=标记行数
		 * @param num=兑奖线编号**/
		public function  drawLine(mark:String,num:int):void{				
			var tmpArr:Array=mark.split(/ /);			
			var line:Sprite=new Sprite;
			line.graphics.lineStyle(20,0x00ff00);
			line.graphics.moveTo(150,tmpArr[i]*100+(tmpArr[i]-1)*50);
			for(var i:int=1;i<5;i++){
				line.graphics.lineTo(150+i*200,tmpArr[i]*100+(tmpArr[i]-1)*50);
			}	
			linesArr[num]=line;
		}
		public function showPrize(n:int):void{
			lineBtnsArr[n].setState("prize");
			addChild(linesArr[n]);
		}
	}
}