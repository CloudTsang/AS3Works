package
{
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	public class Snake
	{
		public var snake:Array=new Array;
		public var Length:int;
		public var direction:int;
		public var timer:Timer=new Timer(1000);
		public var colour:uint;
		public var name:String;
		public var gamePad:Gpad
		public var moving:Boolean=true;
		
		private var up:uint;
		private var left:uint;
		private var right:uint;
		private var down:uint;

		public function Snake(Colour:uint,Name:String)
		{	
			colour=Colour;
			name=Name
			makePad();
		}
	    
		private function makePad():void
		{
			gamePad=new Gpad(colour,name);
			if(name=="Solid Snake"){
				gamePad.x=5;
				gamePad.y=200;
			}else if(name=="Liquid Snake"){
				gamePad.x=790;
				gamePad.y=10;
			}else if(name=="Solidus Snake"){
				gamePad.x=790;
				gamePad.y=300;
			}
			gamePad.upbtn.addEventListener(MouseEvent.MOUSE_DOWN,toUP);
			gamePad.downbtn.addEventListener(MouseEvent.MOUSE_DOWN,toDOWN);
			gamePad.leftbtn.addEventListener(MouseEvent.MOUSE_DOWN,toLEFT);
			gamePad.rightbtn.addEventListener(MouseEvent.MOUSE_DOWN,toRIGHT);
		}
		private function toUP(event:MouseEvent):void
		{
			moveUP();
		}
		private function toDOWN(event:MouseEvent):void
		{
			moveDOWN();
		}
		private function toLEFT(event:MouseEvent):void
		{
			moveLEFT();
		}
		private function toRIGHT(event:MouseEvent):void
		{
			moveRIGHT();
		}
		
		public function makeSnk(length:int,Xcell:int,Ycell:int):void//长度，头的X,Y格子坐标
		{
			direction=1;
			timer.delay=500;
			Length=length;
			timer.addEventListener("timer",Move)
			for(var a:int=0;a<=length;a++)
			{
				var body:Part=new Part(a,colour);
				snake[a]=body;
				snake[a].y=-a*30+Ycell*30;
				snake[a].x=Xcell*30;
			}
		}
		
		public function Grow():int
		{
			Length++;
			var body:Part=new Part(Length-1,colour);
			snake[Length-1]=body;
			snake[Length-1].x=snake[Length-2].x;
			snake[Length-1].y=snake[Length-2].y;
			return Length;
		}
						
		public function putPad(upkey:uint,downkey:uint,leftkey:uint,rightkey:uint):void
		{
			up=upkey;
			down=downkey;
			right=rightkey;
			left=leftkey;
		}
		
		public function Control(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case down:
					moveDOWN();
					break;
				case up:
					moveUP();
					break;
				case left:
					moveLEFT();
					break;
				case right:
					moveRIGHT();
					break;
			}
		}
		
		private function moveUP():void
		{
			if(direction==1)
			{
				timer.delay=500;
			}
			else if(direction==2 && timer.delay>300)
			{
				timer.delay-=100;
			}
			else
			{
				direction=2;
			}
		}
		private function moveDOWN():void
		{
			if(direction==2)
			{
				timer.delay=500;
			}
			else if(direction==1 && timer.delay>300)
			{
				timer.delay-=100;
			}
			else
			{
				direction=1;
			}
		}
		private function moveLEFT():void
		{
			if(direction==4)
			{
				timer.delay=500;
			}
			else if(direction==3 && timer.delay>300)
			{
				
				timer.delay-=100;
			}
			else
			{
				direction=3;
			}
		}
		private function moveRIGHT():void
		{
			if(direction==3)
			{
				timer.delay=500;
			}
			else if(direction==4 && timer.delay>300)
			{
				timer.delay-=100;
			}
			else
			{
				direction=4;
			}
		}
		
		private function Move(event:TimerEvent):void
		{
			switch (direction)
			{
				case 1:  //down
					for(var a:int=Length-1;a>0;a--)
					{
						snake[a].x=snake[a-1].x;
						snake[a].y=snake[a-1].y;
					}
					snake[0].y+=30;
					break;
				case 2: //up
					for(a=Length-1;a>0;--a)
					{
						snake[a].x=snake[a-1].x;
						snake[a].y=snake[a-1].y;
					}
					snake[0].y-=30;
					break;
				case 3: //left
					for(a=Length-1;a>0;--a)
					{
						snake[a].x=snake[a-1].x;
						snake[a].y=snake[a-1].y;
					}
					snake[0].x-=30;
					break;
				case 4: //right
					for(a=Length-1;a>0;--a)
					{
						snake[a].x=snake[a-1].x;
						snake[a].y=snake[a-1].y;
					}
					snake[0].x+=30;
					break;
			}
			
			for(var b:int=3;b<Length;b++){
				if(snake[0].x==snake[b].x && snake[0].y==snake[b].y)
				{
					timer.stop();
				}
			}
		}
	}
}