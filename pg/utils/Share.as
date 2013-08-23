package pg.utils
{
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.external.ExternalInterface;

	public class Share {
		
		public static var facebookAppID:String = "";
				
		static public function toFacebook(params:Object):void {
			/*
			  
			Share.facebookAppID = "";
			var params:Object = {};
			params.title = "La Mirada - Kahlua"
			params.link = "";
			params.picture = "";
			params.caption = "";
			params.description = "";
			params.redirect_uri = "";
			
			
			*/
			var variables:URLVariables = new URLVariables();
			variables.app_id = facebookAppID;
			variables.name = params.title || "Title"
			variables.link = params.link || "";
			variables.picture = params.picture || "";
			variables.caption = params.caption || "";
			variables.description = params.description || "";
			variables.redirect_uri = params.redirect_uri || "";
			
			var request:URLRequest = new URLRequest("http://www.facebook.com/dialog/feed");
			request.data = variables;
			request.method = URLRequestMethod.GET;
			navigateToURL(request,"_blank");
		}
		
		static public function toTwitter(params:Object):void {
			var variables:URLVariables = new URLVariables();
			variables.text = params.text || params.message || params.description || "Share me!"; 
			variables.url = params.link || params.url || "";
			var request:URLRequest = new URLRequest( "https://twitter.com/intent/tweet");
			request.data = variables;
			request.method = URLRequestMethod.GET;
			navigateToURL( request, "_blank" );
		}
		
		public static function postToFacebook(name:String, caption:String, message:String, url:String, picture:String):void{
			trace("Share.as :: postToFacebook() ", name, caption, message, url, picture)
			ExternalInterface.call("postToFacebook", name, caption, message, url, picture);
			
		}
		
		public static function postToTwitter(message:String, url:String):void{
			trace("Share.as :: postToTwitter() ", message, url)
			ExternalInterface.call("postToTwitter", message, url);
		}
	}
}