package uk.co.dubit.whackamole.models.moles
{
	
	/**
	 * ...
	 * @author Jeffrey T Feenstra
	 */
	public class Zombole extends SuperMole
	{
		
		public function Zombole()
		{
			moleType = 2;
			numberOfLives = 3;
			points = 400;
			showtime = 1200;
		}
		
		override public function get heirarchy():String 
		{
			return super.heirarchy+".Zombole";
		}
	
	}

}