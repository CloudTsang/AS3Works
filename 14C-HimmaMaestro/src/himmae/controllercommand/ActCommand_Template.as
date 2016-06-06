package himmae.controllercommand
{
	import flash.geom.Point;
	import himmae.iterfaces.IHero;
	import himmae.iterfaces.IWorldData;

	internal class ActCommand_Template implements ICommand
	{
		protected var _world:IWorldData;
		protected var _hero:IHero;
		protected var _front:Point;
		protected var _arr:Array;
 		public function ActCommand_Template(w:IWorldData=null , h:IHero=null)
		{
			_world=w;
			_hero=h;
		}
		
		public function isExcutePermitt():Boolean
		{
			return false;
		}
		
		public function excute():void
		{
			throw new Error("This function should be overrided!");
		}
		
		/**hero位置的方块数据**/
		protected final function get heroPosCell():Array{
			return _world.getCellData(_hero.position.x , _hero.position.y);
		}
		/**hero面向一格的方块数据，当hero面向墙壁时返回null**/
		protected final function get directCell():Array{		
			_front=_hero.front;
			if(_front.x<0
				||_front.y<0
				||_front.x>=_world.height
				||_front.y>=_world.width
			)return null;
			return _world.getCellData(_front.x , _front.y);
		}
	}
}