package gbengine;

import openfl.display.Sprite;
import haxe.Constraints.Function;

class BaseTransition extends Sprite implements ITransition {
	public function new() {
		super();
	}

	public function cover(callback:Function):Void {
		callback();
	}

	public function uncover(callback:Function):Void {
		callback();
	}

	public function update(dt:Int):Void {}
}
