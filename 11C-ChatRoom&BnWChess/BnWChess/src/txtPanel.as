package
{
	import flash.events.Event;
	import flash.text.TextField;
	
	public class txtPanel extends Texts
	{
		private var txtVec:Vector.<TextField>;
		public function txtPanel()
		{
			super();	
			txtVec=new <TextField>[txtWScore , txtBScore , txtWStatus , txtBStatus];
		}

		/**设置文本函数
		 * @param num: 0=自己的分数 ， 1=自己的状态 ， 2=对方的分数 ，3= 对方的状态
		 * @param str：文本
		 * **/
		public function setText(strW:String="" , strB:String="" , strC:String=""):String{
			if(strW!="")txtVec[2].text=strW;
			if(strB!="")txtVec[3].text=strB;
			if(strC!="")txtColor.text=strC;
			return "设置文本成功";
		}
		public function renewScore(sW:int , sB:int):void{
			txtVec[0].text=String(sW);
			txtVec[1].text=String(sB);
		}

		public function emptyWarn(e:Event=null):void{
			txtVec[GameData.thisColor+2].text="请将棋子放置在空格上！";
		}
		public function eatWarn(e:Event=null):void{
			txtVec[GameData.thisColor+2].text="走这里不能翻转棋子！";
		}
		public function passed():void{
			txtVec[GameData.thisColor+2].text="你被pass了。";
			txtVec[1-GameData.thisColor+2].text="对方还能再走一步。";
		}
		public function passing():void{
			txtVec[GameData.thisColor+2].text="你还能再走一步";
			txtVec[1-GameData.thisColor+2].text="对方被pass了。";
		}
		
		
		public function OreNoTurn(e:Event=null):void{
			txtVec[GameData.thisColor+2].text="轮到你的回合了";
			txtVec[3-GameData.thisColor].text="正在等待中";
		}
		public function OmaiNoTurn(e:Event=null):void{			
			txtVec[GameData.thisColor].text="请耐心等待。";
			txtVec[3-GameData.thisColor].text="正在思考中...";
		}
		
	}
}