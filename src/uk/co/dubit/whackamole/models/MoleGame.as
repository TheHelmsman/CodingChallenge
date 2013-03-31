package uk.co.dubit.whackamole.models
{
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import mx.collections.ArrayCollection;
	import uk.co.dubit.whackamole.models.events.AchievementEvent;
	import uk.co.dubit.whackamole.models.events.MoleGameEvent;
	import uk.co.dubit.whackamole.models.moles.FireMole;
	import uk.co.dubit.whackamole.models.moles.Mole;
	import uk.co.dubit.whackamole.models.moles.Zombole;
	
	/**
	 * Contains all the logic for the game itself; controls
	 * the addition of moles, keeps track of the player's
	 * score
	 *
	 **/
	
	[Event(name="gameOver",type="uk.co.dubit.whackamole.models.events.MoleGameEvent")]
	
	public class MoleGame extends EventDispatcher
	{
		
		private var _score:int = 0;
		private var _moleHoles:ArrayCollection = new ArrayCollection();
		
		private var gameTimer:Timer;
		
		private var _difficulty:int;
		private var _achievements:AchievementSystem = new AchievementSystem();
		
		private const GAME_TIMER_DELAY:Array = [450, 400, 375];
		private const TOTAL_MOLES:int = 40;
		
		public function MoleGame(difficulty:int)
		{
			_difficulty = difficulty;
			//Set up the game timer; when it fires a new
			//mole is added
			gameTimer = new Timer(GAME_TIMER_DELAY[difficulty], TOTAL_MOLES);
			gameTimer.addEventListener(TimerEvent.TIMER, onGameTimer);
			gameTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onGameTimerComplete);
		}
		
		[Bindable]
		public function get score():int
		{
			return _score;
		}
		
		public function set score(value:int):void
		{
			_score = value;
		}
		
		[Bindable]
		public function get moleHoles():ArrayCollection
		{
			return _moleHoles;
		}
		
		public function set moleHoles(value:ArrayCollection):void
		{
			_moleHoles = value;
		}
		
		public function get difficulty():int
		{
			return _difficulty;
		}
		
		[Bindable]
		public function get achievements():AchievementSystem 
		{
			return _achievements;
		}
		
		public function set achievements(value:AchievementSystem):void 
		{
			_achievements = value;
		}
		
		public function start():void
		{
			//There are currently nine MoleHoles; create and
			//add them to the moleHoles ArrayCollection
			for (var i:int = 0; i < 9; i++)
			{
				//A moleHole needs a reference to the game
				//so it can react appropriately to clicks
				var moleHole:MoleHole = new MoleHole(this);
				moleHole.addEventListener(AchievementEvent.ACTION_EVENT, handleAchievementAction);
				moleHoles.addItem(moleHole);
			}
			
			gameTimer.start();
		}
		
		private function handleAchievementAction(e:AchievementEvent):void 
		{
			_achievements.evaluateAction(e.achievementEvent);
		}
		
		public function addScore(points:int):void
		{
			score += points; //Modifier here?
		}
		
		private function getFreeMoleHole():MoleHole
		{
			//Pick a random hole until we find one without
			//an mole already in there
			var moleHole:MoleHole = null;
			
			while (moleHole == null || moleHole.mole)
			{
				moleHole = moleHoles[Math.floor(Math.random() * moleHoles.length)];
			}
			
			return moleHole;
		}
		
		private function onGameTimer(event:TimerEvent):void
		{
			//Every time the timer fires, add a new mole
			var moleHole:MoleHole = getFreeMoleHole();
			//Do some math to make super moles spawn
			var moleToSpawn:Number = Math.random();
			if (moleToSpawn <= 0.6)
			{
				//Normal
				moleHole.populate(new Mole());
			}
			else if (moleToSpawn <= 0.85)
			{
				//Fire Mole
				moleHole.populate(new FireMole());
			}
			else
			{
				//Zombie Mole (default!)
				moleHole.populate(new Zombole());
			}
		}
		
		private function onGameTimerComplete(event:TimerEvent):void
		{
			dispatchEvent(new MoleGameEvent(MoleGameEvent.GAME_OVER, score));
		}
	}
}