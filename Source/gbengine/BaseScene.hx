package gbengine;

import openfl.display.Sprite;

class BaseScene extends Sprite implements IScene {
	public function new() {
		super();
	}

	public function show():Void {}

	public function destroy():Void {}

	public function update(dt:Int):Void {}
}
