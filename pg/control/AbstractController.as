package pg.control {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Sprite;
	/**
	 * @author patrickgunderson
	 */
	public class AbstractController extends MovieClip {
		protected var _assets : MovieClip;

		public function AbstractController() : void {
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		protected function onAdded(event:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			setStage();
			setListeners();
		}
		
		protected function setStage():void{
			onResize();
		}
		
		protected function setListeners():void{
			stage.addEventListener(Event.RESIZE, onResize);
		}
		
		public function onResize(event:Event = null):void{
		}
		
		public function get assets() : MovieClip {
			return _assets;
		}

		public function set assets(assets : MovieClip) : void {
			if (assets == this){
				_assets = assets;
				return;
			}
			if (_assets) removeChild(_assets);
			_assets = assets;
			addChild(_assets);
		}
	}
}