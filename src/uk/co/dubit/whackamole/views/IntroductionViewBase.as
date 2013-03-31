package uk.co.dubit.whackamole.views
{
	import spark.components.Button;
	import spark.components.Group;
	import uk.co.dubit.whackamole.views.events.IntroductionViewEvent;
	
	[Event(name="introductionStart",type="uk.co.dubit.whackamole.views.events.IntroductionViewEvent")]
	
	public class IntroductionViewBase extends Group
	{
		public var easyButton:Button;
		public var mediumButton:Button;
		public var hardButton:Button;
		
		protected function easyModeSelected():void
		{
			startGame(0);
		}
		
		protected function normalModeSelected():void
		{
			startGame(1);
		}
		
		protected function hardModeSelected():void
		{
			startGame(2);
		}
		
		private function startGame(difficulty:int):void
		{
			dispatchEvent(new IntroductionViewEvent(IntroductionViewEvent.START, difficulty));
		}
	}
}