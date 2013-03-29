package uk.co.dubit.whackamole.views.events 
{
	import flash.events.Event;
	import flash.utils.SetIntervalTimer;
	
	/**
	 * ...
	 * @author Jeffrey T Feenstra
	 */
	public class ReplayGameEvent extends Event 
	{
		public static const REPLAY_GAME:String = "replaygame";
		public function ReplayGameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ReplayGameEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ReplayGameEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}