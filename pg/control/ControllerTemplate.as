package pg.control {
	import flash.events.Event;
	/**
	 * @author patrickgunderson
	 */
	public class ControllerTemplate extends AbstractController {
		public function ControllerTemplate() : void {
			super();
		}
		
		override protected function setStage():void{
			super.setStage();
		}
		
		override protected function setListeners():void{
			super.setListeners();
		}
		
		override public function onResize(event:Event = null):void{
			
		}
	}
}