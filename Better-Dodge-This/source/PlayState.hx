package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import player.Player;
import enemies.Enemy;
import enemies.SmallAsteroid;
import enemies.LargeAsteroid;
import flixel.group.FlxGroup;

class PlayState extends FlxState
{
	// Background and Game World Variables
	var backdrop:FlxBackdrop;
	var leftWall:FlxObject;
	var rightWall:FlxObject;
	var topWall:FlxObject;
	var bottomWall:FlxObject;

	// Player Variables
	var player:Player;

	// Enemy Variables
	var spawnTimer:Float = 0;
	var SECONDS_PER_ENEMY(default, never):Float = 1;
	var enemy:Enemy;

	// Asteroid Variables
	var smallAsteroid:SmallAsteroid;
	var largeAsteroid:LargeAsteroid;

	// Enemy and Asteroid Groups
	public var enemyGroup:FlxTypedGroup<Enemy>;
	public var smallAsteroidGroup:FlxTypedGroup<SmallAsteroid>;
	public var largeAsteroidGroup:FlxTypedGroup<LargeAsteroid>;

	// Game Over condition
	var end:Bool = false;

	override public function create()
	{
		// Start the Intro Music

		// Begin the PlayState
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

		super.create();

		// Create game world elements: backdrop, player wall boundaries, etc.
		backdrop = new FlxBackdrop(AssetPaths.Background1__jpg, 0, 1, true, false, 0, 0);
		backdrop.velocity.set(-100, 0);
		leftWall = new FlxObject(0, 0, 5, FlxG.height);
		leftWall.immovable = true;
		rightWall = new FlxObject(FlxG.width, 0, FlxG.height, (FlxG.width - 5));
		rightWall.immovable = true;
		topWall = new FlxObject(0, 0, FlxG.width, 4);
		topWall.immovable = true;
		bottomWall = new FlxObject(0, FlxG.height, FlxG.width, 4);
		bottomWall.immovable = true;

		// Create player
		player = new Player(FlxG.width / 8, FlxG.height / 2);

		// Add Game Elements
		add(backdrop);
		add(leftWall);
		add(rightWall);
		add(topWall);
		add(bottomWall);
		add(player);
	}

	override public function update(elapsed:Float)
	{
		//
		spawnTimer += elapsed * 3;
		if (spawnTimer > 1)
		{
			spawnTimer--;
			// enemyGroup.add(enemyGroup.recycle());
		}

		super.update(elapsed);

		// IF the end game condition is true, then end PlayState
		if (end)
		{
			return;
		}

		// Player boundary wall collision
		if (FlxG.collide(player, leftWall) || FlxG.collide(player, rightWall))
			player.velocity.x = 0;
		if (FlxG.collide(player, topWall) || FlxG.collide(player, bottomWall))
			player.velocity.y = 0;

		// Enable fullscreen mode
		if (FlxG.keys.justPressed.ENTER)
			FlxG.fullscreen = !FlxG.fullscreen;

		// End the game if the player reaches 0 lives or health
		if (player.health <= 0)
		{
			// FlxG.sound.play(AssetPaths.PlayerDeath__wav, 100);

			end = true;
			FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function gameOver()
			{
				FlxG.switchState(new GameOverState());
			});
		}
	}
}
