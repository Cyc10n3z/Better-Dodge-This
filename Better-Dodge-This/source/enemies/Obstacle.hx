package enemies;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;

class Obstacle extends FlxSprite
{
	public function new(x:Float = 0, y:Float = 0, speed:Float = 0, width:Int = 0, height:Int = 0)
	{
		super();

		immovable = true;

		this.x = x;
		this.y = y;
		this.speed = speed;
		this.width = width;
		this.height = height;
	}

	override public function update(elapsed:Float)
	{
		if (movedOffScreen())
		{
			kill();
		}

		super.update(elapsed);
	}

	public static function overlapsWithPlayer(player:FlxObject, obstacle:Obstacle)
	{
		player.hurt(1);
		// FlxG.sound.play(AssetPaths.PlayerHurt__wav, .80);
		obstacle.kill();
	}

	public function movedOffScreen()
	{
		return x + width < FlxG.camera.scroll.x;
	}
}
