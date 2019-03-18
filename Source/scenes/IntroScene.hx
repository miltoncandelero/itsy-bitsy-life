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
		graphics.beginFill(0x0);
		graphics.drawRect(0, 0, Manager.WIDTH, Manager.HEIGHT);
		pd = new PetriDish(Std.int(Lib.getTimer() * 1000 * Math.random()), 10, [3], [2, 3]);
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
