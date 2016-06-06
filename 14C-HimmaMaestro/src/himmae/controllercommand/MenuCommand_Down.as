package himmae.controllercommand
{
	import himmae.iterfaces.IMenu;

	internal class MenuCommand_Down extends MenuCommand_Template
	{
		public function MenuCommand_Down(m:IMenu)
		{
			super(m);
		}
		public override function isExcutePermitt():Boolean{
			return _menu.sIndex!=_menu.menuLength-1;
		}
		public override function excute():void{
			_menu.selDown();
		}
	}
}