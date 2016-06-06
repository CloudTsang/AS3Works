package
{
	import flash.geom.Point;
	
	public class SoClient
	{
		public function nextStep ( _toRenew:Vector.<Object>=null , _walkable:Vector.<Object>=null , _score:Array=null , _Bscore:int=-1, _Wscore:int =-1 ) :void
		{		
		
		}
		private function Trans(vec:Vector.<Object>):Vector.<Point>{
			var tmp:Vector.<Point>=new Vector.<Point>;
			for(var i:int=0 ; i<vec.length ; i++){
				tmp.push(new Point(vec[i].x , vec[i].y));
			}
			return tmp
		}
	}
}