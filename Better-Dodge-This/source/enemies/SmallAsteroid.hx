package enemies;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;

class SmallAsteroid extends FlxSprite
{
	public function new()
	{
		super();

		immovable = true;
	}

	override public function update(elapsed:Float)
	{
		if (movedOffScreen())
		{
			kill();
		}

		super.update(elapsed);
	}

	public static function overlapsWithPlayer(player:FlxObject, smallAsteroid:SmallAsteroid)
	{
		player.hurt(1);
		// FlxG.sound.play(AssetPaths.PlayerHurt__wav, .80);
		smallAsteroid.kill();
	}

	public function movedOffScreen()
	{
		return x + width < FlxG.camera.scroll.x;
	}
}
