package pg
{
	import flash.geom.Point;
	import flash.display.IBitmapDrawable;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	public class Blit
	{
		public function Blit(){
		}
		
		public static function getBitmap(f_obj:DisplayObject, buffer:Number = 4, trim:Boolean = false, bitmapContainer:Bitmap = null):Bitmap{
			var container:DisplayObjectContainer;
			var bounds:Rectangle;
			var trimBox:Rectangle
			var trimmedBmd:BitmapData;
			var bm:Bitmap;
			
			if (bitmapContainer){
				bm = bitmapContainer;
			} else {
				bm = new Bitmap();
			}
			
			if (f_obj.parent){
				container = f_obj.parent;
				bounds = f_obj.getBounds(container);
			} else {
				container = new Sprite();
				container.addChild(f_obj);
				bounds = f_obj.getBounds(container);
				container.removeChild(f_obj);
				container = null; 
			}
			
			bounds.x -= buffer;
			bounds.y -= buffer;
			bounds.width += buffer << 1;
			bounds.height += buffer << 1;
			
//			if (f_obj.scrollRect){
//				bounds = f_obj.scrollRect;
//			}
			
			trace("New Blit! :: bounds = " + bounds.toString());
			try{
				var bmd:BitmapData = new BitmapData(bounds.width, bounds.height, true, 0);
				//var bmd:BitmapData = new BitmapData(bounds.width, bounds.height, false, 0xff00ff);
			} catch (e:Error){
				var newError:Error = new Error("BitmapData.width = " + bounds.width);
				throw newError;
			}
			
			
			var m:Matrix = new Matrix(f_obj.scaleX,0,0,f_obj.scaleY, -bounds.x + f_obj.x, -bounds.y + f_obj.y);
			bmd.draw(f_obj, m);
			if (trim){
				trimBox = bmd.getColorBoundsRect(0xff000000, 0x00000000, false);
			} else {
				trimBox = new Rectangle();
			}
			
			//trace("pg.Blit :: trimBox.width = " + trimBox.width + " :: trimBox.height = " + trimBox.height);
			if (trim && (trimBox.width > 0 || trimBox.height > 0)){
				trimmedBmd = new BitmapData(trimBox.width, trimBox.height, true, 0);
				trimmedBmd.copyPixels(bmd, trimBox, new Point());
				bmd.dispose();
				bm.bitmapData = trimmedBmd;
			} else {
				bm.bitmapData = bmd;
				trimBox.x = 0;
				trimBox.y = 0;
			}
			bm.x = bounds.x + trimBox.x;
			bm.y = bounds.y + trimBox.y;
			return bm;
		}
		
		public static function replaceChildWithBitmap(f_obj:DisplayObject, bitmapContainer:Bitmap = null):Bitmap{
			var bm:Bitmap;
			
			if (bitmapContainer){
				bm = bitmapContainer;
			} else {
				bm = new Bitmap();
			}
			
			var depth:int;
			var container:DisplayObjectContainer;
			if (f_obj.parent){
				bm = Blit.getBitmap(f_obj, 4, true, bm);
				container = f_obj.parent;
				depth = container.getChildIndex(f_obj);
				container.addChildAt(bm, depth);
				container.removeChild(f_obj);
			} else {
				throw new Error("Object is not a child.");
			}
			return bm;
		}
	}
}