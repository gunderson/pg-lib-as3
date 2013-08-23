package pg.filters {
	import flash.filters.ShaderFilter;
	import flash.display.Shader;
	/**
	 * @author patrickgunderson
	 */
	public class StaticFilter extends Object {
		
		[Embed(source="pb/separateRGB.pbj", mimeType="application/octet-stream")]
		private static var RGBSeparator : Class;
		private var shader : Shader;
		private var _filter : ShaderFilter;
		private var isDirty: Boolean = true;
		
		private var _rOffsetX:Number;
		private var _rOffsetY:Number;
		private var _gOffsetX:Number;
		private var _gOffsetY:Number;
		private var _bOffsetX:Number;
		private var _bOffsetY:Number;
		private var _rWaveFrequency:Number;
		private var _rWaveAmplitude:Number;
		private var _gWaveFrequency:Number;
		private var _gWaveAmplitude:Number;
		private var _bWaveFrequency:Number;
		private var _bWaveAmplitude:Number;
		
		
		public function StaticFilter(params : Object = null) {
			
			shader = new Shader(new RGBSeparator());
			_filter = new ShaderFilter(shader);
			
			this.params = new StaticFilterParams();
			if (params){
				this.params = params;
			}
		}
		
		public function set params(params : Object):void{
			if (params.rOffsetX) 		rOffsetX 		= params.rOffsetX;
			if (params.rOffsetY) 		rOffsetY		= params.rOffsetY;
			if (params.gOffsetX) 		gOffsetX	 	= params.gOffsetX;
			if (params.gOffsetY) 		gOffsetY 		= params.gOffsetY;
			if (params.bOffsetX) 		bOffsetX 		= params.bOffsetX;
			if (params.bOffsetY) 		bOffsetY 		= params.bOffsetY;
			if (params.rWaveFrequency) 	rWaveFrequency 	= params.rWaveFrequency;
			if (params.rWaveAmplitude) 	rWaveAmplitude 	= params.rWaveAmplitude;
			if (params.gWaveFrequency) 	gWaveFrequency 	= params.gWaveFrequency;
			if (params.gWaveAmplitude) 	gWaveAmplitude 	= params.gWaveAmplitude;
			if (params.bWaveFrequency) 	bWaveFrequency 	= params.bWaveAmplitude;
			if (params.bWaveAmplitude) 	bWaveAmplitude 	= params.bWaveAmplitude;
		}
		
		public function get filter():ShaderFilter{
			if (isDirty){
				_filter = new ShaderFilter(shader);
				isDirty = false;
			}
			return _filter;
		}

		/*******************************************************/

		public function get rOffsetX() : Number {
			return _rOffsetX;
		}

		public function set rOffsetX(value : Number) : void {
			isDirty = true;
			shader.data.rOffsetX.value = [value];
			_rOffsetX = value;
		}

		/*******************************************************/

		public function get rOffsetY() : Number {
			return _rOffsetY;
		}

		public function set rOffsetY(value : Number) : void {
			isDirty = true;
			shader.data.rOffsetY.value = [value];
			_rOffsetY = value;
		}

		/*******************************************************/

		public function get gOffsetX() : Number {
			return _gOffsetX;
		}

		public function set gOffsetX(value : Number) : void {
			isDirty = true;
			shader.data.gOffsetX.value = [value];
			_gOffsetX = value;
		}

		/*******************************************************/

		public function get gOffsetY() : Number {
			return _gOffsetY;
		}

		public function set gOffsetY(value : Number) : void {
			isDirty = true;
			shader.data.gOffsetY.value = [value];
			_gOffsetY = value;
		}

		/*******************************************************/

		public function get bOffsetX() : Number {
			return _bOffsetX;
		}

		public function set bOffsetX(value : Number) : void {
			isDirty = true;
			shader.data.bOffsetX.value = [value];
			_bOffsetX = value;
		}

		/*******************************************************/

		public function get bOffsetY() : Number {
			return _bOffsetY;
		}

		public function set bOffsetY(value : Number) : void {
			isDirty = true;
			shader.data.bOffsetY.value = [value];
			_bOffsetY = value;
		}

		/*******************************************************/

		public function get rWaveFrequency() : Number {
			return _rWaveFrequency;
		}

		public function set rWaveFrequency(value : Number) : void {
			isDirty = true;
			shader.data.rWaveFrequency.value = [value];
			_rWaveFrequency = value;
		}

		/*******************************************************/

		public function get rWaveAmplitude() : Number {
			return _rWaveAmplitude;
		}

		public function set rWaveAmplitude(value : Number) : void {
			isDirty = true;
			shader.data.rWaveAmplitude.value = [value];
			_rWaveAmplitude = value;
		}

		/*******************************************************/

		public function get gWaveFrequency() : Number {
			return _gWaveFrequency;
		}

		public function set gWaveFrequency(value : Number) : void {
			isDirty = true;
			shader.data.gWaveFrequency.value = [value];
			_gWaveFrequency = value;
		}

		/*******************************************************/

		public function get gWaveAmplitude() : Number {
			return _gWaveAmplitude;
		}

		public function set gWaveAmplitude(value : Number) : void {
			isDirty = true;
			shader.data.gWaveAmplitude.value = [value];
			_gWaveAmplitude = value;
		}

		/*******************************************************/

		public function get bWaveFrequency() : Number {
			return _bWaveFrequency;
		}

		public function set bWaveFrequency(value : Number) : void {
			isDirty = true;
			shader.data.bWaveFrequency.value = [value];
			_bWaveFrequency = value;
		}

		/*******************************************************/

		public function get bWaveAmplitude() : Number {
			return _bWaveAmplitude;
		}

		public function set bWaveAmplitude(value : Number) : void {
			isDirty = true;
			shader.data.bWaveAmplitude.value = [value];
			_bWaveAmplitude = value;
		}
		
		
	}
}
