package pg.components {
	import flash.display.Graphics;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import com.greensock.TweenMax;
//	import pg.media.SoundController;
	import com.demonsters.debugger.MonsterDebugger;
	import pg.events.VideoEvent;

	import global.Model;

	import flash.events.SecurityErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.Event;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.media.Video;
	import flash.display.Sprite;

	/**
	 * @author patrickgunderson
	 */
	public class VideoPlayer extends Sprite {
		public var vid : Video;
		private var ns : NetStream;
		private var nc : NetConnection;
		private var client : CustomClient = new CustomClient();
		private var _active : Boolean = false;
		private var _videoUrl : String;
		private var _ready:Boolean = false;
		private var _tempActive:Boolean = false;
		private var _playing:Boolean = false;
		private var _wasPlaying:Boolean = false;
		private var _loop:int = 0; //-1 for infinite loop
		
		private var _prevTime : Number = 0;
		private var _duration : Number = 0;
		private var _still:Bitmap;

		public function VideoPlayer(videoUrl : String = "") : void {
			_videoUrl = videoUrl;
			addEventListener(Event.ADDED_TO_STAGE, onAdded)
			vid = new Video();
			_still = new Bitmap(
				new BitmapData(
					Model.videoData["width"], 
					Model.videoData["height"],
					false,
					0
				)
			);
			_still.visible = false;
			addChild(_still);
			addChild(vid);
		}

		private function onAdded(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded)
			setStage();
			setListeners();
		}

		private function setStage() : void {
			vid.smoothing = true;
			vid.width = Model.videoData["width"];
			vid.height = Model.videoData["height"];
			setupVideo();
		}

		private function setListeners() : void {
			// stage.addEventListener(Event.ENTER_FRAME, pollAndDispatchTime);
			//addEventListener(VideoEvent.COMPLETE, handleVideoComplete);
		}

		private function handleVideoComplete(event : VideoEvent = null) : void {
			
			//MonsterDebugger.trace(this, "loop!")
			if (_loop > 0){
				_loop--;
				ns.seek(0);	
				//ns.resume();
			} else if (_loop === -1){
				ns.seek(0);
				//ns.resume();
			}
		}

		public function get bytesLoaded() : Number {
			if (ns){
				return ns.bytesLoaded;
			} else {
				return 0;
			}
		}
		public function get bytesTotal() : Number {
			if (ns){
				return ns.bytesTotal;
			} else {
				return 0;
			}
		}
		public function get duration() : Number {
			if (_duration){
				return _duration;
			} else {
				return 90;
			}
		}

		public function replay():void{
			active = true;
			prevTime = 0;
			ns.seek(0);
			ns.resume();
			//play()
		}
		
		public function queue(videoUrl:String = null) : void {
			if (videoUrl){
				_videoUrl = videoUrl;	
			}
			_ready = false;
			addEventListener(VideoEvent.PLAY, handleVideoQueued);
			ns.play(_videoUrl);
//			SoundController.addNetStrem(ns, _videoUrl)
		}

		private function handleVideoQueued(event : VideoEvent) : void {
			removeEventListener(VideoEvent.PLAY, handleVideoQueued);
			dispatchEvent(new VideoEvent(VideoEvent.READY))
			pause();
		}

		public function play(videoUrl:String = null) : void {
			if (videoUrl){
				_videoUrl = videoUrl;	
			}
			_playing = true;
			//MonsterDebugger.trace(this, 'ns.play')
			ns.play(_videoUrl);
//			SoundController.addNetStrem(ns, _videoUrl)
			ns.seek(0);
		}

		private function togglePlayPause(e : Event) : void {
			ns.togglePause();
		}

		public function pause() : void {
			if (ns) ns.pause();
			//recordStill();
			//showStill();
			//dispatchEvent(new VideoEvent(VideoEvent.PAUSE))
			_playing = false;
		}

		public function resume() : void {
			ns.resume();
			//hideStill();
			_playing = true;
			dispatchEvent(new VideoEvent(VideoEvent.PLAY))
		}
		
		public function seek(time:Number):void{
			ns.seek(time);
			prevTime = time;
		}
		
		public function close():void{
//			SoundController.removeChannel(_videoUrl);
			ns.close();
			vid.clear();
			_playing = false;
			//MonsterDebugger.trace(this, 'ns.close')
		}

		private function setupVideo() : void {
			nc = new NetConnection();
			nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			nc.connect(null);
		}

		private function netStatusHandler(event : NetStatusEvent) : void {
			switch (event.info['code']) {
				case "NetConnection.Connect.Success":
					connectStream();
					break;
				case "NetStream.Play.StreamNotFound":
				//	MonsterDebugger.trace(this, "Stream not found: " + videoUrl);
					break;
				case "NetStream.Buffer.Empty":
				//	MonsterDebugger.trace(this, "NetStream.Buffer.Empty");
					dispatchEvent(new VideoEvent(VideoEvent.BUFFERING))
					break;
				case "NetStream.Buffer.Full":
				//	MonsterDebugger.trace(this, "NetStream.Buffer.Full");
					dispatchEvent(new VideoEvent(VideoEvent.BUFFER_FULL))
					break;
				case "NetStream.Play.Stop":
				//	MonsterDebugger.trace(this, "stream complete");
					dispatchEvent(new VideoEvent(VideoEvent.COMPLETE))
					_playing = false;
					handleVideoComplete();
					break;
				case "NetStream.Play.Start":
				//	MonsterDebugger.trace(this, "NetStream.Play.Start");
					_ready = true;
					dispatchEvent(new VideoEvent(VideoEvent.PLAY))
					break;
				case "NetStream.Seek.Notify":
				//	MonsterDebugger.trace(this, "NetStream.Seek.Notify " + prevTime + " " + time);
					//hack to give netstream a moment to update time before resync with prevtime
					TweenMax.delayedCall(0.01, function():void{prevTime = time});
			}
		}

		private function recordStill() : void {
			_still.bitmapData.draw(vid);
		}
		
		private function showStill():void{
			_still.visible = true;
			vid.visible = false;
		}
		
		private function hideStill():void{
			_still.visible = false;
			vid.visible = true;
		}

		private function securityErrorHandler(event : SecurityErrorEvent) : void {
			trace("securityErrorHandler: " + event);
		}

		private function connectStream() : void {
			//MonsterDebugger.trace(this, "connectStream")
			ns = new NetStream(nc);
			ns.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			ns.client = client;
			client.addEventListener(VideoEvent.META_DATA, handleMetaData);
			vid.attachNetStream(ns);
			ready = true;
		}

		private function handleMetaData(event : VideoEvent) : void {
			_duration = event.data['duration'];
			dispatchEvent(event);
		}

		private function pollAndDispatchTime(event : Event) : void {
			var e : VideoEvent = new VideoEvent(VideoEvent.TIMECODE, ns.time)
			dispatchEvent(e);
		}

		public function get active() : Boolean {
			return _active;
		}

		public function set active(active : Boolean) : void {
			_active = active;
			if (active) {
				parent.addEventListener(VideoEvent.TOGGLE_PLAY_PAUSE, togglePlayPause, false, 0, true);
			} else {
				parent.removeEventListener(VideoEvent.TOGGLE_PLAY_PAUSE, togglePlayPause);
			}
		}
		
		public function get timeRemaining():Number{
			return _duration - ns.time;
		}

		public function get videoUrl() : String {
			return _videoUrl;
		}

		public function set videoUrl(videoUrl : String) : void {
			_videoUrl = videoUrl;
		}

		public function get time() : Number {
			return ns.time;
		}

		public function get ready() : Boolean {
			return _ready;
		}

		public function set ready(ready : Boolean) : void {
			_ready = ready;
		}

		public function get tempActive() : Boolean {
			return _tempActive;
		}

		public function set tempActive(tempActive : Boolean) : void {
			_tempActive = tempActive;
		}

		public function get playing() : Boolean {
			return _playing;
		}

		public function set playing(playing : Boolean) : void {
			_playing = playing;
		}

		public function get wasPlaying() : Boolean {
			return _wasPlaying;
		}

		public function set wasPlaying(wasPlaying : Boolean) : void {
			_wasPlaying = wasPlaying;
		}

		public function get prevTime() : Number {
			return _prevTime;
		}

		public function set prevTime(prevTime : Number) : void {
			_prevTime = prevTime;
		}

		public function get loop() : int {
			return _loop;
		}

		public function set loop(loop : int) : void {
			_loop = loop;
		}
	}
}
import com.demonsters.debugger.MonsterDebugger;
import flash.events.EventDispatcher;
import pg.events.VideoEvent;
class CustomClient extends EventDispatcher{
	public function onXMPData(info : Object) : void {
	}
	
	public function onPlayStatus(info : Object) : void {
	}

	public function onMetaData(info : Object) : void {
		MonsterDebugger.trace(this, "metadata: duration=" + info['duration'] + " width=" + info['width'] + " height=" + info['height'] + " framerate=" + info['framerate']);
		var event:VideoEvent = new VideoEvent(VideoEvent.META_DATA)
		event.data = info;
		dispatchEvent(event);
	}

	public function onCuePoint(info : Object) : void {
		trace("cuepoint: time=" + info['time'] + " name=" + info['name'] + " type=" + info['type']);
	}
}