package himmae.controllercommand
{
	import flash.geom.Point;
	
	import himmae.iterfaces.IHero;
	import himmae.iterfaces.IWorldData;
	import himmae.misc.BGM;
	
	internal class ActCommand_Walk extends ActCommand_Template
	{
		private var _direct:Point;
		public function ActCommand_Walk(w:IWorldData , h:IHero , dx:int=0 , dz:int=0)
		{
			super(w , h);
			_direct=new Point(dx , dz);
		}
		
		public override function isExcutePermitt():Boolean
		{
			_hero.direction=_direct;
			_arr=directCell;
			if(_arr!=null && _arr.length<=0) return true;
			BGM.instance.down();
			return false;
		}
		
		public override function excute():void
		{
			var tmp:Point=_hero.position;
			_world.cellMove(_front.x , _front.y , tmp.x , tmp.y);
			_hero.position=_front;
			BGM.instance.kick();
//			_world.renewStage();
		}
	}
}