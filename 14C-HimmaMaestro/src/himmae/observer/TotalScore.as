package himmae.observer
{
	import flash.net.SharedObject;

	public class TotalScore extends Subject2
	{
		private var SO:SharedObject=SharedObject.getLocal("Save");
		public function TotalScore()
		{
			super();
			if(SO.data.totalScore==undefined) SO.data.totalScore=99;
//			SO.data.totalScore=99;
		}
		
		public override function callObserver():void
		{
			for(var i:int=0 ; i<_vec.length ; i++){
				_vec[i].update(SO.data.totalScore);
			}
		}
		
		public override function set param(p:*):void{
			if(p is int){
				SO.data.totalScore=p;
				callObserver();
			}
			else throw new Error("Wrong param!");
		}
		public override function get param():*{
			return SO.data.totalScore;
		}
	}
}