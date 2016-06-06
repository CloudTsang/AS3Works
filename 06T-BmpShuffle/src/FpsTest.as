package
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.getTimer;

	public class FpsTest extends TextField
	{
		private  var startTime:Number; 
		private  var framesNumber:Number = 0; 
		public function FpsTest()
		{
			startTime = getTimer(); 			
			this.addEventListener(Event.ENTER_FRAME, checkFPS); 
		}
	
		private  function checkFPS(e:Event):void 
		{ 
			var currentTime:Number = (getTimer() - startTime) / 1000; 
			framesNumber++; 
			if (currentTime > 1) 
			{ 
				trace("FPS:" + (Math.floor((framesNumber/currentTime)*10.0)/10.0));
			//	this.text = "FPS:" + (Math.floor((framesNumber/currentTime)*10.0)/10.0); 
				startTime = getTimer(); 
				framesNumber = 0; 
			//	trace(this.text)
			} 
		} 
	}
}