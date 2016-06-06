package
{
	import himmae.item.IItemNum;
	import himmae.item.ItemNum;

	/**这是创建一个关卡所需要的最少的信息，即菜单的每一层的选择结果：关卡编号、关卡游玩时间、道具开放**/
	public class StageInfo
	{
		/**关卡编号**/
		public var stage:int;
		/**关卡游玩时间**/
		public var time:String;
		/**道具开放数量**/
		public var item:IItemNum;
		public function StageInfo()
		{
			stage=1;
			time="0600";
			item=new ItemNum();
		}
	}
}