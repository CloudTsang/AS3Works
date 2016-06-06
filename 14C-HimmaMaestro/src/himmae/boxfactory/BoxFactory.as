package himmae.boxfactory
{
	import com.adobe.serialization.json.JSON;
	
	import flash.utils.getDefinitionByName;
	
	import himmae.observer.ISubject2;

	/**方块工厂**/
	public class BoxFactory
	{
		[Embed(source="boxData.txt", mimeType="application/octet-stream")]
		private  var js:Class;
		private  var jsData:Object=com.adobe.serialization.json.JSON.decode(new js);
		
		private var _prop:Object;
		
		private var _s:int;
		private var _h:int;
		private var _time:ISubject2;
		private var _score:ISubject2;
		
		private var _boxhero_value:int;
		
		private static  var _ins:BoxFactory;
		
		public function BoxFactory(size:int , hei:int , time:ISubject2 , score:ISubject2) 
		{
			if(_ins)throw new Error("This is a singleton");
			_s=size;
			_h=hei;
			_time=time;
			_score=score;
			_prop=jsData.box;
			_boxhero_value=getBoxProp(HM.HERO , HM.BOX_VALUE);
		}
		public static function initFactory(size:int , hei:int , time:ISubject2 , score:ISubject2):void{
			if(_ins)return;
			_ins=new BoxFactory(size ,hei , time , score);
		}
		public static function get instance():BoxFactory{
			return _ins;
		}
		public static function removeFactory():void{
			_ins=null;
		}
		/**获取砖头的显示对象**/
		public  function getBoxDisplay(type:String):Box{
			var tmpArr:Array=type.split("&");
			return new Box(tmpArr , _s , _h);
		} 
		/**获取砖头的分数**/
		public function getBoxScore(type:String):int{
			return getBoxProp( type.split("&")[0] , HM.BOX_SCORE );
		}
		/**获取砖头的爆炸方式**/
		public function getBoxExplosion(type:String):IExplosion{
			var tmpArr:Array=type.split("&");
			switch(tmpArr[0]){
				case HM.BRICK:
				case HM.NORMAL:
				case HM.HERO:
				case HM.POWER:
					return new Explosion_Null;
				case HM.SCARTTER:
					return new Explosion_Delete(tmpArr[1]  ,HM.ACT_GOAL,_score , 1);
				case HM.BOMB:
					return new Explosion_Delete(tmpArr[1] , HM.EXPLODE , null , 1);
				case HM.TIMEREC:
					return new Explosion_Delete(tmpArr[1] , HM.ACT_GOAL ,_time , 1);
				case HM.GLASS:
					return new Explosion_Delete(tmpArr[1] , HM.EXPLODE_GLASS ,_score , -1);
			}
			return null;
		}
		
		/**将方块排序，自动将不能踩的方块放在上面，不能举的方块放下面**/
		public function BoxSort(arr:Array):Array{
			var sortArr:Array=new Array;
			var tmpArr:Array=new Array;
			for(var i:int=0; i<arr.length ; i++){
				tmpArr.push(
					{
						type:arr[i],
						value:getBoxProp( arr[i].split("&")[0] , HM.BOX_VALUE)
					}
				)
			}
			tmpArr.sortOn(HM.BOX_VALUE);
			for(i=0 ; i<tmpArr.length ; i++) sortArr.unshift( tmpArr[i].type );
			return sortArr;
		}
		
		/**方块能不能举起来，使用这个函数的情况：进行举起操作时**/
		public  function Liftable(type:String):Boolean{
			var res:int=getBoxProp(type.split("&")[0] , HM.ACT_LIFT);
			if(res==1)return true;
			return false;
		}
		
		/**方块能不能踩上去或被放上方块，使用这个函数的情况：进行踩上、放下操作时。
		 * 部分方块可以被举起、踩上以及放下，为了防止这类方块被放在不能踩上的方块上导致整栋方块能被踩上，检查将在循环至不是这类方块时为止。
		 * @param arr:要测试的数组
		 * @param ctrltype:要测试的操作，step 或 down
		 * **/
		public  function Stepable(arr:Array , ctrltype:String):Boolean{
			if(ctrltype!=HM.ACT_STEP && ctrltype!=HM.ACT_DOWN) throw new Error("Wrong param!");
			var tmp:*;
			for(var i:int=arr.length-1 ; i>=0 ; i--){
				tmp=getBoxProp(arr[i].split("&")[0] , ctrltype);
				if(tmp!=-1){
					return Boolean(tmp);
				}
			}
			return true;
		}
		
		/**是否能进行踢操作
		 * @param arr :　面前的方块数组
		 * @param  kicked ： 被踢出的方块类型
		 * **/
		public function Kickable( arr:Array , kicked:String):Boolean{
			var res:Boolean;
			var tmp:*
			for(var i:int=arr.length-1 ; i>=0 ; i--)
			{
				tmp=getBoxProp(arr[i].split("&")[0] , HM.ACT_DOWN);
				if(tmp!=-1)
				{
					if( getBoxProp(arr[i].split("&")[0] , HM.BOX_VALUE)<_boxhero_value
						&& _boxhero_value<getBoxProp(kicked.split("&")[0], HM.BOX_VALUE))return false;
					return Boolean(tmp);
				}
			}
			return true;
		}
		
		private function getBoxProp(type_box:String , type_key:String):*{
			return _prop[type_box][type_key];
		}
		
	}
}