package pg.filters {
	/**
	 * @author patrickgunderson
	 */
	public class GNoiseFilterParams {
		public var xStartValue:Number = 0;
		public var yStartValue:Number = 0;
		
		public var wavelengthX0:Number = 3;
		public var wavelengthY0:Number = 5;
		public var periodX0:Number = 0.1;
		public var periodY0:Number = 0.1;
		
		public var wavelengthX1:Number = 1;
		public var wavelengthY1:Number = 7;
		public var periodX1:Number = 0.4423;
		public var periodY1:Number = 0.3220;
		
		public var wavelengthX2:Number = 6;
		public var wavelengthY2:Number = 8;
		public var periodX2:Number = 0.0332;
		public var periodY2:Number = 0.0332;
		
		public var whiteLevel:Number = 1;
		public var blackLevel:Number = 0;
	}	
}
