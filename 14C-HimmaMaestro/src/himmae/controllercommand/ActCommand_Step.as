package himmae.controllercommand
{
	import himmae.boxfactory.BoxFactory;
	
	import flash.geom.Point;
	
	import himmae.misc.BGM;
	import himmae.iterfaces.IHero;
	import himmae.iterfaces.IWorldData;

	internal class ActCommand_Step extends ActCommand_Template
	{
		public function ActCommand_Step(w:IWorldData , h:IHero)
		{
			super(w , h);
		}
		public override function isExcutePermitt():Boolean{
			_arr=directCell;
			if(!_arr) return false;
			if(_arr.length==0
			|| _arr.length-1>_hero.index
			|| !BoxFactory.instance.Stepable( _arr , HM.ACT_STEP )
			)return false;
			return true;
		}
		public override function excute():void{
			var tmp:Point=_hero.position;
			var tmpa:Array=_world.getCellData(_front.x , _front.y);
			tmpa=tmpa.concat(  _world.getCellData(tmp.x , tmp.y) );
			_world.cellMove( _front.x , _front.y , tmp.x , tmp.y , tmpa , null , true , false);
			
			_hero.position=_front;
			_hero.renew();
//			_world.renewStage();
			_arr=null;
			BGM.instance.step();
		}
	}
}