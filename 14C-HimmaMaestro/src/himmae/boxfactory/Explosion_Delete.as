package himmae.boxfactory
{
	import flash.utils.setTimeout;
	
	import himmae.misc.BGM;
	
	import himmae.observer.ISubject2;

	/**删除自己的爆炸**/
	internal class Explosion_Delete implements IExplosion
	{
		private var _sub:ISubject2;
		private var _type:int;
		private var _count:int;
		private var _bgs:String
		/**@param sub :  爆炸时改变的数值（时间/分数） ， 默认为null，没有改变
		 * @param type :  改变数值时的改变，这里只能传入1或-1，代表是“加”还是“减”，改变的数值是count
		 * @param bgs :  爆炸时的音效
		 * **/
		public function Explosion_Delete(count:int , bgs:String , sub:ISubject2=null , type:int=1)
		{
			if(type!=1 && type!=-1) throw new Error("Wrong param");
			if(sub) _sub=sub;
			_type=type;
			_count=count;
			_bgs=bgs;
		}
		
		public function Explode(arr:Array=null , h:int=0):Array{
			arr.splice(h,1);
			if(_sub)	_sub.param+= (_count*_type);
			BGM.instance[_bgs]();
			return arr;
		}
		
		public function isExplode(arr:Array=null , h:int=0):Boolean{
			return arr.length-h>_count;
		}
	}
}