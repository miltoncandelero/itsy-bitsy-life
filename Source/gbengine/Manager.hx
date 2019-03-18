package gbengine;

import openfl.display.PixelSnapping;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.events.KeyboardEvent;
import openfl.events.Event;
import openfl.display.Sprite;
import openfl.Lib;

class Manager {
	// constants
	public static inline var WIDTH:Int = 160;
	public static inline var HEIGHT:Int = 144;
	// inputs
	public static var UP:Bool = false;
	public static var DOWN:Bool = false;
	public static var LEFT:Bool = false;
	public static var RIGHT:Bool = false;
	public static var A:Bool = false;
	public static var B:Bool = false;
	public static var START:Bool = false;
	public static var SELECT:Bool = false;
	// rising edge (just pressed)
	public static var RE_UP:Bool = false;
	public static var RE_DOWN:Bool = false;
	public static var RE_LEFT:Bool = false;
	public static var RE_RIGHT:Bool = false;
	public static var RE_A:Bool = false;
	public static var RE_B:Bool = false;
	public static var RE_START:Bool = false;
	public static var RE_SELECT:Bool = false;
	// falling edge (just released)
	public static var FE_UP:Bool = false;
	public static var FE_DOWN:Bool = false;
	public static var FE_LEFT:Bool = false;
	public static var FE_RIGHT:Bool = false;
	public static var FE_A:Bool = false;
	public static var FE_B:Bool = false;
	public static var FE_START:Bool = false;
	public static var FE_SELECT:Bool = false;
	// real time status. (private)
	private static var ACTUAL_UP:Bool = false;
	private static var ACTUAL_DOWN:Bool = false;
	private static var ACTUAL_LEFT:Bool = false;
	private static var ACTUAL_RIGHT:Bool = false;
	private static var ACTUAL_A:Bool = false;
	private static var ACTUAL_B:Bool = false;
	private static var ACTUAL_START:Bool = false;
	private static var ACTUAL_SELECT:Bool = false;
	// manager variables
	public static var container:Sprite = new Sprite();
	private static var currentScene:IScene;
	private static var currentTransition:ITransition;
	private static var sceneContainer:Sprite = new Sprite();
	private static var transitionContainer:Sprite = new Sprite();
	private static var gbFrame:Bitmap;
	private static var initialized:Bool = false;
	private static var currentTime:Int = 0;
	private static var lastTime:Int = 0;
	private static var deltaTime:Int = 0;
	// Color pallete
	public static var PALLETE:Array<Int> = [0x9bbc0f, 0x8bac0f, 0x306230, 0x0f380f];

	public function new() {}

	private static function initialize() {
		if (initialized)
			return;
		initialized = true;
		Lib.current.stage.addChild(container);
		container.addChild(sceneContainer);
		container.addChild(transitionContainer);

		gbFrame = new Bitmap(Assets.getBitmapData("assets/img/gameboyFrame.png"), PixelSnapping.ALWAYS, false);
		container.addChild(gbFrame);
		gbFrame.y = -25;
		gbFrame.x = -48;

		currentTime = lastTime = Lib.getTimer();

		Lib.current.stage.addEventListener(Event.ENTER_FRAME, update, false, 99999999);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown, false, 9999999);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, keyUp, false, 9999999);
		Lib.current.stage.addEventListener(Event.RESIZE, resize, false, 9999999);
	}

	private static function keyDown(e:KeyboardEvent) {
		if (e.keyCode == UserSettings.UP)
			ACTUAL_UP = true;
		if (e.keyCode == UserSettings.DOWN)
			ACTUAL_DOWN = true;
		if (e.keyCode == UserSettings.LEFT)
			ACTUAL_LEFT = true;
		if (e.keyCode == UserSettings.RIGHT)
			ACTUAL_RIGHT = true;
		if (e.keyCode == UserSettings.A)
			ACTUAL_A = true;
		if (e.keyCode == UserSettings.B)
			ACTUAL_B = true;
		if (e.keyCode == UserSettings.START)
			ACTUAL_START = true;
		if (e.keyCode == UserSettings.SELECT)
			ACTUAL_SELECT = true;
	}

	private static function keyUp(e:KeyboardEvent) {
		if (e.keyCode == UserSettings.UP)
			ACTUAL_UP = false;
		if (e.keyCode == UserSettings.DOWN)
			ACTUAL_DOWN = false;
		if (e.keyCode == UserSettings.LEFT)
			ACTUAL_LEFT = false;
		if (e.keyCode == UserSettings.RIGHT)
			ACTUAL_RIGHT = false;
		if (e.keyCode == UserSettings.A)
			ACTUAL_A = false;
		if (e.keyCode == UserSettings.B)
			ACTUAL_B = false;
		if (e.keyCode == UserSettings.START)
			ACTUAL_START = false;
		if (e.keyCode == UserSettings.SELECT)
			ACTUAL_SELECT = false;
	}

	private static function update(_) {
		lastTime = currentTime;
		currentTime = Lib.getTimer();
		deltaTime = currentTime - lastTime;

		// reset the edges

		RE_UP = false;
		RE_DOWN = false;
		RE_LEFT = false;
		RE_RIGHT = false;
		RE_A = false;
		RE_B = false;
		RE_START = false;
		RE_SELECT = false;

		FE_UP = false;
		FE_DOWN = false;
		FE_LEFT = false;
		FE_RIGHT = false;
		FE_A = false;
		FE_B = false;
		FE_START = false;
		FE_SELECT = false;

		// if we have an edge
		if (ACTUAL_UP != UP) {
			if (ACTUAL_UP)
				RE_UP = true;
			else
				FE_UP = true;
			UP = ACTUAL_UP;
		}
		if (ACTUAL_DOWN != DOWN) {
			if (ACTUAL_DOWN)
				RE_DOWN = true;
			else
				FE_DOWN = true;
			DOWN = ACTUAL_DOWN;
		}
		if (ACTUAL_LEFT != LEFT) {
			if (ACTUAL_LEFT)
				RE_LEFT = true;
			else
				FE_LEFT = true;
			LEFT = ACTUAL_LEFT;
		}
		if (ACTUAL_RIGHT != RIGHT) {
			if (ACTUAL_RIGHT)
				RE_RIGHT = true;
			else
				FE_RIGHT = true;
			RIGHT = ACTUAL_RIGHT;
		}
		if (ACTUAL_A != A) {
			if (ACTUAL_A)
				RE_A = true;
			else
				FE_A = true;
			A = ACTUAL_A;
		}
		if (ACTUAL_B != B) {
			if (ACTUAL_B)
				RE_B = true;
			else
				FE_B = true;
			B = ACTUAL_B;
		}
		if (ACTUAL_START != START) {
			if (ACTUAL_START)
				RE_START = true;
			else
				FE_START = true;
			START = ACTUAL_START;
		}
		if (ACTUAL_SELECT != SELECT) {
			if (ACTUAL_SELECT)
				RE_SELECT = true;
			else
				FE_SELECT = true;
			SELECT = ACTUAL_SELECT;
		}

		if (currentScene != null)
			currentScene.update(deltaTime);
		if (currentTransition != null)
			currentTransition.update(deltaTime);
	}

	private static function resize(_) {
		container.scaleX = container.scaleY = (Math.floor(Math.min(Lib.current.stage.stageWidth / WIDTH * 0.66, Lib.current.stage
			.stageHeight / HEIGHT * 0.75)));
		if (container.scaleX == 0) {
			container.scaleX = container.scaleY = Math.min((Math.min(Lib.current.stage.stageWidth / WIDTH, Lib.current.stage.stageHeight / HEIGHT)), 1);
		}

		container.x = (Lib.current.stage.stageWidth - WIDTH * container.scaleX) / 2;
		container.y = (Lib.current.stage.stageHeight - HEIGHT * container.scaleY) / 2;
	}

	public static function changeScene(newScene:Class<IScene>, sceneParams:Array<Dynamic> = null, transition:Class<ITransition> = null,
			transitionParams:Array<Dynamic> = null) {
		initialize();

		if (transition == null)
			transition = BaseTransition;
		if (sceneParams == null)
			sceneParams = [];
		if (transitionParams == null)
			transitionParams = [];

		currentTransition = Type.createInstance(transition, transitionParams);

		transitionContainer.addChild(cast(currentTransition));
		currentTransition.cover(function() {
			if (currentScene != null) {
				currentScene.destroy();
				sceneContainer.removeChild(cast(currentScene));
			}

			currentScene = Type.createInstance(newScene, sceneParams);
			sceneContainer.addChild(cast(currentScene));
			currentTransition.uncover(function() {
				transitionContainer.removeChild(cast(currentTransition));
				currentTransition = null;
				currentScene.show();
			});
		});
	}
}
