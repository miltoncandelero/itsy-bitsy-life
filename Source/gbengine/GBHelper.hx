package gbengine;

import openfl.text.TextFormat;

class GBHelper {
	public static var PALLETE:Array<Int> = [0x9bbc0f, 0x8bac0f, 0x306230, 0x0f380f];
	public static var FORMAT_04B03(get, never):TextFormat;

	private static function get_FORMAT_04B03():TextFormat {
		return new TextFormat("04b03", 8);
	}

	private function new() {}
}
