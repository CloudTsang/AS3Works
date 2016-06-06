package himmae.controllercommand
{
	import himmae.boxfactory.BoxFactory;
	
	import flash.geom.Point;
	
	import himmae.misc.BGM;
	import himmae.iterfaces.IHero;
	import himmae.iterfaces.IWorldData;
	
	internal class ActCommand_Down extends ActCommand_Template
	{
		private var _arr2:Array;
		private var _pos:Point;
		public function ActCommand_Down(w:IWorldData , h:IHero)
		{
			super(w,h);
		}
		public override function isExcutePermitt():Boolean{
			_arr=directCell;
			if(!_arr) return false;
			if(_hero.index<_arr.length-1
			||!BoxFactory.instance.Stepable( _arr , HM.ACT_DOWN )
			) return false;
			_pos=_hero.position;
			_arr2=_world.getCellData( _pos.x ,_pos.y);
			if(_arr2.length-1 == _hero.index)return false;
			return true;
		}
		public override function excute():void{
			_world.setCellData( _arr.concat( _arr2.splice( _hero.index+1 ) ) , _front.x , _front.y ,true);
			_pos=null;
			_arr2=null;
			_arr=null;
//			_world.renewStage();
			BGM.instance.down();
		}
	}
}