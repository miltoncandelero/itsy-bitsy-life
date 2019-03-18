package scenes;

import openfl.Lib;
import gbengine.Manager;
import gbengine.BaseScene;
import game.PetriDish;

class IntroScene extends BaseScene {
	var pd:PetriDish;
	var time:Int = 0;

	public function new() {
		super();
		graphics.beginFill(Manager.PALLETE[1]);
		graphics.drawRect(0, 0, Manager.WIDTH, Manager.HEIGHT);
		graphics.beginFill(Manager.PALLETE[2]);
		graphics.drawRect(57, 1, PetriDish.WIDTH + 2, PetriDish.HEIGHT + 2);
		pd = new PetriDish(Std.int(Lib.getTimer() * 1000 * Math.random()), 10, [3], [2, 3]);
		pd.y = 2;
		pd.x = 58;
		addChild(pd);
	}

	override function update(dt:Int) {
		time += dt;
		if (time > 100) {
			pd.advance();
			time = 0;
		}
		/*if (Manager.LEFT)

			if (Manager.RIGHT)

			if (Manager.UP)

			if (Manager.DOWN)

			if (Manager.A) */
	}
}
