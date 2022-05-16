package player;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	public static var SPEED(default, never):Int = 150;

	public var maxHealth:Int = 2;
	public var damage:Int;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		loadGraphic(AssetPaths.PlayerShip__png, false);
		this.width = 29;
		this.height = 26;
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
		if (FlxG.keys.justPressed.W)
		{
			velocity.y = -SPEED;
		}

		if (FlxG.keys.pressed.S)
		{
			velocity.y = SPEED;
		}

		if (FlxG.keys.pressed.A)
		{
			velocity.x = -SPEED;
		}

		if (FlxG.keys.pressed.D)
		{
			velocity.x = SPEED;
		}

		if (FlxG.keys.pressed.D && FlxG.keys.pressed.A)
		{
			velocity.x = 0;
		}

		if (FlxG.keys.pressed.W && FlxG.keys.pressed.S)
		{
			velocity.y = 0;
		}

		if (FlxG.keys.justReleased.A || FlxG.keys.justReleased.D)
		{
			velocity.x = 0;
		}

		if (FlxG.keys.justReleased.W || FlxG.keys.justReleased.S)
		{
			velocity.y = 0;
		}
	}
}
