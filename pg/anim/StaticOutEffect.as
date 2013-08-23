package pg.anim {
	import flash.system.System;
	import com.greensock.TweenLite;

	import org.osflash.signals.Signal;

	import flash.display.Bitmap;
	import flash.display.Shader;
	import flash.filters.ShaderFilter;

	/**
	 * @author patrickgunderson
	 */
	public class StaticOutEffect {
		[Embed(source="../filters/pb/separateRGB.pbj", mimeType="application/octet-stream")]
		private static var RGBSeparator : Class;
		private var shader : Shader;
		private var filter : ShaderFilter;
		public var tl : Sequence;
		private var _target : Bitmap;
		public var complete : Signal

		public function StaticOutEffect(target : Bitmap, sequenceId:int = -1) {
			_target = target;
			complete = new Signal();
			shader = new Shader(new RGBSeparator());
			filter = new ShaderFilter(shader);

			tl = new Sequence();
			if (sequenceId == -1) sequenceId = Math.floor(Math.random() * 2);
			
			//FORCE SEQUENCE1
			//this["makeSequence" + sequenceId]();
			makeSequence1();
			
			tl.callback = function() : void {
				//trace("StaticOutEffect.close(0)");
				TweenLite.to(_target, .1, {alpha:0, onComplete:function():void {
						//trace("StaticOutEffect.close(1)");
						shader = null;
						_target.bitmapData.dispose();
						//flash.system.System.gc();
						//flash.system.System.gc();
						complete.dispatch();
					}
				});
			}
		}

		public function play() : void {
			//trace("StaticOutEffect.play()");
			tl.start();
		}
		
		public function stop():void{
			tl.stop();
		}

		private function staticOn() : void {
			//trace("StaticOutEffect.staticOn(0)");
			// reapply shader to filter
			filter = new ShaderFilter(shader);
			// apply filter to object
			_target.filters = [filter];
			//trace("StaticOutEffect.staticOn(1)");
		}

		private function staticOff() : void {
			//trace("StaticOutEffect.staticOff(0)");
			_target.filters = [];
			
			//trace("StaticOutEffect.staticOff(1)");
		}
		
		private function makeSequence0():void{
			tl.append(function() : void {
				
				trace("StaticOutEffect.effect(0)");
				// update parameter in shader
				shader.data.rOffsetX.value = [20];
				shader.data.rOffsetY.value = [-10];
				shader.data.gOffsetX.value = [-10];
				shader.data.gOffsetY.value = [10];
				shader.data.bOffsetX.value = [-10];
				shader.data.bOffsetY.value = [10];
				shader.data.rWaveFrequency.value = [8];
				shader.data.rWaveAmplitude.value = [15];
				shader.data.gWaveFrequency.value = [5.1];
				shader.data.gWaveAmplitude.value = [15];
				shader.data.bWaveFrequency.value = [5.1];
				shader.data.bWaveAmplitude.value = [15];
				shader.data.rValue.value = [2];
				shader.data.gValue.value = [2];
				shader.data.bValue.value = [2];
				staticOn();
			}, 0);
			tl.append(function() : void {
				//trace("StaticOutEffect.effect(1)");
				staticOff();
			}, 0.02);
			tl.append(function() : void {
				//trace("StaticOutEffect.effect(2)");
				// update parameter in shader
				shader.data.rOffsetX.value = [10];
				shader.data.rOffsetY.value = [10];
				shader.data.gOffsetX.value = [-10];
				shader.data.gOffsetY.value = [-10];
				shader.data.bOffsetX.value = [-10];
				shader.data.bOffsetY.value = [-10];
				shader.data.rWaveFrequency.value = [14];
				shader.data.rWaveAmplitude.value = [20];
				shader.data.gWaveFrequency.value = [19];
				shader.data.gWaveAmplitude.value = [15];
				shader.data.bWaveFrequency.value = [19];
				shader.data.bWaveAmplitude.value = [15];
				staticOn();
			}, 0.05);
			tl.append(function() : void {
				//trace("StaticOutEffect.effect(3)");
				staticOff();
			}, .02);
			tl.append(function() : void {
				//trace("StaticOutEffect.effect(4)");
				// update parameter in shader
				shader.data.rOffsetX.value = [10];
				shader.data.rOffsetY.value = [-10];
				shader.data.gOffsetX.value = [0];
				shader.data.gOffsetY.value = [10];
				shader.data.bOffsetX.value = [-10];
				shader.data.bOffsetY.value = [0];
				shader.data.rWaveFrequency.value = [14 * Math.random()];
				shader.data.rWaveAmplitude.value = [15];
				shader.data.gWaveFrequency.value = [5.1];
				shader.data.gWaveAmplitude.value = [50];
				shader.data.bWaveFrequency.value = [5.1];
				shader.data.bWaveAmplitude.value = [50];
				staticOn();
			}, 0.03);
			tl.append(function() : void {
				//trace("StaticOutEffect.effect(5)");
				staticOff();
			}, 0.02);
			tl.append(function() : void {
				//trace("StaticOutEffect.effect(6)");
				// update parameter in shader
				shader.data.rOffsetX.value = [10];
				shader.data.rOffsetY.value = [15];
				shader.data.gOffsetX.value = [-10];
				shader.data.gOffsetY.value = [-10];
				shader.data.bOffsetX.value = [-10];
				shader.data.bOffsetY.value = [-10];
				shader.data.rWaveFrequency.value = [14 * Math.random()];
				shader.data.rWaveAmplitude.value = [20];
				shader.data.gWaveFrequency.value = [12];
				shader.data.gWaveAmplitude.value = [25];
				shader.data.bWaveFrequency.value = [12];
				shader.data.bWaveAmplitude.value = [25];
				staticOn();
			}, 0.02);
		}
		
		private function makeSequence1():void{
			tl.append(function() : void {
				//trace("StaticOutEffect.effect(2)");
				// update parameter in shader
				shader.data.rOffsetX.value = [10];
				shader.data.rOffsetY.value = [10];
				shader.data.gOffsetX.value = [-10];
				shader.data.gOffsetY.value = [-10];
				shader.data.bOffsetX.value = [-10];
				shader.data.bOffsetY.value = [-10];
				shader.data.rWaveFrequency.value = [14];
				shader.data.rWaveAmplitude.value = [20];
				shader.data.gWaveFrequency.value = [19];
				shader.data.gWaveAmplitude.value = [15];
				shader.data.bWaveFrequency.value = [19];
				shader.data.bWaveAmplitude.value = [15];
				staticOn();
			}, 0.00);
			tl.append(function() : void {
				//trace("StaticOutEffect.effect(3)");
				staticOff();
			}, .02);
			tl.append(function() : void {
				//trace("StaticOutEffect.effect(4)");
				// update parameter in shader
				shader.data.rOffsetX.value = [10];
				shader.data.rOffsetY.value = [-10];
				shader.data.gOffsetX.value = [0];
				shader.data.gOffsetY.value = [10];
				shader.data.bOffsetX.value = [-10];
				shader.data.bOffsetY.value = [0];
				shader.data.rWaveFrequency.value = [14 * Math.random()];
				shader.data.rWaveAmplitude.value = [15];
				shader.data.gWaveFrequency.value = [5.1];
				shader.data.gWaveAmplitude.value = [50];
				shader.data.bWaveFrequency.value = [5.1];
				shader.data.bWaveAmplitude.value = [50];
				staticOn();
			}, 0.06);
		}
	}
}
