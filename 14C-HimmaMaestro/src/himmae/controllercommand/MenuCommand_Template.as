package himmae.controllercommand
{
	import himmae.iterfaces.IMenu;

	internal class MenuCommand_Template implements ICommand
	{
		protected var _menu:IMenu;
		public function MenuCommand_Template(m:IMenu)
		{
			_menu=m;
		}
		
		public function isExcutePermitt():Boolean
		{
			return false;
		}
		
		public function excute():void
		{
			throw new Error("You must override this function!");
		}
	}
}