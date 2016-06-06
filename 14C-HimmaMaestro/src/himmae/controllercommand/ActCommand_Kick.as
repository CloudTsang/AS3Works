package himmae.controllercommand
{
	import himmae.boxfactory.BoxFactory;
	
	import flash.geom.Point;
	
	import himmae.misc.BGM;
	import himmae.iterfaces.IHero;
	import himmae.iterfaces.IWorldData;
	
	internal class ActCommand_Kick extends ActCommand_Template
	{
		private var _hpos:Point;
		private var _harr:Array;
		public function ActCommand_Kick(w:IWorldData , h:IHero)
		{
			super(w,h);
		}
		public override function isExcutePermitt():Boolean{
			_arr=directCell;
			if(!_arr)return false;
			if(_hero.index==0
				||_hero.index<_arr.length-1		
			) return false;
			_hpos=_hero.position;
			_harr=_world.getCellData(_hpos.x , _hpos.y);
		
			return BoxFactory.instance.Kickable(_arr , _harr[0]);
		}
		public override function excute():void{
			_world.setCellData( _arr.concat(_harr.shift()) , _front.x , _front.y , true );
			_world.setCellData( _harr , _hpos.x ,_hpos.y);
//			_world.renewStage();
			_hero.renew();
			_arr=null;
			BGM.instance.kick();
		}
	}
}