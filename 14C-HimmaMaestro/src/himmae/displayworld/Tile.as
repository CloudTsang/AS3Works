package himmae.displayworld
{
	import com.friendsofed.isometric.DrawnIsoTile;
	import himmae.misc.Colors;
	
	public class Tile extends DrawnIsoTile
	{		
		public function Tile(type:String , size:Number, height:Number=0)
		{
			color=Colors.instance.getColor(type);
			super(size, color, height);
		}
	}
}