package himmae.controllercommand
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;

	public interface IController 
	{
		function pressBtn(e:KeyboardEvent):void;
		function set ctrlSwitch(p:Boolean):void;
	}
}