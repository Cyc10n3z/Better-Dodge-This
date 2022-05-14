package player;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	public static var SPEED(default, never):Int = 120;

	public var maxHealth:Int = 2;
	public var damage:Int;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		loadGraphic(AssetPaths.PlayerShip__png, false);
		this.width = 30;
		this.height = 30;
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
		if (FlxG.keys.justPressed.UP)
		{
			velocity.y = -SPEED;
		}

		if (FlxG.keys.pressed.DOWN)
		{
			velocity.y = SPEED;
		}

		if (FlxG.keys.pressed.LEFT)
		{
			velocity.x = -SPEED;
		}

		if (FlxG.keys.pressed.RIGHT)
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
