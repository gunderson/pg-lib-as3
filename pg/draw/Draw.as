package pg.draw {
	import flash.geom.Point;
	import flash.display.Graphics;
	import flash.events.EventDispatcher;

	/**
	 * @author patrickgunderson
	 */
	public class Draw extends EventDispatcher {
		public static function drawGradientLine(graphics:Graphics, startPoint:Point, endPoint:Point, startColor:int, endColor:int, steps:int = 16):void{
			var segmentDx:Number = (endPoint.x - startPoint.x) / steps
			var segmentDy:Number = (endPoint.y - startPoint.y) / steps
			
			var i:int = -1;
			var endi:int = steps;
			while (++i < endi){
				with (graphics){
					beginFill(Draw.interpolateColor(startColor, endColor, i / (steps - 1)), 1);
					moveTo(
						startPoint.x + (segmentDx * i),
						startPoint.y + (segmentDy * i)
					);
					lineTo(
						startPoint.x + (segmentDx * (i + 1)),
						startPoint.y + (segmentDy * (i + 1))
					);
					lineTo(
						startPoint.x + (segmentDx * (i + 1)) + 1,
						startPoint.y + (segmentDy * (i + 1))
					);
					lineTo(
						startPoint.x + (segmentDx * i) + 1,
						startPoint.y + (segmentDy * i)
					);
					lineTo(
						startPoint.x + (segmentDx * i),
						startPoint.y + (segmentDy * i)
					);
					endFill();
				}
			}
		}
		
		public static function interpolateColor(startColor:int, endColor:int, position:Number):int{
			var r:int
			var g:int
			var b:int
			position = Math.min(Math.max(position, 0), 1);
			r = (startColor >> 16) + (((endColor >> 16) - (startColor >> 16)) * position);
			g = ((startColor >> 8) & 0xff) + ((((endColor >> 8) & 0xff) - ((startColor >> 8) & 0xff)) * position);
			b = (startColor & 0xff) + (((endColor & 0xff) - (startColor & 0xff)) * position);
			return (r << 16 | g << 8 | b)
		}
	}
}
