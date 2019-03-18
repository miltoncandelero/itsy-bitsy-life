package game;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import gbengine.Manager;
import gbengine.GBHelper;
import haxe.ds.Vector;
import openfl.display.Sprite;

class PetriDish extends Sprite {
	public static inline var WIDTH:Int = 100;
	public static inline var HEIGHT:Int = 140;
	public static inline var TOTAL:Int = 14000;

	public var alive:Int = 0;
	public var deathCount:Int = 0;
	public var generation:Int = 0;
	public var seed:Int;
	public var spawnRate:Int;
	public var bornRule:Array<Int> = [3];
	public var surviveRule:Array<Int> = [2, 3];
	public var cells:Vector<Bool>;

	private var aux:Vector<Bool>;
	private var renderer:Bitmap = new Bitmap();

	public function new(randSeed:Int = 123456789, randPerc:Int = 50, bornRule:Array<Int> = null, surviveRule:Array<Int> = null) {
		super();
		addChild(renderer);
		if (bornRule != null)
			this.bornRule = bornRule;
		if (surviveRule != null)
			this.surviveRule = surviveRule;
		this.seed = randSeed;
		this.spawnRate = randPerc;

		cells = new Vector<Bool>(14000);
		var rnd = new PCG32();
		rnd.seed(randSeed);

		for (i in 0...WIDTH) {
			for (j in 0...HEIGHT) {
				cells[Std.int((i % WIDTH) + (j % HEIGHT) * WIDTH)] = (rnd.random(100) < randPerc);
				if (cells[Std.int((i % WIDTH) + (j % HEIGHT) * WIDTH)]) {
					alive++;
				}
			}
		}

		aux = cells.copy();
		render();
	}

	private inline function adjacentAlive(x:Int, y:Int):Int {
		return (cell(x - 1, y) + cell(x + 1, y) + cell(x + 1, y + 1) + cell(x, y + 1) + cell(x - 1, y + 1) + cell(x + 1, y - 1) + cell(x, y - 1)
			+ cell(x - 1, y - 1));
	}

	private inline function cell(x:Int, y:Int):Int {
		while (x < 0) {
			x += WIDTH;
		}
		while (y < 0) {
			y += HEIGHT;
		}
		return cells[Std.int((x % WIDTH) + (y % HEIGHT) * WIDTH)] ? 1 : 0;
	}

	public function advance():Bool {
		aux = cells.copy();
		for (i in 0...WIDTH) {
			for (j in 0...HEIGHT) {
				if (cell(i, j) == 1) {
					// alive, check if should die.
					if (surviveRule.indexOf(adjacentAlive(i, j)) == -1) { // if no rule found
						// you die
						deathCount++;
						alive--;
						aux[Std.int((i % WIDTH) + (j % HEIGHT) * WIDTH)] = false;
					}
				} else {
					// if nothing here, check birth condition.
					if (bornRule.indexOf(adjacentAlive(i, j)) != -1) { // if rule found
						// you ALIIIIIVEEEE!
						alive++;
						aux[Std.int((i % WIDTH) + (j % HEIGHT) * WIDTH)] = true;
					}
				}
			}
		}
		if (aux == cells) {
			return false;
		} else {
			cells = aux.copy();
			generation++;
			render();
			return true;
		}
	}

	private function render() {
		// Vector rendering
		/*
			graphics.clear();
			graphics.beginFill(GBHelper.PALLETE[0]);
			graphics.drawRect(0, 0, WIDTH, HEIGHT);
			graphics.beginFill(GBHelper.PALLETE[3]);
			for (i in 0...WIDTH) {
				for (j in 0...HEIGHT) {
					if (cell(i, j) == 1) {
						graphics.drawRect(i, j, 1, 1);
					}
				}
			}
		 */
		// bitmap rendering
		var bmdata = new BitmapData(WIDTH, HEIGHT, false, GBHelper.PALLETE[0]);
		for (i in 0...WIDTH) {
			for (j in 0...HEIGHT) {
				if (cell(i, j) == 1) {
					bmdata.setPixel(i, j, GBHelper.PALLETE[3]);
				}
			}
		}
		renderer.bitmapData = bmdata;
	}
}
