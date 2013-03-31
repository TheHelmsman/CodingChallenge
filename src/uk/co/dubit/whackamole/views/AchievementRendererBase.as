package uk.co.dubit.whackamole.views 
{
	import spark.components.supportClasses.ItemRenderer;
	import uk.co.dubit.whackamole.models.RuleObject;
	/**
	 * ...
	 * @author Jeffrey T Feenstra
	 */
	public class AchievementRendererBase extends ItemRenderer
	{
		[Bindable]
		protected var achievementRule:RuleObject;
		
		public function AchievementRendererBase() 
		{
			
		}
		
		override public function set data(value:Object):void
		{
			achievementRule = value as RuleObject;
		}
		
	}

}