package pg.utils {
	import flash.geom.Rectangle;
	import flash.geom.Point;
	/**
	 * @author patrickgunderson
	 */
	public class MathUtils {
		public static const THE_ORIGIN:Point = new Point();
		public static const RECT:Rectangle = new Rectangle();
		public static const TWO_PI:Number = Math.PI * 2;
		public static const IDENTITY_MATRIX:Array = new Array(	1,0,0,0,0,
																0,1,0,0,0,
																0,0,1,0,0,
																0,0,0,1,0);

		public static function deg2rad(value:Number):Number{
			return Math.PI * value / 180;
		}
		
		public static function rad2deg(value:Number):Number{
			return 180 * value / Math.PI;
		}
		
		public static function tolerance(number:Number, targetNumber:Number, tolerance:Number):Boolean{
			return Math.abs(number - targetNumber) <= tolerance;
		}
		
		public static function roundTo(number:Number, nearest:Number):Number{
			return Math.round(number / nearest) * nearest;
		}
		
		public static function random(min:Number, max:Number, integer:Boolean = false):Number{
			var range:Number = max - min;
			var number:Number = (Math.random() * range) + min;
			if (integer){
				return Math.round(number);
			} else {
				return number;
			}
		}
	}
}
