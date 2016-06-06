package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	public class EscapeBullet extends Sprite
	{
		public var _Hero:Hero=new Hero;
		public var _Field:Sprite=new Sprite;
		public var _Soldiers:SoldierArray=new SoldierArray(4,"normal");
		private var _Border:Movelimit=new Movelimit();
		public function EscapeBullet()
		{
			super(); 
			
			_Soldiers=new SoldierArray(4,"normal");
			// 支持 autoOrient
			
			//			stage.color=0xcccccc;
			
			
			setTimeout(init,100);
			
		}
		private function init():void{
			
			_Field.graphics.beginFill(0x00cc00);
			_Field.graphics.drawRect(_Border.Left,_Border.Up,_Border.Right-_Border.Left,_Border.Down-_Border.Up);
			addChild(_Field);
			
			_Hero.heroPlace.x=0;
			_Hero.heroPlace.y=0;
			addChild(_Hero.heroPlace);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener(MouseEvent.MOUSE_UP,RMCanalog);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,ADCanalog);			
			stage.addEventListener(KeyboardEvent.KEY_DOWN , Buff);
			for (var i:int = 0; i < _Soldiers.retLen(); i++) 
			{
				addChild(_Soldiers.Arr[i]);
			}		
			_Soldiers.timer.addEventListener("timer",setCoordinate);
		}
		
		private function setCoordinate(event:TimerEvent):void{
			_Soldiers.hx=_Hero.hero.x;
			_Soldiers.hy=_Hero.hero.y;
		}
		
		private function RMCanalog(event:MouseEvent):void{
			if(_Hero.moveanalog.stage!=null){
				removeChild(_Hero.moveanalog);	
				_Hero.ifDrag(false,_Hero.moveanalog);
			}
			if(_Hero.spinanalog.stage!=null){
				removeChild(_Hero.spinanalog);
				_Hero.ifDrag(false,_Hero.spinanalog);
			}
		}
		
		private	function ADCanalog(event:MouseEvent):void{
			if(mouseX<=500){
				_Hero.moveanalog.x=mouseX;
				_Hero.moveanalog.y=mouseY;
				addChild(_Hero.moveanalog);	
				_Hero.ifDrag(true,_Hero.moveanalog);
			}else{
				_Hero.spinanalog.x=mouseX;
				_Hero.spinanalog.y=mouseY;
				addChild(_Hero.spinanalog);
				_Hero.ifDrag(true,_Hero.spinanalog);
			}
		}
		private function Buff(e:KeyboardEvent):void{
			switch(e.keyCode){
				case Keyboard.A:
					_Hero.GetBuff("regen");
					break;
				case Keyboard.S:
					_Hero.GetBuff("barrier");
					break;
				case Keyboard.D:
					_Hero.GetBuff("poison");
					break;
			}
		}
		
		
	}
}