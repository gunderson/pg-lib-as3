package pg.utils {
	import com.demonsters.debugger.MonsterDebugger;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	/**
	 * @author patrickgunderson
	 */
	public class ObjectUtils {
		public static function getChildrenOf(container:DisplayObjectContainer):Array{
			var children:Array = [];
			MonsterDebugger.trace(ObjectUtils, container.numChildren);
			for (var i:uint = 0; i < container.numChildren; i++){
				children.push( container.getChildAt(i) );
			}
			return children;
		}
		
		public static function containsLabel(mc:MovieClip, name:String):Boolean{
			var containsLabel:Boolean = false;
			var labels:Array = mc.currentLabels;
			
			var label:FrameLabel;
			for (var i:uint = 0; i < labels.length; i++) {
			    label = labels[i];
			    if (label.name == name) {
					containsLabel = true;
					break;
				}
			}
			return containsLabel;
		}
		
		public static function clone(object:Object):Object{
			return ObjectUtils.extend({}, object);
		}
		
		public static function extend(toObject:Object, ...rest):Object{
			var i:int = 0, 
				endi = arguments.length;
				fromObject:Object;
			while (++i < endi){
				fromObject = arguments[i];
				for (var prop:* in fromObject){
					toObject[prop] = fromObject[prop];
				}
			}
			return toObject;
		}
		
		public static function moveRegistrationPointBy(container:DisplayObjectContainer, x:Number, y:Number):void{
			container.x += x;
			container.y += y;
			var i:int = -1;
			var endi:int = container.numChildren;
			var child:DisplayObject;
			while (++i < endi){
				child = container.getChildAt(i);
				child.x -= x;
				child.y -= y;
			}
		}
		
		public function centerWitin(container:DisplayObjectContainer, child:DisplayObject, centerX:Boolean = true, centerY:Boolean = true):void{
			var childIndex:int = container.numChildren - 1;
			if (container.contains(child)){
				childIndex = container.getChildIndex(child);
				container.removeChild(child);
			}
			var bounds:Rectangle = new Rectangle(container.x, container.y, container.width, container.height);
		}
	}
}
