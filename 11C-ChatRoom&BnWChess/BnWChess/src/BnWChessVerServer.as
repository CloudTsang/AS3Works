package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SyncEvent;
	import flash.geom.Point;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.net.SharedObject;
	
	import org.osmf.net.NetClient;
	
	[SWF(width="800", height="640",  backgroundColor="0xffffff" , frameRate="60")]
	public class BnWChessVerServer extends Sprite
	{
//		private var chessBoard:BoardBmp;	
				private var chessBoard:Board;	
		private var tPanel:txtPanel;
//		public var SO:SharedObject;
		public var NC:NetConnection;
		public var res:Responder;
		public var Addr:String="rtmfp://localhost/BnWChessVerServer";
		private var OreNoTurn:Boolean;
		public function BnWChessVerServer()
		{
//			stage.align = StageAlign.TOP_LEFT;
//			stage.scaleMode = StageScaleMode.NO_SCALE;
			Init();
		}
		private function onConnetHandler(e:NetStatusEvent):void{
			trace(e.info.code);
			switch(e.info.code){
				case "NetConnection.Connect.Success":	
//					SO=SharedObject.getRemote("BnWChessVerServer" , NC.uri ,false);		
//					SO.client = new SoClient();
//					SO.connect(NC);							
					trace("连接成功");
					break;
				case "NetConnection.Connect.Rejected":
					trace("连接被拒绝 ： "+ e.info.application.message);
					break;
			}
		}	
		
		private function nextStep(torenew:Array , score:Array , color:int):String{
			trace(NC.client.number);
			chessBoard.renewBoard(color , torenew);
			tPanel.renewScore(score[GameData.white] , score[GameData.black]);
			return "对局更新成功";
		}
		
		public function clickHandler(e:MouseEvent):void{
			var p:Object=chessBoard.getPoint();
			if(OreNoTurn==true && p!=null) {			
				OreNoTurn=false;
				NC.call("onPlaceChess" , res , GameData.id , p);
			}			
		}
		
		private function specialEventHandler(type:String):void{
			switch(type){
				case "empty":
					OreNoTurn=true;
					tPanel.emptyWarn();
					break;
				case "eat":
					OreNoTurn=true;
					tPanel.eatWarn();
					break;
				case "passed":
					OreNoTurn=false;
					tPanel.passed();
					break;
				case "passing":
					OreNoTurn=true;
					tPanel.passing();
					break;
				case "lose":
					OreNoTurn=false;
					if(GameData.thisColor==GameData.white) tPanel.setText("你输了" , "对方赢了");
					else if(GameData.thisColor==GameData.black) tPanel.setText("对方赢了","你输了");
					break;
				case "win":
					OreNoTurn=false;
					if(GameData.thisColor==GameData.white) tPanel.setText("你赢了" , "对方输了");
					else if(GameData.thisColor==GameData.black) tPanel.setText("对方输了","你赢了");
					break;
				case "escwin":
					OreNoTurn=false;
					if(GameData.thisColor==GameData.white) tPanel.setText("那就算你赢吧。","对方退出了");
					else if(GameData.thisColor==GameData.black) tPanel.setText("对方退出了","那就算你赢吧。");
					break;
					
			}
		}
		private function TurnEnd(t:Boolean):String{
			OreNoTurn=t;
			if(OreNoTurn){
				if(GameData.thisColor==GameData.white) tPanel.setText("轮到你的回合了" , "正在等待中...");
				else if(GameData.thisColor==GameData.black) tPanel.setText("正在等待中..." , "轮到你的回合了");
			}else{
				if(GameData.thisColor==GameData.white) tPanel.setText("请耐心等待" , "正在思考中...");
				else if(GameData.thisColor==GameData.black) tPanel.setText("正在思考中..." , "请耐心等待");
			}
				return "回合交替成功";		
		}
		private function initPlayer(id:int , color:int , arr:Array , str1:String , str2:String , str3:String):String{
			GameData.id=id;
			GameData.thisColor=color;
			chessBoard.initBoard(arr);
			tPanel.setText(str1,str2,str3);
			return"玩家初始化完成";
		}
		
		private function Init():void{		
//			chessBoard=new BoardBmp();
						chessBoard=new Board();
			tPanel=new txtPanel;
			res=new Responder(callServerSuccess , callServerError)		
			NC=new NetConnection();
			NC.addEventListener(NetStatusEvent.NET_STATUS,onConnetHandler);
			NC.client=		
				{
					gid:null,
					show:showGame,
					initBoard:chessBoard.initBoard,
						renew:chessBoard.renewBoard,
						txt:tPanel.setText,
						placeRight:nextStep,
						setColor:GameData.setColor,
						special:specialEventHandler,
						turn:TurnEnd,
						initPlayer:initPlayer
				};
			
			chessBoard.addEventListener("Board Init Complete",showGame);
						chessBoard.addEventListener(MouseEvent.CLICK , clickHandler); 			
			
			NC.connect(Addr);
		}
		
		private function showGame(e:Event=null):void{
			removeChildren();
			addChild(chessBoard);
			addChild(tPanel);	
//			stage.addEventListener(MouseEvent.CLICK , clickHandler); 		
		}
		
		private function callServerSuccess(re:String):void{
			trace(re);
		}		
		private function callServerError(info:Object):void{
			trace("call error: " + info.code);
		}
	}
}