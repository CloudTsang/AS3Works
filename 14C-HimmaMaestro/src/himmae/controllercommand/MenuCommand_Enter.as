package himmae.controllercommand
{
	import himmae.iterfaces.IMenu;

	internal class MenuCommand_Enter extends MenuCommand_Template
	{
		public function MenuCommand_Enter(m:IMenu)
		{
			super(m);
		}
		public override function isExcutePermitt():Boolean{
			return true;
		}
		public override function excute():void{
			_menu.nextMenu();
		}
	}
}