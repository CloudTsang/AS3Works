package
{
	import flash.geom.ColorTransform;

	public class Colors
	{
		private var _normal:ColorTransform;
		private var _selected:ColorTransform;
		public function Colors()
		{
			_normal=new ColorTransform;
			_normal.color=0x00FF00;
			_selected=new ColorTransform;
			_selected.color=0xFF0000;
		}
		public function get Selected():ColorTransform{
			return _selected;
		}
		public function get Normal():ColorTransform{
			return _normal;
		}
	}
}