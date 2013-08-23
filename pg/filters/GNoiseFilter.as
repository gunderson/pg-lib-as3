package pg.filters {
	import flash.filters.ShaderFilter;
	import flash.display.Shader;
	/**
	 * @author patrickgunderson
	 */
	public class GNoiseFilter extends Object {
		
		[Embed(source="pb/GNoise.pbj", mimeType="application/octet-stream")]
		private static var Scanlines : Class;
		private var shader : Shader;
		private var _filter : ShaderFilter;
		private var isDirty: Boolean = true;
		
		private var _xStartValue:Number = 0;
		private var _yStartValue:Number = 0;
		
		private var _wavelengthX0:Number = 2;
		private var _wavelengthY0:Number = 5;
		private var _periodX0:Number = 0.01;
		private var _periodY0:Number = 0.01;
		
		private var _wavelengthX1:Number = 1;
		private var _wavelengthY1:Number = 7;
		private var _periodX1:Number = 0.001;
		private var _periodY1:Number = 0.001;
		
		private var _wavelengthX2:Number = 6;
		private var _wavelengthY2:Number = 8;
		private var _periodX2:Number = 0.0132;
		private var _periodY2:Number = 0.0132;
		
		private var _whiteLevel:Number = 1;
		private var _blackLevel:Number = 0;
		
		public function GNoiseFilter(params : GNoiseFilterParams = null) {
			
			shader = new Shader(new Scanlines());
			_filter = new ShaderFilter(shader);
			
			if (params){
				this.params = params;
			} else {
				this.params = new GNoiseFilterParams();
			}
		}
		
		public function set params(params : GNoiseFilterParams):void{
			if (params.xStartValue) 	xStartValue 	= params.xStartValue;
			if (params.yStartValue) 	yStartValue 	= params.yStartValue;
			
			if (params.wavelengthX0) 	wavelengthX0 	= params.wavelengthX0;
			if (params.wavelengthY0) 	wavelengthY0 	= params.wavelengthY0;
			if (params.periodX0) 		periodX0 		= params.periodX0;
			if (params.periodY0) 		periodY0 		= params.periodY0;
			
			if (params.wavelengthX1) 	wavelengthX1 	= params.wavelengthX1;
			if (params.wavelengthY1) 	wavelengthY1 	= params.wavelengthY1;
			if (params.periodX1) 		periodX1 		= params.periodX1;
			if (params.periodY1) 		periodY1 		= params.periodY1;
			
			if (params.wavelengthX2) 	wavelengthX2 	= params.wavelengthX2;
			if (params.wavelengthY2) 	wavelengthY2 	= params.wavelengthY2;
			if (params.periodX2) 		periodX2 		= params.periodX2;
			if (params.periodY2) 		periodY2 		= params.periodY2;
			
			if (params.whiteLevel) 		whiteLevel 	= params.whiteLevel;
			if (params.blackLevel) 		blackLevel 	= params.blackLevel;
		}
		
		public function get filter():ShaderFilter{
			if (isDirty){
				_filter = new ShaderFilter(shader);
				isDirty = false;
			}
			return _filter;
		}

		public function get xStartValue() : Number {
			return _xStartValue;
		}

		public function set xStartValue(xStartValue : Number) : void {
			isDirty = true;
			shader.data.xStartValue.value = [xStartValue];
			_xStartValue = xStartValue;
		}

		public function get yStartValue() : Number {
			return _yStartValue;
		}

		public function set yStartValue(yStartValue : Number) : void {
			isDirty = true;
			shader.data.yStartValue.value = [yStartValue];
			_yStartValue = yStartValue;
		}

		public function get wavelengthX0() : Number {
			return _wavelengthX0;
		}

		public function set wavelengthX0(wavelengthX0 : Number) : void {
			isDirty = true;
			shader.data.wavelengthX0.value = [wavelengthX0];
			_wavelengthX0 = wavelengthX0;
		}

		public function get wavelengthY0() : Number {
			return _wavelengthY0;
		}

		public function set wavelengthY0(wavelengthY0 : Number) : void {
			isDirty = true;
			shader.data.wavelengthY0.value = [wavelengthY0];
			_wavelengthY0 = wavelengthY0;
		}

		public function get periodX0() : Number {
			return _periodX0;
		}

		public function set periodX0(periodX0 : Number) : void {
			isDirty = true;
			shader.data.periodX0.value = [periodX0];
			_periodX0 = periodX0;
		}

		public function get periodY0() : Number {
			return _periodY0;
		}

		public function set periodY0(periodY0 : Number) : void {
			isDirty = true;
			shader.data.periodY0.value = [periodY0];
			_periodY0 = periodY0;
		}

		public function get wavelengthX1() : Number {
			return _wavelengthX1;
		}

		public function set wavelengthX1(wavelengthX1 : Number) : void {
			isDirty = true;
			shader.data.wavelengthX1.value = [wavelengthX1];
			_wavelengthX1 = wavelengthX1;
		}

		public function get wavelengthY1() : Number {
			return _wavelengthY1;
		}

		public function set wavelengthY1(wavelengthY1 : Number) : void {
			isDirty = true;
			shader.data.wavelengthY1.value = [wavelengthY1];
			_wavelengthY1 = wavelengthY1;
		}

		public function get periodX1() : Number {
			return _periodX1;
		}

		public function set periodX1(periodX1 : Number) : void {
			isDirty = true;
			shader.data.periodX1.value = [periodX1];
			_periodX1 = periodX1;
		}

		public function get periodY1() : Number {
			return _periodY1;
		}

		public function set periodY1(periodY1 : Number) : void {
			isDirty = true;
			shader.data.periodY1.value = [periodY1];
			_periodY1 = periodY1;
		}

		public function get wavelengthX2() : Number {
			return _wavelengthX2;
		}

		public function set wavelengthX2(wavelengthX2 : Number) : void {
			isDirty = true;
			shader.data.wavelengthX2.value = [wavelengthX2];
			_wavelengthX2 = wavelengthX2;
		}

		public function get wavelengthY2() : Number {
			return _wavelengthY2;
		}

		public function set wavelengthY2(wavelengthY2 : Number) : void {
			isDirty = true;
			shader.data.wavelengthY2.value = [wavelengthY2];
			_wavelengthY2 = wavelengthY2;
		}

		public function get periodX2() : Number {
			return _periodX2;
		}

		public function set periodX2(periodX2 : Number) : void {
			isDirty = true;
			shader.data.periodX2.value = [periodX2];
			_periodX2 = periodX2;
		}

		public function get periodY2() : Number {
			return _periodY2;
		}

		public function set periodY2(periodY2 : Number) : void {
			isDirty = true;
			shader.data.periodY2.value = [periodY2];
			_periodY2 = periodY2;
		}

		public function get whiteLevel() : Number {
			return _whiteLevel;
		}

		public function set whiteLevel(whiteLevel : Number) : void {
			isDirty = true;
			shader.data.whiteLevel.value = [whiteLevel];
			_whiteLevel = whiteLevel;
		}

		public function get blackLevel() : Number {
			return _blackLevel;
		}

		public function set blackLevel(blackLevel : Number) : void {
			isDirty = true;
			shader.data.blackLevel.value = [blackLevel];
			_blackLevel = blackLevel;
		}
		
	}
}
