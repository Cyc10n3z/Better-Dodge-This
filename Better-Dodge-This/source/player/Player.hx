package player;

import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	public static var SPEED(default, never):Int = 120;

	public var maxHealth:Int = 2;
	public var damage:Int;

	public function new(X:Float = 0, Y:Float = 0)
	{
		super(X, Y);
		// loadGraphic(AssetPaths.player__png, false);
		this.width = 60;
		this.height = 25;
		this.offset.x = 14;
		this.offset.y = 2.5;
		health = maxHealth;
	}

	override public function update(elapsed:Float)
	{
		playerSpeed();
		super.update(elapsed);
	}

	override function hurt(damage)
	{
		health -= 1;
	}

	private function playerSpeed()
	{
		if (x < 4 || x > FlxG.width - width)
		{
			velocity.x = 0;
		}

		if (FlxG.keys.justPressed.UP)
		{
			velocity.y = -SPEED;
		}

		if (FlxG.keys.pressed.DOWN)
		{
			velocity.y = SPEED;
		}

		if (FlxG.keys.pressed.LEFT && x > 4)
		{
			velocity.x = -SPEED;
		}

		if (FlxG.keys.pressed.RIGHT && x < FlxG.width - width)
		{
			velocity.x = SPEED;
		}

		if (FlxG.keys.pressed.RIGHT && FlxG.keys.pressed.LEFT)
		{
			velocity.x = 0;
		}

		if (FlxG.keys.pressed.UP && FlxG.keys.pressed.DOWN)
		{
			velocity.y = 0;
		}

		if (FlxG.keys.justReleased.LEFT || FlxG.keys.justReleased.RIGHT)
		{
			velocity.x = 0;
		}

		if (FlxG.keys.justReleased.UP || FlxG.keys.justReleased.DOWN)
		{
			velocity.y = 0;
		}
	}
}
