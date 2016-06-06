package
{
	public class LineBtns extends LineBtn
	{
		private var State:String;
		/**
		 * normal/
		 * prize/
		 * show
		 * */
		public function LineBtns()
		{
			super();
			State="normal";		
		}
		
		public function goFps():void{
			gotoAndStop(State);
		}
	
		public function goShow():void{
			gotoAndStop("shwo");
		}
		
		public function setState(s:String):void{
			State=s;
			goFps();
		}

	}
}