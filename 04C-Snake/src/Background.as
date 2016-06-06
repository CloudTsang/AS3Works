package
{	
	import flash.display.Sprite;

	public class Background
	{
		public var BG:Array=new Array;
		public function Background(Height:int,Width:int)
		{			
			for(var hei:int=0;hei<Height;hei++)
			{
				var bg:Array=new Array;
				for(var wid:int=0;wid<Width;wid++)
				{					
					bg[wid]=makeCell(180+wid*30,30+hei*30);
				}
				BG[hei]=bg;
			}
		}
		private function makeCell(x:int,y:int):Sprite
		{
			var cell:Sprite=new Sprite;
			cell.graphics.lineStyle(1,0x000000);
			cell.graphics.beginFill(0xffffff);
			cell.graphics.drawRect(x,y,30,30);
			return cell;
		}
	}
}