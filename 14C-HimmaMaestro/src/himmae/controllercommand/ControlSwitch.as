package himmae.controllercommand
{
	import flash.events.EventDispatcher;

	/**控制键盘输入是否有效**/
	public class ControlSwitch extends EventDispatcher implements IControllerSwitch
	{
		private static var _ctrller:IController;
		public function ControlSwitch() 
		{
		}
		
		public function unpressable():void{
			_ctrller.ctrlSwitch=false;
		}
		public function pressable():void{
			_ctrller.ctrlSwitch=true;
		}
		
		public function set Controller(c:IController):void{
			_ctrller=c;
		}
	}
}