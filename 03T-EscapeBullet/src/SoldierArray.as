package
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class SoldierArray
	{
		private var herox:int;
		private var heroy:int;
		private var difficulty:String;
		public var hx:int=0;
		public var hy:int=0;
		public var Arr:Array=new Array;
		public var timer:Timer=new Timer(10);
		public var border:Movelimit=new Movelimit;
		public function SoldierArray(num:int,dfct:String)
		{			
			difficulty=dfct;
			timer.addEventListener("timer",Rota);
			for(var k:int=0;k<num;k++)
			{
					MakeSol(k);
					Arr[k].x=200+k*200;
					Arr[k].y=border.Up+200;					
			}
			timer.start();
		}
		
		public function MakeSol(num:int):void
		{
			var sld:Soldier=new Soldier();
			if(difficulty=="easy"){
				sld.status.SetStatus(20,0,10,10,10);
			}else if(difficulty=="normal"){
				sld.status.SetStatus(30,0,15,15,10);
			}else if(difficulty=="difficult"){
				sld.status.SetStatus(50,0,25,20,15);
			}else if(difficulty=="hell"){
				sld.status.SetStatus(100,0,50,40,30);
			}
			//Arr[num]=sld;	
			Arr.push(sld);
		}
//		public function DelSol():int{
//			return 1;
//		}
		public function retLen():int{
			return Arr.length;
		}
		public function Rota(event:TimerEvent):void
		{
			for(var j:int=0;j<Arr.length;j++){		
				Arr[j].rotation=Math.atan2(hy-Arr[j].y,hx-Arr[j].x)*180/Math.PI;
			}
		}
	}
}