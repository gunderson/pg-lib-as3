package pg.components {
	import pg.utils.ObjectUtils;
	import flash.display.MovieClip;

	/**
	 * @author patrickgunderson
	 */
	public class IconButton extends BasicButton {
		public var icon:MovieClip;
		
		public function IconButton() {
			super();
			
		}
		
		override public function set state(f_state:int):void{
			switch (f_state){
				case BasicButton.UP:
					if (state == BasicButton.DOWN){
						if (ObjectUtils.containsLabel(icon, "RELEASE")) icon.gotoAndPlay("RELEASE");
					} else {
						if (ObjectUtils.containsLabel(icon, "OUT")) icon.gotoAndPlay("OUT");
					}
					break;
				case BasicButton.DOWN:
					if (ObjectUtils.containsLabel(icon, "DOWN")) icon.gotoAndPlay("DOWN");
					break;
				case BasicButton.OVER:
					if (ObjectUtils.containsLabel(icon, "OVER")) icon.gotoAndPlay("OVER");
					break;
				case BasicButton.ERROR:
					if (ObjectUtils.containsLabel(icon, "ERROR")) icon.gotoAndPlay("ERROR");
					break;
				case BasicButton.DEACTIVATED:
					if (ObjectUtils.containsLabel(icon, "DEACTIVATED")) icon.gotoAndPlay("DEACTIVATED");
					break;
			}
			super.state = f_state;
		}

		override public function set assets(assets : MovieClip) : void {
			_assets = assets;
			setLocalAsset(_assets.icon, "icon");
			super.assets = assets;
		}

		override public function set status(status : int) : void {
			if (status == 1){
				if (ObjectUtils.containsLabel(icon, "ON")) icon.gotoAndPlay("ON")
			} else if (status == 0) {
				if (ObjectUtils.containsLabel(icon, "OFF")) icon.gotoAndPlay("OFF")
			}
			trace("IconButton status = " + status)
			super.status = status;
		}
	}
}
