package himmae.controllercommand
{
	import flash.events.KeyboardEvent;
	
	import himmae.item.ItemLIGHT;
	import himmae.iterfaces.IGoal;
	import himmae.iterfaces.IHero;
	import himmae.item.IItem;
	import himmae.item.IItemCollect;
	import himmae.iterfaces.IWorldData;

	public class Controller_Stage extends Controller
	{
		private var _light:IItem;
		public function Controller_Stage(w:IWorldData , h:IHero , g:IGoal , items:IItemCollect=null)
		{
			if(items.itemLight is ItemLIGHT)_light = items.itemLight;
//			if(light is ItemLIGHT) _light=light;
			super();
			setCommand(w , h , g);
			_switch=false;
		}
		protected override function setCommand(...args):void{
			var world:IWorldData;
			var hero:IHero;
			var goal:IGoal;
			for(var i:String in args){
				if(args[i] is IWorldData) world=args[i];
				else if(args[i] is IHero) hero=args[i];
				else if(args[i] is IGoal) goal=args[i];
			}
			_command.push(
				new ActCommand_Walk(world ,hero ,0,-1),	
				new ActCommand_Walk(world ,hero ,0,1),	
				new ActCommand_Walk(world ,hero,-1,0),	
				new ActCommand_Walk(world ,hero ,1,0),	
				new ActCommand_Lift(world ,hero),
				new ActCommand_Step(world ,hero),
				new ActCommand_Down(world ,hero),
				new ActCommand_Kick(world ,hero),
				new ActCommand_Goal(goal)
			)		
		}
		public override function pressBtn(e:KeyboardEvent):void{
			if(!_switch)return;
			actionHandler(e.keyCode);
			if(_light)_light.useItem();
		}
	}
}