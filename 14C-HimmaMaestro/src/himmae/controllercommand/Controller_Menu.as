package himmae.controllercommand
{
	import flash.events.KeyboardEvent;
	import himmae.iterfaces.IMenu;

	public class Controller_Menu extends Controller
	{
		private var _menu:IMenu;
		public function Controller_Menu(m:IMenu)
		{
			_menu=m;
			super();			
			setCommand();
			_switch=true;
		}
		protected override function setCommand(...args):void{
			_command.push(
				new MenuCommand_Up(_menu),
				new MenuCommand_Down(_menu),
				_emptyCommand,
				_emptyCommand,
				new MenuCommand_Enter(_menu),
				new MenuCommand_Esc(_menu),
				_emptyCommand,
				_emptyCommand,
				_emptyCommand
			)
		}
		public override function pressBtn(e:KeyboardEvent):void{
			if(!_switch)return;
			actionHandler(e.keyCode);
			_menu.renewDes();
		}
	}
}