package himmae.controllercommand
{

	internal class Command_Empty implements ICommand
	{
		public function Command_Empty()
		{
		}
		
		public function isExcutePermitt():Boolean
		{
			return false;
		}
		
		public function excute():void
		{
		}
	}
}