package
{
	public class Gem
	{
		public var gemsARR:Array=new Array;
		public var HowMuch:int;
		private var AxisX:Array=new Array;
		private var AxisY:Array=new Array;
		public function Gem()
		{
			
		}
		public function FirstGem(/*HowMuch:int*/):void
		{
			var gemNum:int=0;
			var noGem:Boolean=false;
			
			for(gemNum;gemNum<HowMuch;gemNum++){
				var gem:GEM=new GEM();
				if(gemNum==0){
					RandAxis(gem,gemNum);
				}
				else if(gemNum>=1){
					while(noGem==false){
						RandAxis(gem,gemNum);
						for(var num:int=gemNum-1;num>=0;num=num-1)
						{
							if(gem.x==AxisX[num] && gem.y==AxisY[num])
							{
								noGem=false;								
								break;
							}else{
								noGem=true;
							}
						}
					}
					noGem=false;
				}
				gemsARR[gemNum]=gem;
			}
		}
		
		private function RandAxis(sth:GEM,num:int):void
		{
			sth.x=int(Math.random()*20)*30+180;
			AxisX[num]=sth.x;
			sth.y=int(Math.random()*15)*30+30;
			AxisY[num]=sth.y;
		}
	}
}