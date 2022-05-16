package;

import lime.system.System;
import flixel.util.FlxColor;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSubState;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.addons.ui.FlxButtonPlus;

class GameWinState extends FlxState
{
	var titleText:FlxText;
	var titleText2:FlxText;
	var endMessage:FlxText;
	var endMessage2:FlxText;
	var tryAgainButton:FlxButtonPlus;
	#if desktop
	var exitButton:FlxButtonPlus;
	#end

	override public function create()
	{
		#if FLX_MOUSE
		FlxG.mouse.visible = true;
		#end

		// First part of title
		titleText = new FlxText(190, 40, 0, "Better Dodge", 35);
		titleText.alignment = CENTER;
		add(titleText);

		// Second part of title
		titleText2 = new FlxText(270, 80, 0, "This!", 35);
		titleText2.alignment = CENTER;
		add(titleText2);

		// Game Won messages
		endMessage = new FlxText(0, 0, 0, "You dodged ALL the things.", 22);
		endMessage.screenCenter();
		add(endMessage);
		endMessage2 = new FlxText((FlxG.width / 2) - 90, (FlxG.height / 2) + 20, 0, "Congratulations!", 22);
		add(endMessage2);

		// Play again button
		tryAgainButton = new FlxButtonPlus(0, 0, tryAgain, "Play Again?", 100, 50);
		tryAgainButton.x = (250) - (0.5 * tryAgainButton.width);
		tryAgainButton.y = FlxG.height - tryAgainButton.height - 50;
		add(tryAgainButton);

		// Exit game button
		#if desktop
		exitButton = new FlxButtonPlus(0, 0, clickExit, "Exit", 100, 50);
		exitButton.x = (400) - (0.5 * exitButton.width);
		exitButton.y = FlxG.height - exitButton.height - 50;
		add(exitButton);
		#end

		super.create();
	}

	private function tryAgain()
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			FlxG.switchState(new PlayState());
		});
	}

	private function clickExit()
	{
		System.exit(0);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
