package
{
	public class GameData
	{
		/**总金额**/
		public static var Money:int=5000;
		/**赢奖**/
		public static var Prize:int=0;
		/**赌博额度**/
		public static var Gamble:int=0;
		/**下注**/
		public static var Bet:int=0;
		/**下注倍率。值为0，1，2，3，是下注倍率数组rateArr的索引**/
		public static var betRate:int=0;
		/**全部24个标记各自的赔率数组**/
		public static var oddArr:Vector.<int>=new <int>[
			10 , 20 , 125 , 150 , 100 , 5 , 15 , 20 , 2 , 0 , 5 , 2 , 10 , 20 , 2 , 50 , 5 , 2 ,15 , 25 , 2 , 0 , 5 , 2
		];
		/**8种标记的下注金额数组**/
		public static var betArr:Vector.<int>=new <int>[ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
		/**下注倍率数组**/
		public static var rateArr:Vector.<int>=new <int>[1 , 5 , 10 , 50];
		public function GameData()
		{
		}
		/**计算赢奖金额
		 * @param arr：中奖标记号码
		 * @return 赢奖金额**/
		public static function getPrize(arr:Array):int{
			var no:int;
			var btmp:int;
			for(var i:int=0 ; i<arr.length ; i++){
			
				no=arr[i];
				switch(no){
					case 9:
					case 21:
						Prize+=getBet();
						continue;
					case 5:
					case 10:
					case 16:
					case 22:
						btmp=betArr[0];
						break;
					case 0:
					case 11:
					case 12:
						btmp=betArr[1];
						break;
					case 6:
					case 17:
					case 18:
						btmp=betArr[2];
						break;
					case 1:
					case 13:
					case 23:
						btmp=betArr[3];
						break;
					case 7:
					case 8:
						btmp=betArr[4];
						break;
					case 19:
					case 20:
						btmp=betArr[5];
						break;
					case 14:
					case 15:
						btmp=betArr[6];
						break;
					case 2:
					case 3:
					case 4:
						btmp=betArr[7];
						break;
				}
				Prize+= ( btmp*oddArr[no] );				
			}
			return Prize;
		}
		
		/**下注
		 * @param no：下注标记号码
		 * @param b：下注金额**/
		public static function setBet (no:int , b:int ):int{
			betArr[no]=b;
			return betArr[no];
		}
		/**重置下注情况**/
		public static function resetBet():void{
			for(var i:int=7 ; i>=0 ; i--){
				betArr[i]=0;
			}
		}
		/**获取下注总金额**/
		public static function getBet():int{
			Bet=0;
			for(var i:int=7;i>=0;i--){
				Bet+=betArr[i];
			}
			return Bet;
		}
		
		public static function getRate():int{
			return rateArr[betRate];
		}
	}
}