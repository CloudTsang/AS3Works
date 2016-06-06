package himmae.controllercommand
{
	import himmae.iterfaces.IHero;
	import himmae.iterfaces.IWorldData;

	public class Controller_Full extends Controller
	{
		private var _host:*;
		private var _hero:IHero;	
		public function Controller_Full(h:* , h2:IHero=null)
		{
			_host=h;
			_hero=h2;
			super();
		}
		protected override function setCommand():void{
			if(_host is Menu){
				_command.push(
					new MenuCommand_Up(_host),
					new MenuCommand_Down(_host),
					_emptyCommand,
					_emptyCommand,
					new MenuCommand_Enter(_host),
					new MenuCommand_Esc(_host),
					_emptyCommand,
					_emptyCommand
				)
			}else if(_host is IWorldData && _hero){
				_command.push(
					new ActCommand_Walk(_host, _hero ,-1,0),	
					new ActCommand_Walk(_host, _hero ,1,0),	
					new ActCommand_Walk(_host , _hero,0,-1),	
					new ActCommand_Walk(_host , _hero,0,1),	
					new ActCommand_Lift(_host, _hero),
					new ActCommand_Step(_host, _hero),
					new ActCommand_Down(_host, _hero),
					new ActCommand_Kick(_host)
				)
			}
		}
	}
}