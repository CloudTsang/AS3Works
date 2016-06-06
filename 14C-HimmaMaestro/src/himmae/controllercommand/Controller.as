package himmae.controllercommand
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class Controller implements IController 
	{
		protected const NULL:int=0;
		protected const UP:int=1;
		protected const DOWN:int=2;
		protected const LEFT:int=3;
		protected const RIGHT:int=4;
		protected const Z:int=5;
		protected const X:int=6;
		protected const C:int=7;
		protected const V:int=8;
		protected const SPACE:int=9;
		protected var _command:Vector.<ICommand>;		
		protected var _emptyCommand:ICommand;
		
		protected var _switch:Boolean;
		
		public function Controller()
		{
			_emptyCommand=new Command_Empty;
			_command=new Vector.<ICommand>;
			_command[NULL]=_emptyCommand;
		}	
		protected function setCommand(...args):void{
			throw new Error("This function should be overrided!");
		}
		public function pressBtn(e:KeyboardEvent):void{
			if(!_switch)return ;
			actionHandler(e.keyCode);
		}
		
		public final function set ctrlSwitch(p:Boolean):void{
			_switch=p;
		}
		
		protected function actionHandler(key:uint):void{
			var tmp:int=NULL;
			switch(key){
				case Keyboard.UP:
					tmp=UP;
					break;
				case Keyboard.DOWN:
					tmp=DOWN;
					break;
				case Keyboard.LEFT:
					tmp=LEFT;
					break;
				case Keyboard.RIGHT:
					tmp=RIGHT;
					break;
				case Keyboard.Z:
					tmp=Z;
					break;
				case Keyboard.X:
					tmp=X;
					break;
				case Keyboard.C:
					tmp=C;
					break;
				case Keyboard.V:
					tmp=V;
					break;
				case Keyboard.SPACE:
					tmp=SPACE;
					break;
			}
			if(_command[tmp].isExcutePermitt()){
				_command[tmp].excute();
			}
		}
	}
}