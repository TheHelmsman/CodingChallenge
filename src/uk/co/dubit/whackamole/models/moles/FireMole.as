package uk.co.dubit.whackamole.models.moles 
{
	/**
	 * ...
	 * @author Jeffrey T Feenstra
	 */
	public class FireMole extends SuperMole 
	{
		public function FireMole() 
		{
			moleType = 1;
			numberOfLives = 2;
			points = 100;
			showtime = 1800;
		}
	}

}