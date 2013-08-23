package pg.filters {
	import flash.filters.ShaderFilter;
	import flash.display.Shader;
	/**
	 * @author patrickgunderson
	 */
	public class ScanlinesFilter extends Object {
		
		[Embed(source="pb/Scanlines.pbj", mimeType="application/octet-stream")]
		private static var Scanlines : Class;
		private var shader : Shader;
		private var _filter : ShaderFilter;
		private var isDirty: Boolean = true;
		
		private var _offsetY:Number = 0;
		private var _minMultiplier:Number = 0.5;
		private var _cycleSize:int = 3;
		
		public function ScanlinesFilter(params : Object = null) {
			
			shader = new Shader(new Scanlines());
			_filter = new ShaderFilter(shader);
			
			if (params){
				this.params = params;
			} else {
				this.params = new ScanlinesFilterParams();
			}
		}
		
		public function set params(params : Object):void{
			if (params.offsetY) 		_offsetY 		= params.offsetY;
			if (params.minMultiplier) 	_minMultiplier	= params.minMultiplier;
			if (params.cycleSize) 		_cycleSize	 	= params.cycleSize;
		}
		
		public function get filter():ShaderFilter{
			if (isDirty){
				_filter = new ShaderFilter(shader);
				isDirty = false;
			}
			return _filter;
		}

		public function get offsetY() : Number {
			return _offsetY;
		}

		public function set offsetY(value : Number) : void {
			isDirty = true;
			shader.data.offsetY.value = [value >> 0];
			_offsetY = value;
		}

		public function get minMultiplier() : Number {
			return _minMultiplier;
		}

		public function set minMultiplier(value : Number) : void {
			isDirty = true;
			shader.data.minMultiplier.value = [value];
			_minMultiplier = value;
		}

		public function get cycleSize() : int {
			return _cycleSize;
		}

		public function set cycleSize(value : int) : void {
			isDirty = true;
			shader.data.cycleSize.value = [value];
			_cycleSize = value;
		}

		
		
	}
}
