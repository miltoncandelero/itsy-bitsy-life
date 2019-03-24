package scenes;

import gbengine.UserSettings;
import openfl.Lib;
import gbengine.Manager;
import gbengine.GBHelper;
import gbengine.BaseScene;
import gbengine.TextLabel;
import game.PetriDish;

using StringTools;

class IntroScene extends BaseScene {
	var pd:PetriDish;
	var time:Int = 0;
	var txtData:TextLabel;
	var txtTitle:TextLabel;

	public function new() {
		super();
		graphics.beginFill(UserSettings.PALETTE[1]);
		graphics.drawRect(0, 0, Manager.WIDTH, Manager.HEIGHT);
		graphics.beginFill(UserSettings.PALETTE[2]);
		graphics.drawRect(57, 1, PetriDish.WIDTH + 2, PetriDish.HEIGHT + 2);
		pd = new PetriDish(Std.int(Lib.getTimer() * 1000 * Math.random()), 10, [3], [2, 3]);
		pd.y = 2;
		pd.x = 58;
		addChild(pd);

		txtData = new TextLabel(true, true);
		txtData.text = "123\n456\n789";
		var tf = GBHelper.FORMAT_04B03;
		tf.color = UserSettings.PALETTE[3];
		txtData.defaultTextFormat = tf;
		txtData.y = 45;
		addChild(txtData);

		txtTitle = new TextLabel(true,true);
		txtTitle.text = "Itsy\nBitsy\nLife";
		var titleFormat = GBHelper.FORMAT_04B03;
		titleFormat.size = 16;
		txtTitle.defaultTextFormat = titleFormat;
		addChild (txtTitle);
	}

	override function update(dt:Int) {
		time += dt;
		if (time > 100) {
			pd.advance();
			time = 0;
			txtData.text = "Generation\n" + pd.generation + "\nBirth Rule\n" + pd.bornRule.toString().replace("[","").replace("]","") + "\nSurvive Rule\n" + pd.surviveRule.toString().replace("[","").replace("]","") + "\nCurrent alive\n" + pd.alive + "\nDeath count\n" + pd.deathCount + "\nRand seed\n"
				+ pd.seed + "\nInit chance\n" + pd.spawnRate + "%";
		}
		/*if (Manager.LEFT)

			if (Manager.RIGHT)

			if (Manager.UP)

			if (Manager.DOWN)

			if (Manager.A) */
	}
}
