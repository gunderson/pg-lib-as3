package pg.analytics {
	import flash.external.ExternalInterface;
	/**
	 * @author patrickgunderson
	 */
	public class GA {
		protected static var _instance : GA;
		
		public function GA(){
			
		}
		
		/*-----------------------------------------------------------*/
		
		public static function get instance() : GA {
			if (!_instance) {
				_instance = new GA();
			}
			return _instance;
		}
		
		/*-----------------------------------------------------------*/
		
		public static function trackPage(...args):void{
			if (ExternalInterface.available) ExternalInterface.call("trackPageView", args);
		}
		
		/*-----------------------------------------------------------*/
		
		public static function trackEvent(...args):void{
			if (ExternalInterface.available) ExternalInterface.call("trackEvent", args);
		}
	}
}
