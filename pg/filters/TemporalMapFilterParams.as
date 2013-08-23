package pg.filters {
	import flash.display.BitmapData;
	/**
	 * @author patrickgunderson
	 */
	public class TemporalMapFilterParams {
		public var colormap:BitmapData = new BitmapData(1,1,true,0);
		public var timemap:BitmapData = new BitmapData(1,1,true,0);
		public var frameWidth:int = 1;
		public var timemapParams:Object = { 
			zeroFrame: 0,
			numFrames: 8,
			useCamera: false
		}
		public var colormapParams:Object = { 
			zeroFrame: 0,
			numFrames: 8,
			useCamera: false
		}
	}	
}
