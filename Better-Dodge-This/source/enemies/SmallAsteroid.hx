package enemies;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;

class SmallAsteroid extends FlxSprite
{
	public function new(SPEED:Float = 0)
	{
		super(x, y);
		loadGraphic(AssetPaths.SmallAsteroid__png, false);
		// Asteroid width and height
		this.width = 41;
		this.height = 36;
		// Asteroid speed
		velocity.x = -SPEED;

		immovable = true;
		kill();
	}

	override public function update(elapsed:Float)
	{
		if (movedOffScreen())
		{
			kill();
		}

		super.update(elapsed);
	}

	override public function revive()
	{
		x = FlxG.width;
		y = FlxG.random.int(0, Std.int(FlxG.height - height));

		super.revive();
	}

	public static function overlapsWithPlayer(player:FlxObject, smallAsteroid:SmallAsteroid)
	{
		player.hurt(1);
		smallAsteroid.kill();
	}

	public function movedOffScreen()
	{
		return x + width < FlxG.camera.scroll.x;
	}
}
