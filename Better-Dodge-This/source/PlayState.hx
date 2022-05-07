package;

import flixel.FlxObject;
import flixel.FlxState;
import player.FlxG;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import player.Player;
import flixel.group.FlxGroup;

class PlayState extends FlxState
{
	// Background and Game World Variables
	var backdrop:FlxBackdrop;
	var leftWall:FlxObject;

	// Player Variables
	var player:Player;

	// Enemy Variables
	var spawnTimer:Float = 0;
	var SECONDS_PER_ENEMY(default, never):Float = 1;
	var enemy:Enemy;

	// Obstacle Variables
	var obstacle:Obstacle;

	public var enemyGroup:FlxTypedGroup<Enemy>;
	public var obstacleGroup:FlxTypedGroup<Obstacle>;

	var override public function create()
	{
		// Begin the game state by fading in
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

		super.create();

		// Create the game world elements: backdrop, left wall, etc.
		backdrop = new FlxBackdrop();
		backdrop.velocity.set(0, 100);
		leftWall = new FlxObject(0, 0, FlxG.height, (FlxG.width - 10));
		leftWall.immovable = true;

		// Create player
		player = new Player(FlxG.width / 8, FlxG.height / 2);
		add(player);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// Left wall collision
		if (FlxG.collide(player, leftWall))
		{
			player.velocity.x = 0;
		}
	}
}
