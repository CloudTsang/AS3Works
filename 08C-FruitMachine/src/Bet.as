package
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Mouse;
	import flash.ui.MouseCursorData;
	
	public class Bet extends BetButtons
	{
		/**标记下注相关按键的数组**/
		public var betBtnsArr:Vector.<Btn>;
		/**标记下注相关文本的数组**/
		public var txtArr:Vector.<TextField>;
		/**下注倍率相关按键的数组**/
		public var rateBtnsArr:Vector.<Btn>;
		/**下注倍率相关文本的数组**/
		public var rateTxtArr:Vector.<TextField>;
		public function Bet()
		{
			super();
			
			betBtnsArr=new <Btn>[
				btn_Cherry , btn_Orange , btn_Lemon , btn_Heart , btn_Melon , btn_Clover , Btn_777,btn_Bar
			];
			
			txtArr=new <TextField>[
				txt_Cherry , txt_Orange , txt_Lemon , txt_Heart , txt_Melon , txt_Clover , txt_777 , txt_Bar
			];
			
			rateBtnsArr=new <Btn>[
				btn_Bet1 , btn_Bet5 , btn_Bet10 , btn_Bet50
			];
			
			rateTxtArr=new <TextField>[
				txt_Bet1 , txt_Bet5 , txt_Bet10 , txt_Bet50
			];
			
			for(var i:int=7 ; i>=0 ; --i){
				betBtnsArr[i].addEventListener(MouseEvent.CLICK,betsBtn_PressHandler);
			}
			
			for(var k:int=3 ; k>=0 ; k--){
				rateBtnsArr[k].addEventListener(MouseEvent.CLICK,rateBtn_PressHandler);
			}
			
			btn_Plus1.addEventListener(MouseEvent.CLICK,allPlus);
			btn_Reset.addEventListener(MouseEvent.CLICK, allReset);
			btn_Rand.addEventListener(MouseEvent.CLICK,randBet);
			strBtnEnable(false);
			
		}
		private function randBet(e:MouseEvent):void{
			var rand:int;
			for(var i:int=7;i>=0;i--){
				rand=int(Math.random()*21);
				if(GameData.getBet()+rand<=GameData.Money){
					GameData.betArr[i]+=rand;
					txtArr[i].text=String(GameData.betArr[i]);
					if(btn_Str.mouseEnabled==false)	strBtnEnable(true);		
				}
			}
		}
		public function strBtnEnable(b:Boolean):void{
			btn_Str.mouseEnabled=b;
			btn_Str.mouseChildren=b;
			btn_AutoPlay.mouseEnabled=b;
			btn_AutoPlay.mouseChildren=b;
		}
		
		/**单个标记下注**/
		private function betsBtn_PressHandler(e:MouseEvent):void{
			var tmp:int=betBtnsArr.indexOf(e.currentTarget);
			txtArr[tmp  ].text =  String( GameData.setBet(tmp , GameData.betArr[tmp]+GameData.getRate()) );
			if(btn_Str.mouseEnabled==false)	strBtnEnable(true);		
		}
		/**全部+1**/
		private function allPlus(e:MouseEvent):void{
			if(GameData.getBet()>GameData.Money){
				return;
			}
			for(var j:int=7 ; j>=0 ; --j){
				txtArr[ j ].text =  String( GameData.setBet( j  , GameData.betArr[ j ]+GameData.getRate()) );
			}
			strBtnEnable(true);
		}
		/**改变下注倍率**/
		private function rateBtn_PressHandler(e:MouseEvent):void{
			var tmp:int=rateBtnsArr.indexOf(e.currentTarget);
			rateTxtArr[GameData.betRate].textColor=0x0000ff;
			GameData.betRate=tmp;
			rateTxtArr[GameData.betRate].textColor=0xff0000;
		}
		private function allReset(e:MouseEvent):void{
			GameData.resetBet();
			for(var j:int=7 ; j>=0 ; --j){
				txtArr[ j ].text =  String( 0 );
			}
			rateTxtArr[GameData.betRate].textColor=0x0000ff;
			GameData.betRate=0;
			rateTxtArr[GameData.betRate].textColor=0xff0000;
			strBtnEnable(false);
		}
	}
}