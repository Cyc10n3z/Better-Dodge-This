package enemies;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;

enum EnemyType
{
	FIGHTER;
	SUICIDE;
}

class Enemy extends FlxSprite
{
	static var SPEED:Float = 120;

	var type:EnemyType;

	public function new(type:EnemyType)
	{
		super(x, y);

		// Enemy speed
		velocity.y = SPEED;

		this.type = type;
		var graphic;
		if (type == FIGHTER)
		{
			velocity.x = 0;
			velocity.y = SPEED / 10;
			// loadGraphic(graphic, true);
			this.width = 80;
			this.height = 120;
			this.offset.x = 20;
			this.offset.y = 10;
		}
		else
		{
			// loadGraphic(graphic, true);
			this.width = 30;
			this.height = 45;
			this.offset.x = 10;
			this.offset.y = 5;
		}
		kill();
	}

	// Enemy spawning and "reviving" them when they go off the screen
	override public function revive()
	{
		y = FlxG.random.int(0, Std.int(FlxG.height - height));
		x = -width;
		super.revive();
	}

	override public function update(elapsed:Float)
	{
		if (movedOffScreen())
		{
			kill();
		}
		screenWrapping();

		super.update(elapsed);
	}

	private function movedOffScreen()
	{
		return x + width < FlxG.camera.scroll.x;
	}

	public static function overlapsWithPlayer(player:FlxObject, Enemy:Enemy)
	{
		player.hurt(1);
		Enemy.kill();
	}

	private function screenWrapping()
	{
		if (x < 0 - width)
		{
			x = FlxG.width;
		}
		if (x > FlxG.width)
		{
			x = 0 - width;
		}
	}
}
