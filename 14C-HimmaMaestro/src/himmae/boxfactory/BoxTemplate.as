package himmae.boxfactory
{

	internal class BoxTemplate implements IBox
	{
		protected var _iex:IExplosion;
		protected var _score:int;
		protected var _value:int;
		protected var _lift:int;
		protected var _step:int;
		protected var _down:int;
		/**@param score : 分数
		 * @param value : 排序
		 * @param liftable,stepable,downable : 举起、站上、被压住,为1时可以执行操作,为0时不可以执行操作,为-1时要轮候到下一方块再判决
		 * @param count : 方块上的计数 **/
		public function BoxTemplate(score:int ,value:int , liftable:int , stepable:int , downable:int)
		{
			_score=score;
			_value=value;
			_lift=liftable;
			_step=stepable;
			_down=downable;
//			_count=count;
		}
		
		public function Explode(arr:Array , h:int):Array
		{
			if(_iex.isExplode(arr , h)) arr=_iex.Explode(arr , h);
			return arr;
		}
		
		public final function get Score():int{
			return _score;
		}
		public final function get Value():int{
			return _value;
		}
		public final function get Liftable():int{
			return _lift;
		}
		public final function get Stepable():int{
			return _step;
		}
		public final function get Downable():int{
			return _down;
		}
	}
}