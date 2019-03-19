package scenes;

import openfl.display.CapsStyle;
import openfl.display.Sprite;
import openfl.ui.Keyboard;
import openfl.Lib;
import gbengine.Manager;
import gbengine.GBHelper;
import gbengine.BaseScene;
import gbengine.UserSettings;
import gbengine.TextLabel;

class ControlSetupScene extends BaseScene {
	var txtData:TextLabel;
	var arrow:TextLabel;

	public function new() {
		super();

		txtData = new TextLabel(true, true);
		txtData.text = printCurrentSettings();
		var tf = GBHelper.FORMAT_04B03;
		tf.size = 8;
		txtData.defaultTextFormat = tf;
		txtData.x = 16;
		addChild(txtData);

		arrow = new TextLabel(false, true);
		arrow.text = "->";
		arrow.defaultTextFormat = tf;
		arrow.cacheAsBitmap = true;
		arrow.y = txtData.y + 8 * tf.size;
		addChild(arrow);
	}

	override function update(dt:Int) {
		if (Manager.LEFT)
			arrow.x--;

		if (Manager.RIGHT)
			arrow.x++;

		if (Manager.UP)
			arrow.y--;

		if (Manager.DOWN)
			arrow.y++;

		if (Manager.A)
			trace(arrow.x + "," + arrow.y);
	}

	private function printCurrentSettings():String {
		var retval = "";

		retval += "UP: " + UserSettings.UP + "\n";
		retval += "DOWN: " + UserSettings.DOWN + "\n";
		retval += "LEFT: " + UserSettings.LEFT + "\n";
		retval += "RIGHT: " + UserSettings.RIGHT + "\n";
		retval += "A: " + UserSettings.A + "\n";
		retval += "B: " + UserSettings.B + "\n";
		retval += "START: " + UserSettings.START + "\n";
		retval += "SELECT: " + UserSettings.SELECT + "\n";
		retval += "EXIT";
		return retval;
	}
}
