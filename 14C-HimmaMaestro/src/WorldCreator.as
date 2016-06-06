package
{
	import com.adobe.serialization.json.JSON;
	
	import flash.text.TextFormatAlign;
	import flash.ui.GameInput;
	import flash.utils.ByteArray;
	
	import himmae.boxfactory.BoxFactory;
	import himmae.boxfactory.ExplodeHandler;
	import himmae.boxfactory.IExplodeHandler;
	import himmae.controllercommand.ControlSwitch;
	import himmae.controllercommand.Controller_Menu;
	import himmae.controllercommand.Controller_Stage;
	import himmae.controllercommand.IController;
	import himmae.controllercommand.IControllerSwitch;
	import himmae.displayworld.IWorld;
	import himmae.displayworld.IsoFloor_Gradual;
	import himmae.displayworld.IsoFloor_Immediate;
	import himmae.displayworld.PartsSize;
	import himmae.item.IItem;
	import himmae.item.ItemCollection;
	import himmae.iterfaces.IBird;
	import himmae.iterfaces.IHero;
	import himmae.iterfaces.IMenu;
	import himmae.iterfaces.IPartsSize;
	import himmae.iterfaces.IWorldCreator;
	import himmae.iterfaces.IWorldData;
	import himmae.misc.BGM;
	import himmae.misc.Colors;
	import himmae.observer.IObserver2;
	import himmae.observer.ISubject2;
	import himmae.observer.ScoreTXT;
	import himmae.observer.Subject2;
	import himmae.observer.TimeCount;
	import himmae.observer.TotalScore;
	import himmae.observer.TxtObserver;
	
	public final class WorldCreator implements IWorldCreator
	{
		[Embed(source="stageData.txt", mimeType="application/octet-stream")]
		private  var Js:Class;
		private  var _jsData:Array =com.adobe.serialization.json.JSON.decode(new Js);
		
		private var _info:StageInfo;
		private var _stage:Object;
		
		private var _menu:IMenu;
		
		private var _hero:IHero;
		private var _bird:IBird;
		private var _world:IWorld;
		private var _data:IWorldData;
		private var _sizeCalc:IPartsSize;
		private var _item:ItemCollection;
		private var _goal:GoalFloor;
		
		private var _time:TimeCount;
		private var _txtTime:IObserver2;
		private var _score:ISubject2;
		private var _txtScore:IObserver2;
		private var _scorelimit:int;
		private var _totalScore:ISubject2;
		private var _txtTotalScore:IObserver2;
		
		private var _ctrller:IController;
		private var _ctrlSwitch:IControllerSwitch;
		
		private var _explodeHandler:IExplodeHandler;
		
		public function WorldCreator()
		{
			_totalScore=new TotalScore;
			_txtTotalScore=new TxtObserver(_totalScore , 30 ,35 ,100 , 0,0,false,TextFormatAlign.LEFT);
			_ctrlSwitch=new ControlSwitch;
			Colors.initColor();
		} 
		public function loadMenu():void{
			_menu=new Menu(_totalScore.param);
			_ctrller=new Controller_Menu(_menu);
			_ctrlSwitch.Controller=_ctrller;
		}
		
		public function loadStage(info:StageInfo=null):void{
			if(info) _info=info;
			else if(!info && !_info)throw new Error("Can't load stage!");
			
//			_stage=_jsData[_info.stage];
			
			_stage=copyStage(_jsData[_info.stage]);
			
			if(_info.time=="1800")_time=new TimeCount(_stage.timelimit*0.75);
			else _time=new TimeCount(_stage.timelimit);
			_score=new Subject2(0);
			_scorelimit=_stage.scorelimit;

			BoxFactory.initFactory( _stage.size , _stage.size , _time , _score);
			
			_sizeCalc=new PartsSize(HM.HUD_WIDTH , HM.SKY_HEIGHT , _stage.size , _stage.width , _stage.height);
			
			if(_info.time!="2400") _world=new IsoFloor_Immediate(_sizeCalc , _ctrlSwitch);
			else _world=new IsoFloor_Gradual(_sizeCalc , _ctrlSwitch);
			
			_explodeHandler=new ExplodeHandler(_time , _score , _ctrlSwitch);
			
			_data=new WorldData2(_stage.box , _stage.floor , _stage.width , _stage.height  , _world , _explodeHandler);
			
			_goal=new GoalFloor(_stage.floor , _data , _score , _ctrlSwitch);
			
			_hero=new Hero(_data , _stage.hero.x , _stage.hero.z);
			
			_bird=new Bird(_stage.bird , _time ,_data , _sizeCalc);
			if(_info.time=="0600") _bird.Rate-=1;
			
			_item=new ItemCollection(_info.item , _data , _hero , _bird);
			_item.useItem();
			
			_txtScore=new ScoreTXT(_score , _scorelimit);
			_txtTime=new TxtObserver(_time);
			
			_ctrller=new Controller_Stage(_data , _hero , _goal , _item);
			_ctrlSwitch.Controller=_ctrller;
			
			BGM.instance["WORK"+_info.time]();
		}
		
		private function copyStage(obj:Object):Object{
			var copier:ByteArray=new ByteArray();
			copier.writeObject(obj);
			copier.position=0;
			return copier.readObject();
		}
		
		public function createStage():void{
			_world.createFloor(_data.Floor , _data.Cell);
		}
		
		public function get menu():IMenu{
			return _menu;
		}
		
		public function get data():IWorldData{
			return _data;
		}
		
		public function get hero():IHero
		{
			return _hero;
		}
		
		public function get bird():IBird
		{
			return _bird;
		}
		
		public function get world():IWorld
		{
			return _world;
		}
		
		public function get item():ItemCollection{
			return _item;
		}
		
		public function get time():ISubject2{
			return _time;
		}
		public function get timeTxt():IObserver2{
			return _txtTime;
		}
		public function get score():ISubject2{
			return _score;
		}
		public function get scorelimit():int{
			return _scorelimit;
		}
		public function get scoreTxt():IObserver2{
			return _txtScore;
		}
		public function get totalScore():ISubject2{
			return _totalScore;
		}
		public function get totalScoreTxt():IObserver2{
			return _txtTotalScore;
		}
		public function get Controller():IController{
			return _ctrller;
		}
	}
}