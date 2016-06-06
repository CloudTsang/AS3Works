package
{
	import himmae.boxfactory.Box;
	
	import com.adobe.serialization.json.JSON;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;
	
	import himmae.item.IItemNum;
	import himmae.item.ItemNum;
	
	import himmae.misc.BGM;
	import himmae.misc.TextBlank;
	import himmae.iterfaces.IMenu;
	
	public  class Menu extends Sprite implements IMenu
	{
		[Embed(source="menudata.txt", mimeType="application/octet-stream")]
		private var js:Class;
		private var jsData:Object=com.adobe.serialization.json.JSON.decode(new js);;
		
		/**每层菜单的选项**/
		private var _selection:Object;
		/**全部层菜单的名字的数组**/
		private var _menu:Array;
		/**当前在哪一层菜单的名字**/
		private  var _currentMenu:String;
		/**获取当前的选项的索引**/
		private var _sIndex:int;
		/**选择游标**/
		private var _marker:Box;
		/**各个选项的txt数组**/
		private var _textVec:Vector.<TextBlank>;
		/**选项字体大小**/
		private var _formatSize:int;
		/**选项行距**/
		private var _lineHeight:int;
		/**描述文本框**/
		private var _txtDes:TextBlank;
		/**道具开放了多少个的文本框**/
		private var _txtItemNum:TextBlank;
		/**关卡总消费的文本框**/
		private var _txtTotalCost:TextBlank;
		/**关卡总消费**/
		private var _totalCost:int;
		/**放置菜单选项的sprite**/
		private var _sp:Sprite;
		private var _info:StageInfo;
		
		private const LINESPACE:int=10;
		
		private var _tscore:int;
		/**@param ts ： 现有总分数**/
		public function Menu(ts:int)
		{			
			super();
			_tscore=ts;
			_selection=jsData.titlemenu;
			_menu=jsData.menus;
			_formatSize=jsData.menuFormat_Size;
			_lineHeight=_formatSize+LINESPACE;
			_currentMenu=_menu[0];
			_sIndex=1;
			_sp=new Sprite;
			_info=new StageInfo();
			_textVec=new Vector.<TextBlank>;
			_marker=Box.createBox(HM.HERO,15 , 15);
			_txtDes=new TextBlank("" ,20,125,200,200,100,true,TextFormatAlign.LEFT,true);
			_txtItemNum=new TextBlank(" " , 20 , 25 ,400 , 0 ,300 , false ,TextFormatAlign.LEFT , true);
			_txtTotalCost=new TextBlank(" ",20 ,25 , 150 , 0, 325 , false ,TextFormatAlign.LEFT ,true);
			_txtDes.visible=false;
			_txtItemNum.visible=false;
			_txtTotalCost.visible=false;			
			createMenu(_selection[_currentMenu]);		
			addChild(_sp);
			addChild(_marker);
			addChild(_txtDes);
			addChild(_txtItemNum);
			addChild(_txtTotalCost);
			BGM.instance.TITLE();
		}
		
		/**生成显示菜单**/
		private function createMenu(arr:Array):void{
			_sp.removeChildren();
			var _txt:TextBlank;
			var _str:String;
			_textVec=new Vector.<TextBlank>;
			for(var i:int=0 ; i<arr.length ; i++){
				_str=Selection(i , _currentMenu)
				_txt=new TextBlank( _str,  _formatSize , _formatSize+5 , _str.length*40 , 20 , i*_lineHeight ,false );
				_textVec.push(_txt) ;
				_sp.addChild(_txt);
			}
			_marker.y=_textVec[1].y+_marker.height;			
		}
		
		/**将已开放道具reset**/
		private function itemReset():void{
			_info.item.reset();
			_totalCost=0;
			_txtItemNum.text="已开放道具：力量砖 0   探照灯 0   捕鸟器 0";
			_txtTotalCost.text="扣除分数： 0";
		}
		
		private function evtHandler(e:String):void{
			var tmp:Array=e.split("&");
			switch(tmp[0]){
				case "gamestart":
					_info.time=tmp[1];
					dispatchEvent(new Event( HM.GAME_START ));
					break;
				case "item":
					if(_info.item[tmp[1]]==3) _info.item[tmp[1]]=0;
					else _info.item[tmp[1]]++;
					_totalCost=_info.item.cost();
					_txtTotalCost.text="扣除分数： "+String(_totalCost);
					_txtItemNum.text="已开放道具：力量砖 "+String(_info.item.numPow)+"   探照灯 "+String(_info.item.numLight)+"   捕鸟器 "+String(_info.item.numBirdCapture);
					break;
			}
		}
		
		public function renewDes():void{
			_txtDes.text=Description;
		}
		
		public function get stageInfo():StageInfo{
			return _info;
		}
		
		public function selUp():void{
			_sIndex--;
			_marker.y-=_formatSize;
		}
		
		public function selDown():void{
			_sIndex++;
			_marker.y+=_formatSize;
		}
		
		public  function nextMenu():void{					
			if(Next=="event"){
				evtHandler(EventId);
				return;//处理事件
			}		
			if(_currentMenu=="stage" && _totalCost>_tscore)return;
			switch(_currentMenu){
				case "stage":
					itemReset();
					_txtItemNum.visible=true;
					_txtTotalCost.visible=true;
					_info.stage=int(EventId);
					BGM.instance.PREPARE();
					break;
				case "top":
					_txtDes.visible=true;
					break;
			}
			_currentMenu=Next;
			_sIndex=1;
			createMenu(_selection[_currentMenu]);
			BGM.instance.lift();
		}
		
		public function prevMenu():void{
			_sIndex=1;
			_currentMenu=Prev;
			switch(_currentMenu){
				case "stage":
					itemReset();
					_txtItemNum.visible=false;
					_txtTotalCost.visible=false;
					BGM.instance.TITLE();
					break;
				case "top":
					_txtDes.visible=false;
					break;
			}
			createMenu(_selection[_currentMenu]);
			BGM.instance.down();
		} 
	
		public function get sIndex():int{
			return _sIndex;
		}
		
		public function get Next():String{
			return  _selection[_currentMenu][_sIndex].next;
		}
		
		public function get Prev():String{
			return  _selection[_currentMenu][_sIndex].prev;
		}
	
		public function get menuLength():int{
			return _selection[_currentMenu].length;
		}
		
		/**当前选项文本**/
		private function Selection(si:int , mi:String):String{
			return  _selection[mi][si].selection;
		}
		/**当前选项的描述文本**/
		private function get Description():String{
			return  _selection[_currentMenu][_sIndex].description;
		}
		/**获取事件id**/
		private function get EventId():String{
			return  _selection[_currentMenu][_sIndex].id;
		}
		/**当前的菜单层**/
		private function get currentSelection():String{
			return  _selection[_currentMenu][_sIndex].selection;
		}
	}
}