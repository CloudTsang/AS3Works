package
{
	public class Slot extends SlotMarker
	{
		/**
		 * 标记制造:
		 *   函数 createSlot(参数) 
		 * 11:DragonBall 12:Jojo 13:Slum 14:Seiya
		 * 21:OneP 22:Naruto 23:Bleach 24:Gintama
		 * 31:Ansatsu 32:Soma 33:Nisekoi 34:Haikyuu
		 * 0:Wild 99:Free
		 * 
		 * 每个标记包含下列属性：
		 * Name:标记名字，用于匹配结果。
		 * dispObj：标记图，addChild这个。
		 * Odds3/4/5：赔率。
		 **/ 
		
		public function Slot()
		{
			super();				
		}
		/**随机返回1个标记**/
		public static function randomSlot():Object{	
			var tmp:int=int(Math.random()*20);
			var result:int;
			
			if(tmp<=0){
				result=0;
			}else if(tmp>=10){
				result=(int((Math.random()*3+1))*10
					+int((Math.random()*4+1)));
			}else{
				result=99;
			}
			
			return createSlot(result);
		}	
		/**生成标记函数**/
		private static  function createSlot(Type:int,Line:int=1):Object{	
			 var temp:Object=new Object();	
			 switch (Type){
				 case 11:
					 temp=
				 {
					 Name:"DragonBall",
					 dispObj:new DragonBall,
					 Odds3:30,
					 Odds4:350,
					 Odds5:1000
				 };
					 break;
				 case 12:
					 temp=
				 {
					 Name:"Jojo",
					 dispObj:new Jojo,
					 Odds3:25,
					 Odds4:185,
					 Odds5:850
				 };
					 break;
				 case 13:
					 temp=
				 {
					 Name:"Slum",
					 dispObj:new Slum,
					 Odds3:15,
					 Odds4:105,
					 Odds5:350
				 };
					 break;
				 case 14:
					 temp=
				 {
					 Name:"Seiya",
					 dispObj:new Seiya,
					 Odds3:12,
					 Odds4:35,
					 Odds5:280
				 };
					 break;
				 case 21:
					 temp=
				 {
					 Name:"OneP",
					 dispObj:new OneP,
					 Odds3:20,
					 Odds4:235,
					 Odds5:900
				 };
					 break;
				 case 22:
					 temp=
				 {
					 Name:"Naruto",
					 dispObj:new Naruto,
					 Odds3:18,
					 Odds4:100,
					 Odds5:400
				 };
					 break;
				 case 23:
					 temp=
				 {
					 Name:"Bleach",
					 dispObj:new Bleach,
					 Odds3:12,
					 Odds4:45,
					 Odds5:100
				 };
					 break;
				 case 24:
					 temp=
				 {
					 Name:"Gintama",
					 dispObj:new Gintama,
					 Odds3:8,
					 Odds4:24,
					 Odds5:80
				 };
					 break;
				 case 31:
					 temp=
				 {
					 Name:"Ansatsu",
					 dispObj:new Ansatsu,
					 Odds3:28,
					 Odds4:1231,
					 Odds5:6800
				 };
					 break;
				 case 32:
					 temp=
				 {
					 Name:"Soma",
					 dispObj:new Soma,
					 Odds3:9,
					 Odds4:75,
					 Odds5:270
				 };
					 break;
				 case 33:
					 temp=
				 {
					 Name:"Nisekoi",
					 dispObj:new Nisekoi,
					 Odds3:6,
					 Odds4:35,
					 Odds5:70
				 };
					 break;
				 case 34:
					 temp=
				 {
					 Name:"Haikyuu",
					 dispObj:new Haikyuu,
					 Odds3:3,
					 Odds4:20,
					 Odds5:55
				 };
					 break;
				 case 0:
					 temp=
				 {
					 Name:"Wild",
					 dispObj:new Wild,
					 Odds3:3,
					 Odds4:40,
					 Odds5:500
				 };
					 break;
				 case 99:
					 temp=
				 {
					 Name:"Free",
					 dispObj:new Free,
					 Odds3:12,
					 Odds4:24,
					 Odds5:36
				 };
					 break;
			 }
			 temp.Tip=createTip(temp.Odds3,temp.Odds4,temp.Odds5);
			 temp.Tip.visible=false;
			 temp.dispObj.addChild(temp.Tip);	
			 return temp;
		 }
		/**生成标记右上角赔率符号**/
		private static function createTip(od3:int,od4:int,od5:int):Tips{
			var tmpTip:Tips=new Tips;
			tmpTip.setOdd(od3,od4,od5);
			return tmpTip;
		}
		
	}
}