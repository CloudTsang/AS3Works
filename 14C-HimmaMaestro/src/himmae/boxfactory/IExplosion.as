package himmae.boxfactory
{

	/**砖头爆炸行为的接口**/
	public interface IExplosion
	{
		function Explode(arr:Array=null , h:int=0):Array;
		function isExplode(arr:Array=null , h:int=0):Boolean;
	}
}