package;

import openfl.display.Sprite;
import gbengine.Manager;
import scenes.IntroScene;

class Main extends Sprite {
	public function new() {
		super();
		Manager.changeScene(IntroScene);
	}
}
