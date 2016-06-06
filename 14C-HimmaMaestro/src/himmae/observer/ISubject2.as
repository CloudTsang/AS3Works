package himmae.observer
{
	public interface ISubject2
	{
		function regObserver(obs:IObserver2):void;
		function delObserver(obs:IObserver2):void;
		function callObserver():void;
		function set param(p:*):void;
		function get param():*;
	}
}