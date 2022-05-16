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
	// Background and Game World Variable(s)
	var backdrop:FlxBackdrop;
	var leftWall:FlxObject;
	var rightWall:FlxObject;
	var topWall:FlxObject;
	var bottomWall:FlxObject;
	// Player Variable(s)
	var player:Player;

	// Asteroid and Enemy Time Variable(s)
	var spawnTimer:Float = 1;
	var waveTimer:Float = 0;
	var waveNumber:Int = 0;

	// Asteroid Groups
	public var smallSlowAsteroidGroup:FlxTypedGroup<SmallAsteroid>;
	public var smallFastAsteroidGroup:FlxTypedGroup<SmallAsteroid>;
	public var largeAsteroidGroup:FlxTypedGroup<LargeAsteroid>;

	// Game Over condition
	var end:Bool = false;

	override public function create()
	{
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

		// Create Player
		player = new Player(FlxG.width / 8, FlxG.height / 2);
		// Add Game Elements
		add(backdrop);
		add(leftWall);
		add(rightWall);
		add(topWall);
		add(bottomWall);
		// Add the player
		add(player);
		// Setup and add asteroids
		setupAsteroids();
	}

	private function setupAsteroids()
	{
		// Create Asteroid Groups
		smallSlowAsteroidGroup = new FlxTypedGroup<SmallAsteroid>();
		smallFastAsteroidGroup = new FlxTypedGroup<SmallAsteroid>();
		largeAsteroidGroup = new FlxTypedGroup<LargeAsteroid>();
		for (i in 0...10)
		{
			var smallSlowAsteroid = new SmallAsteroid(120);
			smallSlowAsteroid.kill();
			smallSlowAsteroidGroup.add(smallSlowAsteroid);
		}
		for (i in 0...10)
		{
			var smallFastAsteroid = new SmallAsteroid(200);
			smallFastAsteroid.kill();
			smallFastAsteroidGroup.add(smallFastAsteroid);
		}
		for (i in 0...3)
		{
			var largeAsteroid = new LargeAsteroid(100);
			largeAsteroid.kill();
			largeAsteroidGroup.add(largeAsteroid);
		}

		add(smallSlowAsteroidGroup);
		add(smallFastAsteroidGroup);
		add(largeAsteroidGroup);
	}

	override public function update(elapsed:Float)
	{
		// Timing of asteroid waves spawning
		spawnTimer += elapsed * 3;
		if (spawnTimer > 1)
		{
			spawnTimer--;
			waveTimer++;
			// Change waves based on time elapsed (20 seconds)
			if (waveTimer == 20)
			{
				waveTimer = 0;
				waveNumber++;
			}
			// Change waves
			if (waveNumber == 0)
			{
				smallSlowAsteroidGroup.recycle(SmallAsteroid, false, true);
			}
			else if (waveNumber == 1)
			{
				smallFastAsteroidGroup.recycle(SmallAsteroid, false, true);
			}
			else if (waveNumber == 2)
			{
				smallSlowAsteroidGroup.recycle(SmallAsteroid, false, true);
				largeAsteroidGroup.recycle(LargeAsteroid, false, true);
			}
			else if (waveNumber == 3)
			{
				smallFastAsteroidGroup.recycle(SmallAsteroid, false, true);
				largeAsteroidGroup.recycle(LargeAsteroid, false, true);
			}
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

		// Asteroid collision
		FlxG.overlap(player, smallSlowAsteroidGroup, SmallAsteroid.overlapsWithPlayer);
		FlxG.overlap(player, smallFastAsteroidGroup, SmallAsteroid.overlapsWithPlayer);
		FlxG.overlap(player, largeAsteroidGroup, LargeAsteroid.overlapsWithPlayer);

		// Enable fullscreen mode
		if (FlxG.keys.justPressed.ENTER)
			FlxG.fullscreen = !FlxG.fullscreen;

		// End the game if the player reaches 0 lives or health
		/*if (player.health <= 0)
			{
				// FlxG.sound.play(AssetPaths.PlayerDeath__wav, 100);
				end = true;
				FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function gameOver()
				{
					FlxG.switchState(new GameOverState());
				});
		}*/
	}
}
