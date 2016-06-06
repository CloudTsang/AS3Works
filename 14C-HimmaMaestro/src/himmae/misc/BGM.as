package himmae.misc
{
	import com.adobe.serialization.json.JSON;
	
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.utils.getDefinitionByName;
	
	public class BGM
	{		
		/**声音按钮**/
		public  var Volume:BtnBgmCtrl=new BtnBgmCtrl;
		private  var _Trans:SoundTransform=new SoundTransform(1);
		private  var _BGMch:SoundChannel=new SoundChannel;
		
		private static var _instance:BGM=new BGM;
		
		[Embed(source="BGMDATA.txt", mimeType="application/octet-stream")]
		private  var _Json:Class;
		private var _musicData:Object=com.adobe.serialization.json.JSON.decode(new _Json) ;
		
		public function BGM(){
			if(_instance!=null) throw new Error("This is a singleton");
		}
		
		public static function get instance():BGM{
			return _instance;
		}
		
		/**声音按钮静音切换函数**/
		public   function SoundCtrl(e:MouseEvent=null ):void{		
			_Trans.volume=1-_Trans.volume;				
			SoundMixer.soundTransform=_Trans;
		}
		/**静音按钮是否可按**/
		public function btnEnable(b:Boolean):void{
			Volume.mouseChildren=b;
			Volume.mouseEnabled=b;
		}
		
		private  function playBGM(str:String,loop:int):void{
			var bgmclass:Class=getDefinitionByName(str) as Class
			_BGMch.stop();
			_BGMch= (new bgmclass).play(0,loop);
		}
		
		public  function BGSstop():void{
			_birdCh.stop();
			_bgsCh.stop();
		}
		
		public  function TITLE():void{		
			playBGM(_musicData["title"] , 999);
			SoundMixer.soundTransform=_Trans;
		}
		public  function PREPARE():void{
			playBGM(_musicData["prepare"],999);
		}
		
		public  function WORK0600():void{
			playBGM(_musicData["work0600"][int(Math.random()*_musicData["work0600"].length)],999);
		}
		public  function WORK1800():void{
			playBGM(_musicData["work1800"][int(Math.random()*_musicData["work1800"].length)],999);
		}
		public  function WORK2400():void{
			playBGM(_musicData["work2400"][int(Math.random()*_musicData["work2400"].length)],999);
		}
		public  function STAGECLEAR():void{
			playBGM(_musicData["clear"],1);
		}
		public  function GAMEOVER():void{
			playBGM(_musicData["gameover"],1);
		}		
		
		public  function lift():void{
			_bgsCh=_lift.play(0,1);
		}
		public  function step():void{
			_bgsCh=_step.play(0,1);
		}
		public  function down():void{
			_bgsCh=_down.play(0,1);
		}
		public  function kick():void{
			_bgsCh=_kick.play(0,1);
		}
		public  function goal():void{
			_bgsCh=_goal.play(0,1);
		}
		/**大鸟飞来的音效
		 * @param leak : 声道，只在大鸟飞来的方向的声道有声音
		 * **/
		public  function birdCome(leak:int):void{
			_birdCh=(new BGSbird).play(0,1);
			_birdCh.soundTransform=new SoundTransform(1 ,  -1+leak*2 );
		}
		public  function explosion():void{
			_bgsCh=_bomb.play(0,1);
		}
		public  function explosion_glass():void{
			_bgsCh=_glass.play(0,1);
		}
		
		
		private var _work0600:BGMwork0600;
		private var _work06001:BGMwork06001;
		private var _work06002:BGMwork06002;
		private var _work1800:BGMwork1800;
		private var _work18001:BGMwork19001;
		private var _work18002:BGMwork19002;
		private var _work2400:BGMwork2400;
		private var _work24001:BGMwork24001;
		private var _work24002:BGMwork24002;
		private var _victory:BGMclear;
		private var _gameover:BGMgameover;
		private var _title:BGMtitle;
		private var _prepare:BGMPreparation;
		
		private  var _bgsCh:SoundChannel=new SoundChannel;
		private  var _birdCh:SoundChannel=new SoundChannel;
		private  var _lift:BGSlift=new BGSlift;
		private  var _step:BGSstep=new BGSstep;
		private  var _down:BGSdown=new BGSdown;
		private  var _kick:BGSkick=new BGSkick;
		private  var _goal:BGSgoal=new BGSgoal;
		private  var _bomb:BGSbomb=new BGSbomb;
		private  var _glass:BGSglass=new BGSglass;
		
		
	}
}