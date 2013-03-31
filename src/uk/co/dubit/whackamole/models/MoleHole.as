package uk.co.dubit.whackamole.models
{
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import uk.co.dubit.whackamole.models.events.AchievementEvent;
	import uk.co.dubit.whackamole.models.moles.Mole;
	
	/**
	 * Models a hole which may or may not
	 * be filled by a mole. It's empty if
	 * the mole property is null.
	 *
	 **/
	public class MoleHole extends EventDispatcher
	{
		private var _mole:Mole;
		private var _moleGame:MoleGame; //This seems to be a silly scope loop thing.
		
		private var showTimer:Timer;
		
		public function MoleHole(moleGame:MoleGame)
		{
			_moleGame = moleGame;
			//This time controls the amount of time
			//a mole fills this hole for
			showTimer = new Timer(1000, 1);
			showTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onShowTimerComplete);
		}
		
		public function get moleGame():MoleGame
		{
			return _moleGame;
		}
		
		[Bindable]
		public function get mole():Mole
		{
			return _mole;
		}
		
		public function set mole(value:Mole):void
		{
			_mole = value;
		}
		
		[Bindable]
		public function get occupantDead():Boolean
		{
			return (mole && mole.dead);
		}
		
		public function set occupantDead(value:Boolean):void
		{
			if (mole)
				mole.dead = value;
		}
		
		public function populate(mole:Mole):void
		{
			//Add the specified mole to this hole,
			//and set up the timer to remove it after
			//its showtime has elapsed
			this.mole = mole;
			
			showTimer.reset();
			switch (_moleGame.difficulty)
			{
				case 0: 
				//Easy
				case 1: 
					//Normal
					showTimer.delay = mole.showtime;
					break;
				case 2: 
					//Hard
					showTimer.delay = mole.showtime * .9; //90% of the original time.
			}
			showTimer.start();
		}
		
		public function hit():void
		{
			if (mole && !mole.dead)
			{
				//Whack the mole, and if it results in a
				//kill, rack up the score
				mole.hit();
				//Achievement +Hit Mole Hierarchy
				//dispatchEvent(new AchievementEvent(AchievementEvent.ACTION_EVENT, "Hit", mole.heirarchy));
				if (mole.dead)
				{
					moleGame.addScore(mole.points);
					//Achievement +Kill Mole Heirarchy
					dispatchEvent(new AchievementEvent(AchievementEvent.ACTION_EVENT, "Kill", mole.heirarchy));
				}
			}
		}
		
		private function onShowTimerComplete(event:TimerEvent):void
		{
			//evaluate if dead
			if (!mole.dead)
				dispatchEvent(new AchievementEvent(AchievementEvent.ACTION_EVENT, "Miss", mole.heirarchy));
			//Achievement on Not dead +Miss Mole Heirarchy
			
			//Empty the hole
			mole = null;
		}
	}
}