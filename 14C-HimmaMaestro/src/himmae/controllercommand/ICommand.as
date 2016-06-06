package himmae.controllercommand
{
	public interface ICommand
	{
		function isExcutePermitt():Boolean;
		function excute():void;
	}
}