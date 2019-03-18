package gbengine;

import haxe.Constraints.Function;

interface ITransition {
	public function cover(callback:Function):Void;
	public function uncover(callback:Function):Void;
	public function update(dt:Int):Void;
}
