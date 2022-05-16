package;

import flixel.system.debug.interaction.tools.Pointer;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import player.Saw;
import flixel.addons.ui.FlxButtonPlus;
import flixel.util.FlxColor;
import lime.system.System;
import flixel.FlxSprite;

class MenuState extends FlxState
{
	var titleText:FlxText;
	var titleText2:FlxText;
	var pauseText:FlxText;
	var playButton:FlxButtonPlus;
	#if desktop
	var exitButton:FlxButtonPlus;
	#end

	override public function create()
	{
		// First part of title
		titleText = new FlxText(20, 0, 0, "Better Dodge", 35);
		titleText.alignment = CENTER;
		titleText.screenCenter(X);
		add(titleText);

		// Second part of title
		titleText2 = new FlxText(20, 60, 0, "This!", 35);
		titleText2.alignment = CENTER;
		titleText2.screenCenter(X);
		add(titleText2);
		// Add paused message
		pauseText = new FlxText(20, 100, 0, "PAUSED", 35);
		pause.alignment;
		pause.screen
		// Add play button
		playButton = new FlxButtonPlus(0, 0, clickPlay, "Play", 200, 50);
		// PlayButton.onUp.sound = FlxG.sound.load(AssetPaths.start__wav);
		playButton.x = (FlxG.width / 2) - (0.5 * playButton.width);
		playButton.y = FlxG.height - playButton.height - 50;
		add(playButton);

		// Add exit button
		#if desktop
		exitButton = new FlxButtonPlus(0, 0, clickExit, "Exit", 100, 50);
		exitButton.x = (FlxG.width / 5) - (0.5 * exitbutton.width);
		exitButton.y = FlxG.height - exitButton.height - 10;
		add(exitButton);
		#end

		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

		super.create();
	}

	private function clickPlay()
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			FlxG.sound.music.stop();
			FlxG.switchState(new PlayState());
		});
	}

	#if desktop
	private function clickExit()
	{
		System.exit(0);
	}
	#end

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ENTER)
			FlxG.fullscreen = !FlxG.fullscreen;
	}
}
