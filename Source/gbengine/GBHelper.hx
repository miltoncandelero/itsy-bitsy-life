package gbengine;

import lime.math.RGBA;
import lime.math.ARGB;
import openfl.display.BitmapData;
import openfl.text.TextFormat;
import openfl.Assets;

class GBHelper {
	public static var PALLETE:Array<Int> = [0x9bbc0f, 0x8bac0f, 0x306230, 0x0f380f];
	public static var FORMAT_04B03(get, never):TextFormat;

	private static function get_FORMAT_04B03():TextFormat {
		return new TextFormat("04b03", 8);
	}

	/**
	 * Not working yet.
	 * @param id
	 * @return BitmapData
	 */
	public static function getBitmapData(id:String):BitmapData {
		var aux = Assets.getBitmapData(id).clone();
		aux.lock();
		var palleteIntensity = PALLETE.map(function(c) {
			return colorBrightness(new ARGB(c));
		});
		for (i in 0...aux.width) {
			for (j in 0...aux.height) {
				var c = new ARGB(aux.getPixel32(i, j));
				if (c.a != 0xFF)
					continue;
				var min:Float = 1;
				var selected = 0;
				for (j in 0...palleteIntensity.length) {
					if (Math.abs(palleteIntensity[j] - colorBrightness(c)) < min) {
						min = Math.abs(palleteIntensity[j] - colorBrightness(c));
						selected = j;
					}
				}
				aux.setPixel(i, j, (PALLETE[3 - Math.round(colorBrightness(c) * (PALLETE.length - 1))]));
				// aux.setPixel(i, j, (PALLETE[j]));
			}
		}
		aux.unlock();
		return aux;
	}

	private static inline function colorBrightness(c:ARGB):Float {
		// stackoverflow's guide to the brightness of a color
		return ((c.r << 1 + c.r + c.g << 2 + c.b) >> 3);
		// return 0.299 * c.r + 0.587 * c.g + 0.114 * c.b;
	}

	private function new() {}
}
