package himmae.misc
{
	import com.adobe.serialization.json.JSON;
	public class Colors
	{
		[Embed(source="color.txt", mimeType="application/octet-stream")]
		private  var Js:Class;
		private var _colorCode:Object;
		private static var _ins:Colors;
		public function Colors()
		{
			if(_ins) throw new Error("This is a singleton");
			_colorCode=com.adobe.serialization.json.JSON.decode(new Js);
		}		
		public function getColor(code:String):uint{
			return _colorCode[code];
		}
		public static function initColor():void{
			_ins=new Colors();
		}
		public static function get instance():Colors{
			return _ins;
		}
	}
}