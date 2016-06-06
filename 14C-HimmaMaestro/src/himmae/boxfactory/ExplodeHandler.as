package himmae.boxfactory
{
	import himmae.controllercommand.IControllerSwitch;
	
	import flash.events.EventDispatcher;
	import flash.utils.setTimeout;
	
	import himmae.observer.ISubject2;
	import himmae.iterfaces.IWorldData;
	
	public class ExplodeHandler extends EventDispatcher implements IExplodeHandler
	{
		private var _time:ISubject2;
		private var _score:ISubject2;
		private var _ctrl:IControllerSwitch;
		private var _hook:Boolean;
		private var _index:int;
		private var _tmp:IExplosion;
		private const EXPLODE_SPEED:int=500;
		public function ExplodeHandler(time:ISubject2 , score:ISubject2 , ctrlswitch:IControllerSwitch)
		{
			_time=time;
			_score=score;
			_ctrl=ctrlswitch;
			_hook=false;
		}
		
		public function Explode(world:IWorldData , arr:Array , x:int , z:int):void{
			if(!_hook) _ctrl.unpressable();
			if(_hook){
				arr=_tmp.Explode(arr , _index);
				world.setCellData(arr,x ,z);
				world.renewStage();
				_hook=false;
			}
			if(!_hook){
				for(_index ; _index<arr.length ; _index++){
					_tmp=getExplosion( arr[_index] );
					if(_tmp.isExplode(arr , _index)){
						_hook=true;
						setTimeout( Explode , 500 , world , arr , x , z );
						break;
					}
				}
			}
			if(!_hook){
				_index=0;
				_ctrl.pressable();
			}
		}
		
		
		public function getExplosion(type:String):IExplosion{
			var tmpArr:Array=type.split("&");
			switch(tmpArr[0]){
				case HM.BRICK:
				case HM.NORMAL:
				case HM.HERO:
				case HM.POWER:
					return new Explosion_Null;
				case HM.SCARTTER:
					return new Explosion_Delete(tmpArr[1]  ,HM.ACT_GOAL,_score , 1);
				case HM.BOMB:
					return new Explosion_Delete(tmpArr[1] , HM.EXPLODE , null , 1);
				case HM.TIMEREC:
					return new Explosion_Delete(tmpArr[1] , HM.ACT_GOAL ,_time , 1);
				case HM.GLASS:
					return new Explosion_Delete(tmpArr[1] , HM.EXPLODE_GLASS ,_score , -1);
			}
			return new Explosion_Null;
		}
	}
}