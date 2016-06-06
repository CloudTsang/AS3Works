package himmae.controllercommand
{
	import himmae.iterfaces.IMenu;

	internal class MenuCommand_Esc extends MenuCommand_Template
	{
		public function MenuCommand_Esc(m:IMenu)
		{
			super(m);
		}
		public override function isExcutePermitt():Boolean{
			return _menu.Prev!=null;
		}
		public override function excute():void{
			_menu.prevMenu();
		}
	}
}