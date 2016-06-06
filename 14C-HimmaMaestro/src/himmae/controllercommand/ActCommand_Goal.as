package himmae.controllercommand
{
	import himmae.iterfaces.IGoal;

	internal class ActCommand_Goal implements ICommand
	{
		protected var _goal:IGoal;
		public function ActCommand_Goal(g:IGoal)
		{
			_goal=g;
		}
		public  function isExcutePermitt():Boolean{
			return true;
		}
		public  function excute():void{
			_goal.startGoal();
		}
	}
}