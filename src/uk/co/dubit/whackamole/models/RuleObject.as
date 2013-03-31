package uk.co.dubit.whackamole.models 
{
	/**
	 * ...
	 * @author Jeffrey T Feenstra
	 */
	public class RuleObject 
	{
		[Bindable]
		public var title:String;
		[Bindable]
		public var details:String;
		
		private var _rule:String;
		private var _count:int;
		public function RuleObject(ruleHeirarchy:String = "none", actionCount:int = -1) 
		{
			_rule = ruleHeirarchy;
			_count = actionCount;
		}
		
		[Bindable]
		public function get count():int 
		{
			return _count;
		}
		
		public function set count(value:int):void 
		{
			_count = value;
		}
		
		public function get rule():String 
		{
			return _rule;
		}
		
	}

}