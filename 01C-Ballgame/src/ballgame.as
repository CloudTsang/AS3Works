package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	[SWF(width="1050", height="600",  backgroundColor="0xffffff" , frameRate="60")]
	public class ballgame extends Sprite
	{
		public function ballgame()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;	
			stage.frameRate=60;

			var ball:Sprite=new Sprite();	
			var R:int=30;
			ball.x=600;
			ball.y=300;
			ball.graphics.lineStyle(2,0x000000,1);
			ball.graphics.beginFill(0xABCDEF);
			ball.graphics.drawCircle(0,0,R);
			addChild(ball);	
			//球
			
			var upborder:int=80;
			var leftborder:int=300;
			var rightborder:int=1000;
			var downborder:int=500;
			//边界
			
			var bar1:size3=new size3();
			bar1.y=downborder;
			bar1.x=(rightborder-leftborder)/2;
			addChild(bar1);
			var bar2:size3=new size3();
			bar2.y=upborder-bar2.height;
			bar2.x=(rightborder-leftborder)/2;
			addChild(bar2);
			var bar3:size3=new size3();
			var WIDTH:Number=bar3.width
			bar3.width=bar3.height;
			bar3.height=WIDTH;			
			bar3.x=leftborder-bar3.width;
			bar3.y=(downborder-upborder)/2;
			addChild(bar3);
			var bar4:size3=new size3();
			bar4.height=bar3.height;
			bar4.width=bar3.width;
			bar4.x=rightborder;
			bar4.y=(downborder-upborder)/2;
			addChild(bar4);
			
			function barmove(event:MouseEvent):void
			{
				bar1.x=mouseX;
				bar2.x=mouseX;
				if(mouseX<leftborder){
					bar1.x=leftborder;
					bar2.x=leftborder;
				}
				if(mouseX+bar1.width>rightborder){
					bar1.x=rightborder-bar1.width;
					bar2.x=rightborder-bar1.width;
				}
				bar3.y=mouseY;
				bar4.y=mouseY;
				if(mouseY<upborder){
					bar3.y=upborder;
					bar4.y=upborder;
				}
				if(mouseY+bar3.height>downborder){
					bar3.y=downborder-bar3.height;
					bar4.y=downborder-bar3.height;
				}		
			}
			//挡板
			
			var v:Number=15;
			var vx:Number=0;
			var vy:Number=0;
			var startbtn:STARTBTN=new STARTBTN();
			
			startbtn.addEventListener(MouseEvent.CLICK,gamestart);			
			function gamestart (event:MouseEvent):void
			{			
				var phi:Number=Math.random()*2*3.14;
				if(phi==0 || phi==0.5 || phi==1 || phi==1.5){
					phi=phi+0.5;
				}
				var xphi:Number=Math.cos(phi);
				var yphi:Number=Math.sin(phi);
				vx=v*xphi;
				vy=v*yphi;
				timer.start();
				parent.stage.addEventListener(MouseEvent.MOUSE_MOVE,barmove);
			}
			startbtn.x=20;
			startbtn.y=20;			
			addChild(startbtn);
			//开始键
			
			var resetbtn:RESETBTN=new RESETBTN();
			resetbtn.addEventListener(MouseEvent.CLICK,gamereset);
			function gamereset (event:MouseEvent):void
			{
				timer.stop();
				ball.x=600;
				ball.y=300;
				vx=0;
				vy=0;	
				score=0;
				scoretxt.text="SCORE  "+score;
			}
			resetbtn.x=20;
			resetbtn.y=200;
			addChild(resetbtn);
			//重置键
			
			var score:int=0;
			var scoretxt:TextField=new TextField();
			scoretxt.x=20;
			scoretxt.y=400;	
			scoretxt.width=200
			scoretxt.text="SCORE  "+score;
			addChild(scoretxt);
			//得分
			
			
			
			
			var timer:Timer=new Timer(10);			
			timer.addEventListener("timer",timehandler);
			function timehandler (event:TimerEvent):void
			{	
				if(ball.x-R<=bar3.x+bar3.width && ball.y+R>=bar3.y && ball.y-R<=bar3.y+bar3.height){
					vx=-vx;
					ball.x=leftborder+R;
					score=score+100;
					scoretxt.text="SCORE  "+score;
				}
				if(ball.x+R>=bar4.x && ball.y+R>=bar3.y && ball.y-R<=bar3.y+bar3.height){
					vx=-vx;
					ball.x=rightborder-R;
					score=score+100;
					scoretxt.text="SCORE  "+score;
				}
				if(ball.y-R<=bar2.y+bar2.height && ball.x+R>=bar2.x && ball.x-R<=bar2.x+bar2.width){
					vy=-vy;
					ball.y=upborder+R;
					score=score+100;
					scoretxt.text="SCORE  "+score;
				}
				if(ball.y+R>=bar1.y && ball.x+R>=bar2.x && ball.x-R<=bar2.x+bar2.width){
					vy=-vy;
					ball.y=downborder-R;
					score=score+100;
					scoretxt.text="SCORE  "+score;
				}
				if(ball.x>rightborder+20 || ball.x<leftborder-20 || ball.y<upborder-20 || ball.y >downborder+20){
					timer.stop();
					scoretxt.text="GAMEOVER!     FINAL SCORE:"+score
				}
				ball.x=ball.x+vx;
				ball.y=ball.y+vy;
				
			}
			//计时器	
			
			
			
			
		}
	}
}