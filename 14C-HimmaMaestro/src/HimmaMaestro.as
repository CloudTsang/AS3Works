package
{
	import com.greensock.layout.AlignMode;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;
	import flash.utils.setTimeout;
	
	import himmae.boxfactory.BoxFactory;
	import himmae.controllercommand.IController;
	import himmae.displayworld.IWorld;
	import himmae.item.ItemCollection;
	import himmae.item.Light;
	import himmae.iterfaces.IBird;
	import himmae.iterfaces.IHero;
	import himmae.iterfaces.IMenu;
	import himmae.iterfaces.IWorldCreator;
	import himmae.iterfaces.IWorldData;
	import himmae.misc.BGM;
	import himmae.misc.Colors;
	import himmae.misc.DirectionIcon;
	import himmae.misc.TextBlank;
	import himmae.observer.ISubject2;
	import himmae.observer.ScoreTXT;
	import himmae.observer.TimeCount;
	import himmae.observer.TxtObserver;
	
	public class HimmaMaestro extends Sprite
	{
		private var _creator:IWorldCreator;
		private var _data:IWorldData;
		private var _world:IWorld;
		private var _hero:IHero;
		private var _dicon:DirectionIcon;
		private var _bird:IBird;
		private var _menu:IMenu;
		private var _ctrl:IController;
		private var _item:ItemCollection;
		
		private var _time:TimeCount;
		private var _txtTime:TxtObserver;
		private var _score:ISubject2
		private var _txtScore:ScoreTXT;
		private var _scoreLimit:int;
		private var _totalScore:ISubject2;
		private var _txtTotalScore:TxtObserver;
		
		private var _btnPause:Btn_PAUSE;
		private var _btnRetry:Btn_RETRY;
		private var _btnTitle:Btn_TITLE;
		
		public const STAGE_WIDTH:int=500;
		public const STAGE_HEIGHT:int=600;
		
		public function HimmaMaestro()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.frameRate=60;
			setFocusOnStage();
			
			
			_creator=new WorldCreator();
			_totalScore=_creator.totalScore;
			_txtTotalScore=_creator.totalScoreTxt as TxtObserver;
			
			_btnPause=new Btn_PAUSE;
			_btnRetry=new Btn_RETRY;
			_btnTitle=new Btn_TITLE;
			
			BGM.instance.Volume.addEventListener(MouseEvent.CLICK, BGM.instance.SoundCtrl);
			_btnPause.addEventListener(MouseEvent.CLICK , pauseHandler);
			_btnRetry.addEventListener(MouseEvent.CLICK , retryHandler);
			_btnTitle.addEventListener(MouseEvent.CLICK , titleHandler);
			
			setTimeout(appInit,100);			
		}
		
		private function appInit():void{
			stage.addEventListener(FocusEvent.FOCUS_OUT, setFocusOnStage);
			stage.addChild(_btnPause);
			stage.addChild(_btnRetry);
			stage.addChild(_btnTitle);
			stage.addChild(_txtTotalScore);
			stage.addChild(BGM.instance.Volume);
			
			titleInit();
		}
		
		/**让鼠标焦点回到stage的函数，用到的情况：？**/
		private function setFocusOnStage(event:Event = null) : void
		{
			stage.focus = stage;
		}
		/**标题画面**/
		public function titleInit(e:Event=null):void{
			btnsVisible(false);
			removeChildren();
			parent.stage.stageWidth = STAGE_WIDTH;
			parent.stage.stageHeight = STAGE_HEIGHT;
			_creator.loadMenu();
			_menu=_creator.menu;
			_ctrl=_creator.Controller;
			HUDposition();
			stage.addEventListener(KeyboardEvent.KEY_DOWN , _ctrl.pressBtn);
			(_menu as Sprite).addEventListener(HM.GAME_START, startHandler );		
			addChild(_menu as DisplayObject);
			stage.color=Colors.instance.getColor(HM.TITLE);
		}
		/**开始游戏**/
		public function startHandler(e:Event=null):void{
			//			removeChild(_menu as DisplayObject);
			(_menu as Sprite).removeEventListener(HM.GAME_START, startHandler );		
			stage.removeEventListener(KeyboardEvent.KEY_DOWN , _ctrl.pressBtn);
			stage.color=Colors.instance.getColor("background"+_menu.stageInfo.time);
			_totalScore.param-=_menu.stageInfo.item.cost();
			stageInit();
		}
		/**关卡画面**/
		private function stageInit():void{
			removeChildren();
			_creator.loadStage(_menu.stageInfo);
			
			_world=_creator.world;
			_hero=_creator.hero;
			_data=_creator.data;
			_bird=_creator.bird;
			_item=_creator.item;
			_score=_creator.score;
			_time=_creator.time as TimeCount;
			_scoreLimit=_creator.scorelimit;
			_txtTime=_creator.timeTxt as TxtObserver;
			_txtScore=_creator.scoreTxt as ScoreTXT;
			_ctrl=_creator.Controller;
			_dicon=_hero.directIcon;
			
			parent.stage.stageWidth=(_world as DisplayObject).width+HM.HUD_WIDTH;
			parent.stage.stageHeight=(_world as DisplayObject).height;
			HUDposition();
			addChild(_dicon as DisplayObject);
			addChild(_world as DisplayObject);
			addChild(_bird as DisplayObject);
			addChild(_txtTime);
			addChild(_txtScore);
			for(var i:String in _item.DispObj){
				addChild( _item.DispObj[i]);
			}
			stage.addEventListener(KeyboardEvent.KEY_DOWN , _ctrl.pressBtn);
			(_world as DisplayObject).addEventListener(HM.FINISH_OPENING , startGame);
			_time.timer.addEventListener(TimerEvent.TIMER_COMPLETE , gamesetHandler);
			_creator.createStage();
			
		}
		/**关卡创建完成**/
		private function startGame(e:Event=null):void{
			_time.timer.start();
			btnsVisible(true);
			(_world as DisplayObject).removeEventListener(HM.FINISH_OPENING , startGame);
		}
		/**关卡结束**/
		private function gamesetHandler(e:Event=null):void{
			_ctrl.ctrlSwitch=false;
			_bird.stopFalling();
			_btnPause.visible=false;
			if(_score.param>=_scoreLimit)gameClear();
			else gameFail();
		}
		/**过关**/
		private function gameClear():void{
			var txtClear:TextBlank=new TextBlank("Stage Clear!" , 50 , 60 , -1 , (stage.stageWidth-500)/2 ,stage.stageHeight/2-60 ,false);
			addChild(txtClear);
			_btnTitle.y=txtClear.y+100;
			BGM.instance.STAGECLEAR();
		}
		/**gameover**/
		private function gameFail():void{
			var txtOver:TextBlank=new TextBlank("Game Over…" , 50 , 55 , -1 , (stage.stageWidth-500)/2 ,stage.stageHeight/2-60 ,false);
			addChild(txtOver);
			_btnTitle.y=txtOver.y+100;
			_btnRetry.y=txtOver.y+100;
			BGM.instance.GAMEOVER();
		}
		private function retryHandler(e:Event=null):void{
			_time.timer.reset();
			_bird.stopFalling();
			BGM.instance.BGSstop();
			stageInit();
		}
		private function titleHandler(e:Event=null):void{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN , _ctrl.pressBtn);
			_time.timer.removeEventListener(TimerEvent.TIMER_COMPLETE , gamesetHandler);
			_time.timer.reset();
			_bird.stopFalling();
			BGM.instance.BGSstop();
			if(_score.param>_scoreLimit) _totalScore.param+=_score.param;
			BoxFactory.removeFactory();
			titleInit();
		}
		private function pauseHandler(e:Event=null):void{
			_time.timer.stop();
			_ctrl.ctrlSwitch=false;
			_bird.fallingCtrl(true);
			BGM.instance.SoundCtrl();
			BGM.instance.BGSstop();
			BGM.instance.btnEnable(false);
			_btnPause.removeEventListener(MouseEvent.CLICK , pauseHandler);
			_btnPause.addEventListener(MouseEvent.CLICK , restartHandler);
		}
		private function restartHandler(e:Event=null):void{
			BGM.instance.btnEnable(true);
			_ctrl.ctrlSwitch=true;
			BGM.instance.SoundCtrl();
			_btnPause.addEventListener(MouseEvent.CLICK , pauseHandler);
			_btnPause.removeEventListener(MouseEvent.CLICK , restartHandler);
			_bird.fallingCtrl(false);
			_time.timer.start();
		}
		
		private function HUDposition():void{
			BGM.instance.Volume.x = 20;
			BGM.instance.Volume.y = 20;
			if(_menu){
				(_menu as DisplayObject).x=50;
				(_menu as DisplayObject).y=200;
			}
			if(_txtTotalScore){
				_txtTotalScore.x=0
				_txtTotalScore.y=50;
			}
			if(_dicon){
				_dicon.x=10;
				_dicon.y=stage.stageHeight-_dicon.height-20;
			}
			if(_txtTime){
				_txtTime.x=0;
				_txtTime.y=90;
			}
			if(_txtScore){
				_txtScore.x=0;
				_txtScore.y=130;
			}
			if(_btnTitle){
				_btnTitle.x=100;
				_btnTitle.y=10;
			}
			if(_btnPause){
				_btnPause.x=200;
				_btnPause.y=10;
			}
			if(_btnRetry){
				_btnRetry.x=300;
				_btnRetry.y=10;
			}
			if(_item){
				for(var i:String in _item.DispObj){
					if(_item.DispObj[i] as Light){
						_item.DispObj[i].x=0;
						_item.DispObj[i].y=100;
					}
				}
			}
		}
		private function btnsVisible(v:Boolean):void{
			_btnPause.visible=v;
			_btnRetry.visible=v;
			_btnTitle.visible=v;
		}
		
	}
}