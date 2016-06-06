package himmae.controllercommand
{
	import flash.geom.Point;
	
	import himmae.boxfactory.BoxFactory;
	import himmae.iterfaces.IHero;
	import himmae.iterfaces.IWorldData;
	import himmae.misc.BGM;
	
	internal class ActCommand_Lift extends ActCommand_Template
	{
		private var _pos:Point;
		private var _arr2:Array;
		public function ActCommand_Lift(w:IWorldData , h:IHero)
		{
			super(w,h);
		}
		public override function isExcutePermitt():Boolean{
			_arr=directCell;
			if(_arr==null)return false;
			if(_arr.length-2>_hero.index 
				|| _arr.length==0
				|| !BoxFactory.instance.Liftable( _arr[_arr.length-1])
			)return false;
			_pos=_hero.position;
			_arr2=_world.getCellData( _pos.x , _pos.y );
			if( _arr2.length-_hero.index>_hero.power)return false;
			return true;
		}
		public override function excute():void{
//			var tmp:Array=_world.getCellData( _pos.x , _pos.y );
			_arr2.push(_arr.pop());
			_world.setCellData( _arr2 , _pos.x , _pos.y , true );
			_world.renewStage();
			_pos=null;
			_arr2=null;
			BGM.instance.lift();
		}
	}
}