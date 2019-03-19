package;

import openfl.display.Sprite;
import gbengine.Manager;
import scenes.IntroScene;
import scenes.ControlSetupScene;

class Main extends Sprite {
	public function new() {
		super();
		// Manager.changeScene(IntroScene);
		Manager.changeScene(ControlSetupScene);
	}
}
