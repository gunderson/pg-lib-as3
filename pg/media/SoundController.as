package pg.media {
	import flash.media.SoundTransform;
	import com.demonsters.debugger.MonsterDebugger;
	import flash.net.NetStream;
	import com.greensock.TweenMax;
	import com.greensock.loading.MP3Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	/**
	 * @author patrickgunderson
	 */
	
	public class SoundController extends EventDispatcher {
		private static var _instance : SoundController;
		private static const FADE_SPEED : Number = 0.6;
		public static const FADE_VOLUME : Number = 0.5;
		public static var muted:Boolean = false;
		private var _loadedSounds : Array = [];
		private var _channels:Array;
		private var _volume : Number = 1;
		private var _prevVolume:Number = 0;
		public function SoundController() {
			_loadedSounds = [];
			_channels = [];
		}
		
		public static function mute():void{
			_instance._prevVolume = volume;
			volume = 0;
			SoundController.muted = true;
		}
		
		public static function unmute():void{
			volume = _instance._prevVolume;
			SoundController.muted = false;
		}
		
		public static function toggleMute():void{
			MonsterDebugger.trace(instance, instance.channels)
			SoundController.muted = !SoundController.muted;
			if (SoundController.muted){
				SoundController.mute();
			} else {
				SoundController.unmute();
			}
		}
		
		public static function playSound(soundId:String):void{
			instance.playSound(soundId);
		}
		
		public static function stopSound(soundId:String):void{
			instance.stopSound(soundId);
		}
		
		public static function fadeIn(soundId:String):void{
			instance.fadeIn(soundId);
		}
		
		public static function fadeOut(soundId:String):void{
			instance.fadeOut(soundId);
		}
		
		public static function addChannel(channel:SoundChannel, soundId:String):void{
			instance.addChannel(channel, soundId);
		}
		
		public static function addNetStrem(channel:NetStream, soundId:String):void{
			instance.addChannel(channel, soundId);
		}
		
		public static function removeChannel(soundId:String):void{
			instance.removeChannel(soundId);
		}
		
		public function removeChannel(soundId:String):void{
			var index:Number = _channels.indexOf(soundId)
			if (index > -1) {
				_channels.splice(index, 1);
			} else {
				trace ( "No sound named " + soundId );
			}
		}
		
		public function playSound(soundId:String):void{
			//check loadedSounds for a sound at loadedSounds[soundId]
			if (_loadedSounds[soundId]){
				MP3Loader(_loadedSounds[soundId]).volume = volume;
				MP3Loader(_loadedSounds[soundId]).gotoSoundTime(0,false)
				_channels[soundId] = MP3Loader(_loadedSounds[soundId]).playSound();
			} else {
				// not found 
			}
		}
		
		public function addChannel(channel:Object, soundId:String):void{
			//if (!_channels[soundId]){
				_channels[soundId] = channel;
				channel.soundTransform = new SoundTransform(volume);
			//}
		}
		
		public function stopSound(soundId:String):void
		{
			//check loadedSounds for a sound at loadedSounds[soundId]
			if (_loadedSounds[soundId]){
				MP3Loader(_loadedSounds[soundId]).gotoSoundTime(0,false)
				_channels[soundId] = MP3Loader(_loadedSounds[soundId]).pauseSound();
			} else {
				// not found 
			}
		}
		
		
		public function fadeIn(soundId:String):void
		{
			if (!_channels[soundId]){
				playSound(soundId);
			} 
			MP3Loader(_loadedSounds[soundId]).volume = 0;
			if (_loadedSounds[soundId].channel){
				TweenMax.to(_loadedSounds[soundId].channel,FADE_SPEED,{volume:1});
			} 
		}
		
		public function fadeOut(soundId:String):void
		{
			//MP3Loader(_loadedSounds[soundId]).volume = volume;
			if (_channels[soundId]){
				MonsterDebugger.trace(this, "fadeOut " + soundId)
				TweenMax.to(_channels[soundId],FADE_SPEED,{volume:0,
					onComplete:function():void{
						stopSound(soundId);
					}
				});
			} else {
				// not found 
			}
		}

		public static function addSound(sound:MP3Loader, id:String):void{
			trace("adding sound:"+id);
			instance.loadedSounds[id] = sound;
		}
		
		public static function get instance() : SoundController{
			if (!_instance) {
				_instance = new SoundController();
			}
			return _instance;
		}

		public static function get volume() : Number {
			return SoundController.instance.volume;
		}

		public static function set volume(volume : Number) : void {
			instance.dispatchEvent(new Event(Event.CHANGE));
			SoundController.instance.volume = volume;
		}

		public function get volume() : Number {
			return _volume;
		}

		public function set volume(volume : Number) : void {
			_volume = volume;
			for (var i:* in instance.loadedSounds){
				if (instance.loadedSounds[i].volume){
					instance.loadedSounds[i].volume = volume;
				}
			}
		}

		public function get loadedSounds() : Array {
			return _loadedSounds;
		}

		public function set loadedSounds(loadedSounds : Array) : void {
			_loadedSounds = loadedSounds;
		}

		public function get channels() : Array {
			return _channels;
		}

		public function set channels(channels : Array) : void {
			_channels = channels;
		}
	}
}
