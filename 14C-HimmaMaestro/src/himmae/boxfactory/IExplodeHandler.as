package himmae.boxfactory
{
	import himmae.iterfaces.IWorldData;
/**爆炸处理器**/
	public interface IExplodeHandler
	{
		function getExplosion(type:String):IExplosion;
		function Explode(world:IWorldData , arr:Array , x:int , z:int):void
	}
}