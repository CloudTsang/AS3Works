package himmae.iterfaces
{
	import flash.geom.Point;
	
	import himmae.misc.DirectionIcon;

	public interface IHero
	{
		/**更新主角格子的资料**/
		function renew(arr:Array=null):void;
		/**面向的方向**/
		function get direction():Point;
		function set direction(d:Point):void;
		/**主角面前的一格**/
		function get front():Point;
		/**位置**/
		function get position():Point;
		function set position(p:Point):void;
		/**高度**/
		function get index():int;
		function set index(i:int):void;
		/**力量值**/
		function get power():int;
		function set power(p:int):void;
		function get directIcon():DirectionIcon;
	}
}