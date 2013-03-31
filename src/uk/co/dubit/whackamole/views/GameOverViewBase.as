package uk.co.dubit.whackamole.views
{
	import spark.components.Button;
	import spark.components.Group;
	import uk.co.dubit.whackamole.views.events.ReplayGameEvent;
	
	/**
	 * ...
	 * @author Jeffrey T Feenstra
	 */
	public class GameOverViewBase extends Group
	{
		public var replayButton:Button;
		
		private var _score:int = 0;
		
		public function GameOverViewBase()
		{
		
		}
		
		public function onReplayButtonClick():void
		{
			//Go back to difficculty selection screen.
			dispatchEvent(new ReplayGameEvent(ReplayGameEvent.REPLAY_GAME));
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
	
	}

}