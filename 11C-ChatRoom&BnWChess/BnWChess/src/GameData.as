package
{
	import flash.geom.Point;
	import flash.text.StaticText;
	
	public class GameData
	{	
		public static const white:int=0;
		public static const black:int=1;
		public static const empty:int=2;
		public static var thisColor:int;	
		public static var id:int;
		public static function setColor(c:int):void{
			thisColor=c;
		}
	}	
}