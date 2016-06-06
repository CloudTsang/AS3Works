package
{
	import jp.maaash.ObjectDetection.ObjectDetector;
	import jp.maaash.ObjectDetection.ObjectDetectorOptions;
	
	public class FaceDetector extends ObjectDetector
	{
		public function FaceDetector()
		{
			super();
			this.options=initOptions();
			this.loadHaarCascades( "face.zip" );
		}
		private function initOptions():ObjectDetectorOptions{
			var _options :ObjectDetectorOptions= new ObjectDetectorOptions;
			_options.min_size = 50;
			_options.startx = ObjectDetectorOptions.INVALID_POS;
			_options.starty = ObjectDetectorOptions.INVALID_POS;
			_options.endx = ObjectDetectorOptions.INVALID_POS;
			_options.endy = ObjectDetectorOptions.INVALID_POS;
			return _options;		
		}
	}
}