package himmae.iterfaces
{
	public interface IWorldData
	{
		/**移动地图格的数据，并且更新舞台显示？
		 * @param newX，newZ 移动到的格子
		 * @param oldX，oldZ 被移动的格子
		 * @param arr1 放到移动到的格子上的方块，默认为将被移动的格子上的方块放到这里
		 * @param arr2 放到被移动的格子上的方块，默认为什么都没有（新数组）
		 * **/
		function cellMove(newX:int , newZ:int , oldX:int , oldZ:int , arr1:Array=null , arr2:Array=null ,explode:Boolean=false ,sort:Boolean=false):void;
		/** @param sort ： 数组是否需要排序
		 * @param explode ： 是否可能有爆炸方块*/
		function setCellData(arr:Array , x:int , z:int ,explode:Boolean=false ,sort:Boolean=false):void;
		function getCellData( x:int , z:int):Array;
		function getFloorData(x:int , z:int):String;
		/**更新舞台显示**/
		function renewStage():void;
		/**地图宽度**/
		function get width():int;
		/**地图长度**/
		function get height():int;
		/**整个方块数组**/
		function get Cell():Array;
		/**整个地板数组**/
		function get Floor():Array;
	}
}