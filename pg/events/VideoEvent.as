package pg.events {
	import flash.events.Event;
	/**
	 * @author patrickgunderson
	 */
	public class VideoEvent extends Event {
		public static const TIMECODE:String = "TIMECODE";
		public static const BUFFERING:String = "BUFFERING";
		public static const BUFFER_FULL:String = "BUFFER_FULL";
		public static const PLAY:String = "PLAY";
		public static const PLAYING:String = "PLAYING";
		public static const PAUSE:String = "PAUSE";
		public static const COMPLETE:String = "COMPLETE";
		public static const TOGGLE_PLAY_PAUSE:String = "TOGGLE_PLAY_PAUSE";
		public static const READY : String = "READY";
		public static const META_DATA : String = "META_DATA";
	
		public var timecode:Number = 0;
		public var data:Object = {};
		public function VideoEvent(type : String, timecode:Number = 0, bubbles : Boolean = false, cancelable : Boolean = false) {
			this.timecode = timecode;
			super(type, bubbles, cancelable);
		}
	}
}
