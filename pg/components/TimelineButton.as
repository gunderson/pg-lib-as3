package pg.components {
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import com.greensock.TweenMax;
	import pg.components.BasicButton;

	/**
	 * @author patrickgunderson
	 */
	public class TimelineButton extends BasicButton {
		public function TimelineButton() {
			super();
			if (numChildren > 0) {
				assets = this;
				setStage();
				setListeners();
			}
		}

		override protected function setStage() : void {
			var ttt : Number = tweenTime;
			tweenTime = 0;
			state = BasicButton.UP;
			tweenTime = ttt;
			assets.mouseChildren = false;
			assets.buttonMode = true;
		}
		
		override public function set state(f_state : int) : void {
			switch (f_state) {
				case BasicButton.UP:
					if (containsLabel("up")) assets.gotoAndPlay("up");
					break;
				case BasicButton.DOWN:
					if (containsLabel("down")) assets.gotoAndPlay("down");
					break;
				case BasicButton.IN:
					// Intentional fall through to OVER state
					// could be made into its own state if required but doubling up on the over state for now.
					TweenMax.delayedCall(tweenTime * 0.3, function() : void {
						state = BasicButton.UP;
					});
				case BasicButton.OVER:
					if (containsLabel("over")) assets.gotoAndPlay("over");
					break;
				case BasicButton.ERROR:
					
					if (containsLabel("error")) assets.gotoAndPlay("error");
					break;
				case BasicButton.DEACTIVATED:
					if (containsLabel("deactivated")) assets.gotoAndPlay("deactivated");
					break;
			}
			_state = f_state;
		}

		override public function set assets(assets : MovieClip) : void {
			_assets = assets; 
			//addChild(assets)
			setStage();
			setListeners();
		}
		
		public function containsLabel(name:String):Boolean{
			var containsLabel:Boolean = false;
			var labels:Array = assets.currentLabels;
			
			var label:FrameLabel
			for (var i:uint = 0; i < labels.length; i++) {
			    label = labels[i];
			    if (label.name == name) {
					containsLabel = true;
					break;
				}
			}
			return containsLabel;
		}
	}
}
