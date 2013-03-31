package uk.co.dubit.whackamole.views.events
{
	import flash.events.Event;
	
	public class IntroductionViewEvent extends Event
	{
		public static const START:String = "introductionStart";
		
		private var _difficulty:int;
		
		/**
		 *
		 * @param	type
		 * @param	difficulty Difficulty 0-2. 0 being easy 2 being hard
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function IntroductionViewEvent(type:String, difficulty:int, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			_difficulty = difficulty;
		}
		
		public function get difficulty():int
		{
			return _difficulty;
		}
	}
}