package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
// import flixel.addons.display.FlxBackdrop;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import player.Player;
import enemies.Enemy;
import enemies.Obstacle;
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

	override public function create()
	{
		// Start the Intro Music

		// Begin the game state by fading in
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

		super.create();

		// Create game world elements: backdrop, player wall boundaries, etc.
		backdrop = new FlxBackdrop(AssetPaths.Background1__png, 0, 1, false, true, 0, 0);
		backdrop.velocity.set(0, 100);
		leftWall = new FlxObject(0, 0, FlxG.height, (FlxG.width - 10));
		leftWall.immovable = true;

		// Create player
		player = new Player(FlxG.width / 8, FlxG.height / 2);
		add(player);
	}

	override public function update(elapsed:Float)
	{
		//
		spawnTimer += elapsed * 3;
		if (spawnTimer > 1)
		{
			spawnTimer--;
			enemyGroup.add(enemyGroup.recycle());
		}

		super.update(elapsed);

		// Left wall collision
		if (FlxG.collide(player, leftWall))
		{
			player.velocity.x = 0;
		}
	}
}
