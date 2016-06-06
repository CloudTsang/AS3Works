package himmae.boxfactory
{
	public interface IBox
	{
		function Explode(arr:Array , h:int):Array;
		function get Score():int;
		function get Value():int;
		function get Liftable():int;
		function get Stepable():int;
		function get Downable():int;
	}
}