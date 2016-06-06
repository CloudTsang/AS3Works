package himmae.item
{
	import flash.display.DisplayObject;

	public interface IItem
	{
		function useItem():void;
		/**该道具是否有显示对象**/
		function haveDispObj():Boolean;
		/**获取显示对象,返回一个DisplayObject的向量**/
		function get DispObj():Vector.<DisplayObject>;
	}
}