package himmae.iterfaces
{
	
	
	import himmae.item.ItemCollection;
	
	import himmae.observer.TimeCount;
	import himmae.observer.TxtObserver;
	import himmae.observer.IObserver2;
	import himmae.observer.ISubject2;
	import himmae.controllercommand.IController;
	import himmae.displayworld.IWorld;
	/**关卡创建器**/
	public interface IWorldCreator
	{
		/**载入菜单**/	function loadMenu():void;
		/**载入关卡信息**/	function loadStage(info:StageInfo=null):void;
		/**开始创建关卡**/	function createStage():void;
		function get menu():IMenu;
		function get hero():IHero;
		function get bird():IBird;
		function get world():IWorld;
		function get data():IWorldData;
		function get item():ItemCollection;
		function get time():ISubject2;
		function get timeTxt():IObserver2;
		function get score():ISubject2;
		function get scorelimit():int;
		function get scoreTxt():IObserver2;
		/**整个游戏的总分**/	function get totalScore():ISubject2;
		function get totalScoreTxt():IObserver2;
	/**控制器**/	function get Controller():IController
	}
}