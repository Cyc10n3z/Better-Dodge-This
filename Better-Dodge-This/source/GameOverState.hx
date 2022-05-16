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

class GameOverState extends FlxState
{
	var titleText:FlxText;
	var titleText2:FlxText;
	var endMessage:FlxText;
	var endMessage2:FlxText;
	var finalScore:FlxText;
	var totalScore:Int;
	var tryAgainButton:FlxButtonPlus;
	#if desktop
	var exitButton:FlxButtonPlus;
	#end

	override public function create()
	{
		#if FLX_MOUSE
		FlxG.mouse.visible = true;
		#end

		// first part of title
		titleText = new FlxText(20, 0, 0, "Better Dodge", 35);
		titleText.alignment = CENTER;
		titleText.screenCenter(X);
		add(titleText);
		// second part of title
		titleText2 = new FlxText(20, 60, 0, "This!", 35);
		titleText2.alignment = CENTER;
		titleText2.screenCenter(X);
		add(titleText2);

		// Game Over messages
		endMessage = new FlxText(0, 0, 0, "You are supposed to dodge ALL the things!", 22);
		endMessage.screenCenter();
		add(endMessage);
		endMessage2 = new FlxText((FlxG.width / 2) - 90, (FlxG.height / 2) + 20, 0, "Game Over.", 22);
		add(endMessage2);

		// Play again button
		tryAgainButton = new FlxButtonPlus(0, 0, tryAgain, "Try Again?", 100, 50);
		tryAgainButton.x = (FlxG.width / 3) - (0.5 * tryAgainButton.width);
		tryAgainButton.y = FlxG.height - tryAgainButton.height - 10;
		add(tryAgainButton);

		// Exit the game button
		#if desktop
		exitButton = new FlxButtonPlus(0, 0, clickExit, "Exit", 100, 50);
		exitButton.x = (FlxG.width / 5) - (0.5 * exitbutton.width);
		exitButton.y = FlxG.height - exitButton.height - 10;
		add(exitButton);
		#end

		// Sound for player death
		// FlxG.sound.play(AssetPaths.PlayerDeath__wav, 100);

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

		// Menu click sound
		if (FlxG.mouse.justPressed)
		{
			// FlxG.sound.play(AssetPaths.MenuClick__wav, 100);
		}
	}
}
