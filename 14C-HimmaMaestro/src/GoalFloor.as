package
{
	import himmae.boxfactory.BoxFactory;
	
	import com.greensock.plugins.Positions2DPlugin;
	
	import himmae.controllercommand.IControllerSwitch;
	
	import himmae.displayworld.IWorld;
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import himmae.misc.BGM;
	
	import himmae.observer.ISubject2;
	import himmae.iterfaces.IGoal;
	import himmae.iterfaces.IWorldData;
	
	public class GoalFloor implements IGoal
	{
		private var _data:IWorldData;
		private var _timer:Timer;
		/**是否正在得分**/
		private var _isGoal:Boolean;
		private var _score:int;
		/**得分地板位置**/
		private var _pos:Vector.<Point>;
		/**得分地板类型**/
		private var _type:Vector.<String>;
		private var _sc:ISubject2;
		private var _ctrl:IControllerSwitch;
		/**得分处理器
		 * @param arr ： 得分地板数组
		 * @param score ： 现在得分 
		 * @param cs : 输入控制
		 * **/
		public function GoalFloor(arr:Array ,  d:IWorldData , score:ISubject2 , cs:IControllerSwitch)
		{
			_data=d;
			_sc=score;
			_ctrl=cs;
			_pos=new Vector.<Point>;
			_type=new Vector.<String>;
			for(var i:int=0 ; i<arr.length ; i++){
				_pos.push(new Point(arr[i].x , arr[i].z));
				_type.push(arr[i].t);
			}
			_timer=new Timer(500);
			_timer.addEventListener(TimerEvent.TIMER , timerHandler);
		}
		public function startGoal():void{
			_score=0;
			_timer.start();
			_ctrl.unpressable();
			BGM.instance.goal();
		}
		private function stopGoal():void{
			_timer.stop();
			_ctrl.pressable();
//			if(_score==0)return;
//			else _sc.param+=_score;
		}
		private function timerHandler(e:TimerEvent=null):void{
			var tmp:Array;
			_isGoal=false;
			for(var i:int=0 ; i<_pos.length ; i++){
				tmp=_data.getCellData( _pos[i].x , _pos[i].y );
				if(isTypeMatch(tmp[0]  , _type[i])) {
//					_score+=BoxFactory.instance.getBoxScore(tmp[0]);
					_sc.param+=BoxFactory.instance.getBoxScore(tmp[0]);
					tmp.shift();
					_data.setCellData(tmp , _pos[i].x , _pos[i].y);
					_isGoal=true;
				}
			}
			_data.renewStage();
			if(_isGoal==false)stopGoal();
		}
		
		/**增加一个得分地板**/
		public function addGoal(xx:int , zz:int , type:String):void{
			for(var i:int=0 ; i<_pos.length ; i++){
				if(_pos[i].x==xx && _pos[i].y==zz) {
					_type[i]=type;
					return;
				}
			}
			_pos.push(new Point(xx,zz));
			_type.push(type);
		}
		/**按照位置除去一个得分地板*/
		public function delGoalByPos(xx:int , zz:int):void{
			for(var i:int=0 ; i<_pos.length ; i++){
				if(_pos[i].x==xx && _pos[i].y==zz) {
					_pos.splice(i , 1);
					_type.splice(i , 1);
					return;
				}
			}
		}
		/**按照类型除去一个或多个（？）得分地板*/
		public function delGoalByType(type:String):void{
			var i:int=0;
			while(i<_type.length){
				if(_type[i]==type) _type.splice(i,1);
				else i++;
			}
		}
		
		private function isTypeMatch(type1:String , type2:String):Boolean{
			if(type1==type2
				|| type1==HM.SCARTTER
			){
				return  true;
			}
			return false;
		}
	}
}