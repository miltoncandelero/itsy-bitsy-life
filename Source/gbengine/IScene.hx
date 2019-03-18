package gbengine;

interface IScene {
	public function show():Void;
	public function destroy():Void;
	public function update(dt:Int):Void;
}
