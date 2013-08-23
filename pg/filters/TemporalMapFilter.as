package pg.filters {
	import flash.display.BitmapData;
	import flash.filters.ShaderFilter;
	import flash.display.Shader;
	/**
	 * @author patrickgunderson
	 */
	public class TemporalMapFilter extends Object {
		
		[Embed(source="pb/TemporalPixelMap.pbj", mimeType="application/octet-stream")]
		private static var TemporalPixelMap : Class;
		private var _shader : Shader;
		private var _filter : ShaderFilter;
		private var isDirty: Boolean = true;
		
		private var _colormap:BitmapData = new BitmapData(1, 1, true, 0);
		private var _timemap:BitmapData = new BitmapData(1,1,true,0);
		private var _timemapParams:Object = {
			numFrames: 1,
			zeroFrame: 0
		}
		private var _colormapParams:Object = {
			numFrames: 1,
			zeroFrame: 0
		}
		private var _frameWidth:int = 640;
		
		public function TemporalMapFilter(params : Object = null) {
			
			_shader = new Shader(new TemporalPixelMap());
			_filter = new ShaderFilter(shader);
			
			if (params){
				this.params = params;
			} else {
				this.params = new TemporalMapFilterParams();
			}
		}
		
		public function set params(params : Object):void{
			isDirty = true;
			if (params.colormap) 		colormap 		= params.colormap;
			if (params.timemap) 		timemap 		= params.timemap;
			if (params.colormapParams) 	colormapParams	= params.colormapParams;
			if (params.timemapParams) 	timemapParams	= params.timemapParams;
			if (params.frameWidth)	 	frameWidth	 	= params.frameWidth;
		}
		
		public function get filter():ShaderFilter{
			if (isDirty){
				_filter = new ShaderFilter(shader);
				isDirty = false;
			}
			return _filter;
		}

		public function get timemapParams() : Object {
			return _timemapParams;
		}

		public function set timemapParams(value : Object) : void {
//			isDirty = true;
//			shader.data.timemapZeroFrame.value = [value.zeroFrame];
//			shader.data.timemapNumFrames.value = [value.numFrames];
			_timemapParams = value;
		}

		public function get colormapParams() : Object {
			return _colormapParams;
		}

		public function set colormapParams(value : Object) : void {
			isDirty = true;
			shader.data.zeroFrame.value = [value.zeroFrame];
			shader.data.numFrames.value = [value.numFrames];
			_colormapParams = value;
		}

		public function get frameWidth() : int {
			return _frameWidth;
		}

		public function set frameWidth(value : int) : void {
			isDirty = true;
			shader.data.frameWidth.value = [value];
			_frameWidth = value;
		}

		public function get colormap() : BitmapData {
			return _colormap;
		}

		public function set colormap(bmd : BitmapData) : void {
			isDirty = true;
			shader.data.colormap.input = bmd;
			_colormap = bmd;
		}

		public function get timemap() : BitmapData {
			return _timemap;
		}

		public function set timemap(bmd : BitmapData) : void {
			isDirty = true;
			shader.data.timemap.input = bmd;
			_timemap = bmd;
		}

		public function get shader() : Shader {
			return _shader;
		}
	}
}
