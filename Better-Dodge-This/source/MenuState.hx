package;

import flixel.system.debug.interaction.tools.Pointer;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import player.Player;
import flixel.addons.ui.FlxButtonPlus;
import flixel.util.FlxColor;
import lime.system.System;
import flixel.FlxSprite;

class MenuState extends FlxState
{
	var titleText:FlxText;
	var titleText2:FlxText;
	var playButton:FlxButtonPlus;
	#if desktop
	var exitButton:FlxButtonPlus;
	#end

	override public function create()
	{
		// First part of title
		titleText = new FlxText(190, 40, 0, "Better Dodge", 35);
		titleText.alignment = CENTER;
		add(titleText);

		// Second part of title
		titleText2 = new FlxText(270, 80, 0, "This!", 35);
		titleText2.alignment = CENTER;
		add(titleText2);

		// Play button
		playButton = new FlxButtonPlus(0, 0, clickPlay, "Play", 100, 50);
		playButton.x = (250) - (0.5 * playButton.width);
		playButton.y = FlxG.height - playButton.height - 50;
		add(playButton);

		// Exit game button
		#if desktop
		exitButton = new FlxButtonPlus(0, 0, clickExit, "Exit", 100, 50);
		exitButton.x = (400) - (0.5 * exitButton.width);
		exitButton.y = FlxG.height - exitButton.height - 50;
		add(exitButton);
		#end

		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

		super.create();
	}

	private function clickPlay()
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
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
