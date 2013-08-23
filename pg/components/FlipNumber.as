package pg.components {
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	/**
	 * @author patrickgunderson
	 */
	public class FlipNumber extends Sprite{
		public var prevDigitTop:MovieClip;
		public var prevDigitBottom:MovieClip;
		public var newDigitTop:MovieClip;
		public var newDigitBottom:MovieClip;
		private var _assets:MovieClip;
		
		private var currentCharacter:String = " ";
		private var newCharacter : String = " ";
		private var _animationRunning : Boolean;
		
		protected var startRotationTop : Number = 25;
		protected var endRotationBottom : Number = -25;
		
		
		public function FlipNumber():void{
		}

		private function setListeners() : void {
		}

		private function setStage() : void {
		}

		public function get assets() : MovieClip {
			return _assets;
		}
		
		public function changeDisplay(newChar:String, oldChar : String):void{
			changeDisplayChars(newChar, oldChar)
			resetPositions()
			startAnimation();
		}

		private function changeDisplayChars(newChar : String, oldChar : String) : void {
			currentCharacter = newChar;
			prevDigitTop.charDisplay.text = oldChar;
			prevDigitBottom.charDisplay.text = oldChar;
			newDigitTop.charDisplay.text = newChar;
			newDigitBottom.charDisplay.text = newChar;
		}

		private function resetPositions() : void {
			prevDigitTop.rotationX = startRotationTop;
			newDigitBottom.rotationX = -90;
			TweenMax.to(prevDigitTop, 0, {
				colorMatrixFilter:{brightness:1}, 
				dropShadowFilter:{color:0x000000, alpha:.5, blurX:8, blurY:8, distance:2, angle:-90}
			})
			TweenMax.to(newDigitBottom, 0, {
				colorMatrixFilter:{brightness:1.5}, 
				dropShadowFilter:{color:0x000000, alpha:.5, blurX:8, blurY:8, distance:3, angle:90}
			})
			prevDigitTop.visible = true;
			newDigitBottom.visible = false;
			
			
			TweenMax.to(newDigitTop, 0, {
				rotationX: startRotationTop,
				dropShadowFilter:{color:0x000000, alpha:.5, blurX:8, blurY:8, distance:2, angle:-90}
			})
			TweenMax.to(prevDigitBottom, 0, {
				rotationX: endRotationBottom, 
				dropShadowFilter:{color:0x000000, alpha:.5, blurX:8, blurY:8, distance:3, angle:90}
			})
		}

		private function startAnimation() : void {
			_animationRunning = true;
			TweenMax.to(prevDigitTop, .15, {
				rotationX:90, 
				colorMatrixFilter:{brightness:.3}, 
				dropShadowFilter:{color:0x000000, alpha:.5, blurX:8, blurY:8, distance:12, angle:-90}, 
				onComplete:function():void{
					prevDigitTop.visible = false;
					newDigitBottom.visible = true;
					TweenMax.to(newDigitBottom, .15, {
						rotationX:endRotationBottom, 
						colorMatrixFilter:{brightness:1}, 
						dropShadowFilter:{color:0x000000, alpha:.5, blurX:8, blurY:8, distance:2, angle:90}, 
						onComplete:function():void{
							if (newCharacter != currentCharacter){
								changeDisplay(newCharacter, currentCharacter)
							} else {
								_animationRunning = false;
							
								TweenMax.to(prevDigitBottom, 0, {
									dropShadowFilter:{alpha:0}
								})
							}
						}
					})
				}
			})
		}
		
		public function set displayCharacter(displayCharacter:String):void{
			if (_animationRunning){
				//will re-run animation on complete when chars don't match
				newCharacter = displayCharacter;
			} else if(displayCharacter != currentCharacter){
				newCharacter = displayCharacter;
				changeDisplay(displayCharacter, currentCharacter);
			}
		}

		public function set assets(assets : MovieClip) : void {
			_assets = assets;
		
			setLocalAsset(_assets.prevDigitTop, "prevDigitTop")
			setLocalAsset(_assets.prevDigitBottom, "prevDigitBottom")
			setLocalAsset(_assets.newDigitTop, "newDigitTop")
			setLocalAsset(_assets.newDigitBottom, "newDigitBottom");

			//addChild(assets)
			setStage();
			setListeners();
		}
		
		public function setLocalAsset(externalAsset:MovieClip = null, localName:String = ""):void{
			if (externalAsset) {
				this[localName] = externalAsset;
			} else {
				this[localName] = new MovieClip();
			}
		}
		
		
	}
}
