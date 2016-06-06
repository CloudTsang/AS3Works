package himmae.displayworld
{
	import himmae.boxfactory.Box;
	
	import com.friendsofed.isometric.Point3D;
	
	import himmae.controllercommand.IControllerSwitch;
	
	import flash.events.Event;
	import flash.geom.Matrix;
	import himmae.iterfaces.IPartsSize;

	/**没有开场检视方块的世界**/
	public class IsoFloor_Immediate extends IsoFloor_Template
	{
		public function IsoFloor_Immediate(sc:IPartsSize , ctrl:IControllerSwitch)
		{
			super(sc , ctrl);
		}
		
		/**没有开场检视的生成函数**/
		public override function createFloor(arrTile:Array=null , arrBox:Array=null):void{
			bmpDrawFloor(arrTile);
			renewWorld(arrBox);
			finishCreate();
		}
	}
}