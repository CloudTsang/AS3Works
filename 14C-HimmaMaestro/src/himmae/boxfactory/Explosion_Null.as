package himmae.boxfactory
{

	/**没有爆炸功能**/
	internal class Explosion_Null implements IExplosion
	{
		public function Explosion_Null()
		{
		}
		
		public function Explode(arr:Array=null , h:int=0):Array{
			return arr;
		}
		public function isExplode(arr:Array=null , h:int=0):Boolean{
			return false;
		}
	}
}