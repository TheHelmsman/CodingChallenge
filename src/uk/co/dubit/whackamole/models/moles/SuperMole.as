package uk.co.dubit.whackamole.models.moles
{
	
	/**
	 * ...
	 * @author Jeffrey T Feenstra
	 */
	public class SuperMole extends Mole
	{
		protected var numberOfLives:int;
		
		public function SuperMole()
		{
		
		}
		
		override public function hit():void
		{
			numberOfLives -= 1;
			if (numberOfLives <= 0)
				super.hit();
		}
		
		override public function get heirarchy():String 
		{
			return super.heirarchy+".SuperMole";
		}
	
	}

}