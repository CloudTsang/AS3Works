package himmae.displayworld
{
	import flash.geom.Point;

	public interface IWorld
	{
		function createFloor( arrTile:Array=null , arrBox:Array=null ):void;
		function renewWorld( arr:Array=null ):void;
		function finishCreate():void;
	}
}