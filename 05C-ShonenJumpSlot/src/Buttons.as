package
{
	import com.greensock.easing.EaseLookup;
	
	import fl.livepreview.LivePreviewParent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.StaticText;
	import flash.utils.setTimeout;
	
	public class Buttons extends Sprite
	{
		/**规则按钮**/
		public var Rule:btnRule=new btnRule;
		/**自动旋转按钮**/
		public var AutoSpin:BtnAutoSpin=new BtnAutoSpin;
		/**开始按钮
		 * 这个按钮仅在免费游戏中会被隐藏
		 * **/
		public static var Start:BtnSTART=new BtnSTART;
		/**下注线数按钮**/
		public var Line:BtnLine=new BtnLine;
		/**下注倍数按钮**/
		public var Rate:BtnRate=new BtnRate;
		/**一注金额按钮**/
		public var oneBet:BtnMoney=new BtnMoney;
		/**赌博按钮**/
		public var Gamble:BtnGamble=new BtnGamble;
		/**退出免费游戏按钮**/
		public var EscFree:BtnEscFree=new BtnEscFree;
		/**单双向兑奖按钮**/
		public var Duo:btnDuo=new btnDuo;
		private var Block:Sprite=new Sprite;
		public function Buttons() 
		{			
			
			Rule.x=1100;
			Rule.y=5;
			Rule.McRuleBtn.addEventListener(MouseEvent.CLICK,pressBtn);
			addChild(Rule);
			
			AutoSpin.x=750;
			AutoSpin.y=600;
			AutoSpin.MCbtnASMenu.addEventListener(MouseEvent.CLICK,pressBGS);
			addChild(AutoSpin);
			
			Start.x=1100;
			Start.y=600;
			Start.McPress.addEventListener(MouseEvent.CLICK,pressBGS);
			addChild(Start);
			
			EscFree.x=1100;
			EscFree.y=600;
			addChild(EscFree);
			EscFree.visible=false;
			
			Line.x=300;
			Line.y=640;
			Line.addEventListener(MouseEvent.CLICK,pressBGS);
			addChild(Line);
			
			Rate.x=300;
			Rate.y=570;
			Rate.addEventListener(MouseEvent.CLICK,pressBGS);
			addChild(Rate);
			
			oneBet.x=100;
			oneBet.y=600;
			oneBet.MCbtnMenu.addEventListener(MouseEvent.CLICK,pressBGS);
			addChild(oneBet);
			
			Gamble.x=920;
			Gamble.y=580;
			Gamble.visible=false;
			Gamble.McGamBtn.addEventListener(MouseEvent.CLICK,pressBtn);
			addChild(Gamble);	
			
			BGM.Volume.x=50;
			BGM.Volume.y=650;
			addChild(BGM.Volume);
			
			Duo.x=20;
			Duo.y=550;
			Duo.addEventListener(MouseEvent.CLICK,ReelPad.setisDuo);
			Duo.addEventListener(MouseEvent.CLICK,pressBGS);
			addChild(Duo);
			
			Block.graphics.beginFill(0x000000,0.5);
			Block.graphics.drawRect(0,0,2000,2000);			
			addChild(Block);
			Block.visible=false;
		}	
		/**按键音效函数**/
		private function pressBGS(e:MouseEvent):void{
			if(e.currentTarget==Start){
				BGM.BgsPlay("startbtn");				
			}else{
			BGM.BgsPlay("btn");
			}
		}
		
		/**旋转中锁定赌注选择按钮的函数：true=锁定，false=解锁**/
		public function BetLock(l:Boolean):void{
			if(l==true){
				oneBet.mouseChildren=false;
				oneBet.mouseEnabled=false;
			    Line.mouseChildren=false;
			    Line.mouseEnabled=false;
				Rate.mouseChildren=false;
				Rate.mouseEnabled=false;			
				Duo.mouseEnabled=false;
				AutoSpin.mouseEnabled=false;
				AutoSpin.mouseChildren=false;
			}else{
				oneBet.mouseChildren=true;
				oneBet.mouseEnabled=true;
				Line.mouseChildren=true;
				Line.mouseEnabled=true;
				Rate.mouseChildren=true;
				Rate.mouseEnabled=true;	
				Duo.mouseEnabled=true;
				AutoSpin.mouseEnabled=true;
				AutoSpin.mouseChildren=true;
			}
		}
		
		/**
		 * 背景变暗，
		 * 将被按下的按键放到显示列表的顶层，
		 * 阻断其它按键
		 * */
		private function pressBtn(event:MouseEvent):void{
			setChildIndex(event.currentTarget.parent,numChildren-1);
			Block.visible=!Block.visible;
		}
		
		/**获取自动旋转数**/
		public function getAuto():int{
			return AutoSpin.AutoSpin;
		}
		/**自动旋转数置0  **/
		public function resetAuto():void{
			AutoSpin.AutoSpin=0;
		}
		
		/**获取下注倍数**/
		public function getRate():int{
			return Rate.Rate;
		}
		/**获取下注线数**/
		public function getLine():int{
			return Line.Line;
		}
		/**获取单注金额**/
		public function getOneBet():Number{
			return oneBet.Bet;
		}
		/**获取单线投注金额**/
		public function getLineBet():Number{
			return getOneBet()*getRate();
		}
		/**获取总投注金额**/
		public function getBet():Number{
			return getLine()*getLineBet();
		}
	}
}