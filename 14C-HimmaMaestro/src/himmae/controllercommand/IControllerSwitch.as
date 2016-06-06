package himmae.controllercommand
{
	public interface IControllerSwitch
	{
		function unpressable():void;
		function pressable():void;
		function set Controller(c:IController):void;
	}
}