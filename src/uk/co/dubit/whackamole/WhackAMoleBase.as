package uk.co.dubit.whackamole
{
	import mx.events.FlexEvent;
	import spark.components.Application;
	import spark.components.Group;
	import uk.co.dubit.whackamole.models.events.MoleGameEvent;
	import uk.co.dubit.whackamole.models.MoleGame;
	import uk.co.dubit.whackamole.views.events.IntroductionViewEvent;
	import uk.co.dubit.whackamole.views.events.ReplayGameEvent;
	import uk.co.dubit.whackamole.views.GameOverView;
	import uk.co.dubit.whackamole.views.IntroductionView;
	import uk.co.dubit.whackamole.views.MoleGameView;
	
	/**
	 * A small whack-a-mole game based around MVC principles
	 */
	public class WhackAMoleBase extends Application
	{
		public var viewContainer:Group;
		
		public function WhackAMoleBase():void
		{
			super();
			addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
		}
		
		public function loadIntroduction():void
		{
			var introductionView:IntroductionView = new IntroductionView();
			introductionView.addEventListener(IntroductionViewEvent.START, onIntroductionViewStart);
			
			loadView(introductionView);
		}
		
		protected function onIntroductionViewStart(event:IntroductionViewEvent):void
		{
			event.target.removeEventListener(event.type, arguments.callee);
			
			loadMainGame(event.difficulty);
		}
		
		public function loadMainGame(gameDifficultyLevel:int):void
		{
			var moleGameView:MoleGameView = new MoleGameView();
			moleGameView.moleGame = new MoleGame(gameDifficultyLevel);
			moleGameView.moleGame.addEventListener(MoleGameEvent.GAME_OVER, handleGameOverEvent);
			
			loadView(moleGameView);
		}
		
		private function handleGameOverEvent(e:MoleGameEvent):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			
			//Game over view here
			var gameOverView:GameOverView = new GameOverView();
			gameOverView.addEventListener(ReplayGameEvent.REPLAY_GAME, handleReplayGameEvent);
			gameOverView.score = e.score;
			
			loadView(gameOverView);
		}
		
		private function handleReplayGameEvent(e:ReplayGameEvent):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			
			//Change looping funciton here
			loadIntroduction();
		}
		
		private function loadView(view:Group):void
		{
			//Clear any previous views in the container and add
			viewContainer.removeAllElements();
			viewContainer.addElement(view);
		}
		
		private function onCreationComplete(event:FlexEvent):void
		{
			//When the application is first created, we want to show the introductory view 
			loadIntroduction();
		}
	
	}
}