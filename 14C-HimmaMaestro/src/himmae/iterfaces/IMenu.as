package himmae.iterfaces
{
	public interface IMenu 
	{ 
		/**更新描述文本**/
		function renewDes():void;
		/**选择:上**/
		function selUp():void;
		/**选择:下**/
		function selDown():void;
		/**确认，下层菜单**/
		function nextMenu():void;
		/**否认，上层菜单**/
		function prevMenu():void;
		/**各层菜单的选择结果，包含新建一个关卡所必需的信息**/
		function get stageInfo():StageInfo;
		/**获取当前的选项的索引**/
		function get sIndex():int;
		/**这一层菜单的选项数**/
		function get menuLength():int;
		/**上一层菜单**/
		function get Prev():String;
		/**下一层菜单**/
		function get Next():String;
	}
}