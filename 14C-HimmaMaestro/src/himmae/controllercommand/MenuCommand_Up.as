package himmae.controllercommand
{
	import himmae.iterfaces.IMenu;

	internal class MenuCommand_Up extends MenuCommand_Template
	{
		public function MenuCommand_Up(m:IMenu)
		{
			super(m);
		}
		
		public override function isExcutePermitt():Boolean{
			return _menu.sIndex!=1;
		}
		
		public override function excute():void
		{
			_menu.selUp();
		}
	}
}