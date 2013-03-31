package uk.co.dubit.whackamole.models.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Jeffrey T Feenstra
	 */
	public class AchievementEvent extends Event
	{
		public static const ACTION_EVENT:String = "actionevent";
		public static const ACHIEVEMENT_COMPLETE:String = "completeachievement";
		
		public var achievementEvent:String;
		
		public function AchievementEvent(type:String, action:String="", heirarchy:String="", bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			//Consider seperating or individual tracking of actions vs heirarchies
			achievementEvent = action + "." + heirarchy;
		}
		
		public override function clone():Event
		{
			return new AchievementEvent(type, "", "", bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("AchievementEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	
	}

}