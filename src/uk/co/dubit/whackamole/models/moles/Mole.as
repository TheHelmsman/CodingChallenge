package uk.co.dubit.whackamole.models.moles
{
	
	/**
	 * The only type of mole at the moment;
	 * one hit kills it
	 *
	 **/
	public class Mole
	{
		private var _moleType:int = -1;
		private var _points:int = 60;
		private var _showtime:int = 1000;
		private var _dead:Boolean;
		
		public function Mole():void
		{
			moleType = 0;
		}
		
		public function get points():int
		{
			return _points;
		}
		
		public function set points(value:int):void
		{
			_points = value;
		}
		
		public function get showtime():int
		{
			return _showtime;
		}
		
		public function set showtime(value:int):void
		{
			_showtime = value;
		}
		
		[Bindable]
		public function get dead():Boolean
		{
			return _dead;
		}
		
		private function set dead(value:Boolean):void
		{
			_dead = value;
		}
		
		[Bindable]
		public function get moleType():int
		{
			return _moleType;
		}
		
		public function set moleType(value:int):void
		{
			_moleType = value;
		}
		
		public function hit():void
		{
			dead = true;
		}
		
		public function get heirarchy():String
		{
			return "Mole";
		}
	}
}