package uk.co.dubit.whackamole.models 
{
	import flash.net.SharedObject;
	import mx.collections.ArrayCollection;
	/**
	 * Just about what I was doing here.
	 * I like to record achievements in an event type structure that allows for flexibility and easy integration of additional achievements
	 * I will track the achievements based on string elements. The initial phase 'Miss' or 'Kill' ('Hit' would be a good addition)
	 * Then followed by the object types. 'Mole' being th base, then more advanced like SuperMole (which counts as either Fire or Zombie) And then into specifics
	 * 
	 * By doing this a Fire Mole (Mole.SuperMole.FireMole) would increment any achievement satisfied by 'Mole', 'Mole.SuperMole' and 'Mole.SuperMole.FireMole'
	 * @author Jeffrey T Feenstra
	 */
	public class AchievementSystem 
	{
		private var localObj:SharedObject;
		
		private var achievementProgress:String;
		private var _achievementRenderInfo:ArrayCollection = new ArrayCollection();
		private var achievementData:Vector.<RuleObject>;
		
		public function AchievementSystem() 
		{
			loadSystem();
		}
		
		private function loadSystem():void 
		{
			//localObj = SharedObject.getLocal("MoleChallenge_0");
			load();
			
			//First time opening file or unsaved progress
			if(!achievementProgress)
				achievementProgress = "000000"//Default achievement progress.
			
			resetAchievementProgress();
		}
		
		private function resetAchievementProgress():void 
		{
			achievementData = new Vector.<RuleObject>(achievementProgress.length-1);
			
			for (var i:int = 0; i < achievementProgress.length; i++)
			{
				//Uncomplete achievement
				switch (i)
				{
					case 0:
						//Achievement name: Apprentice - 
						//Criteria required: Kill over 15 moles during a single game
						if (achievementProgress.charAt(i) == "0")
						{
							achievementData[i] = new RuleObject("Kill.Mole", 15);
						}
						else
						{
							achievementData[i] = new RuleObject();
						}
						achievementData[i].title = "Apprentice";
						achievementData[i].details = "Kill over 15 moles during a single game";
						break;
						//Object "Kill.Mole"
					case 1:
						//Achievement name: Master - 
						//Criteria required: Kill more than 40 zombie moles in a single game
						//achievementData[i] = 35;
						if (achievementProgress.charAt(i) == "0")
						{
							achievementData[i] = new RuleObject("Kill.Mole", 35);
						}
						else
						{
							achievementData[i] = new RuleObject();
						}
						achievementData[i].title = "Master";
						achievementData[i].details = "Kill over 35 moles during a single game";
						break;
						//Object "Kill.Mole"
					case 2:
						//Achievement name: Mole massacre - 
						//Criteria required: Kill over 55 moles during a game
						//achievementData[i] = 55;
						if (achievementProgress.charAt(i) == "0")
						{
							achievementData[i] = new RuleObject("Kill.Mole", 55);
						}
						else
						{
							achievementData[i] = new RuleObject();
						}
						achievementData[i].title = "Mole Massacre";
						achievementData[i].details = "Kill over 55 moles during a single game";
						break;
						//Object "Kill.Mole"
					case 3:
						//Achievement name: Fireman - 
						//Criteria required: Kill more than 10 fire moles in a single game
						//achievementData[i] = 10;
						if (achievementProgress.charAt(i) == "0")
						{
							achievementData[i] = new RuleObject("Kill.Mole.SuperMole.FireMole", 10);
						}
						else
						{
							achievementData[i] = new RuleObject();
						}
						achievementData[i].title = "Fireman";
						achievementData[i].details = "Kill more than 10 fire moles in a single game";
						break;
						//Object "Kill.Mole.SuperMole.FireMole"
					case 4:
						//Achievement name: Apocolyptica - 
						//Criteria required: Kill more than 5 zombie moles in a game
						//achievementData[i] = 5;
						if (achievementProgress.charAt(i) == "0")
						{
							achievementData[i] = new RuleObject("Kill.Mole.SuperMole.Zombole", 5);
						}
						else
						{
							achievementData[i] = new RuleObject();
						}
						achievementData[i].title = "Apocolyptica";
						achievementData[i].details = "Kill more than 5 zombie moles in a game";
						break;
						//Object "Kill.Mole.SuperMole.Zombole"
					case 5:
						//Achievement name: Soft touch - 
						//Criteria required: Miss more than 30 moles during a game
						//achievementData[i] = 30;
						if (achievementProgress.charAt(i) == "0")
						{
							achievementData[i] = new RuleObject("Miss.Mole", 30);
						}
						else
						{
							achievementData[i] = new RuleObject();
						}
						achievementData[i].title = "Soft Touch";
						achievementData[i].details = "Miss more than 30 moles during a game";
						break;
						//Object "Miss.Mole"
					default:
						//Achievement name: Missing Data - 
						//Criteria required: No information
				}
				_achievementRenderInfo.addItem(achievementData[i]);
			}
		}
		
		public function evaluateAction(heriarchy:String):void
		{
			for (var i:int = 0; i < achievementData.length; i++)
			{
				if (heriarchy.indexOf(achievementData[i].rule) > -1)
				{
					if (achievementData[i].count > 0){
						//Heirarchy found, reduce count
						achievementData[i].count -= 1;
						
						if (achievementData[i].count <= 0)
						{
							//Achievement Complete
							save();//Todo: Make more efficient save.
						}
					}
				}
			}
		}
		
		public function load():void
		{
			localObj = SharedObject.getLocal("MoleChallenge_0");
			
			achievementProgress = localObj.data.progress;
		}
		
		public function save():void
		{
			localObj = SharedObject.getLocal("MoleChallenge_0");
			
			var progress:String = "";
			for (var i:int = 0; i < achievementData.length; i++)
			{
				if (achievementData[i].count <= 0)
				{
					progress = progress + "1";//Complete
				}
				else
				{
					progress = progress + "0";//Incomplete
				}
			}
			//Todo: Perhaps a slice on index the join strings with changed index value.
			
			localObj.data.progress = progress;
			localObj.flush();
		}
		
		[Bindable]
		public function get achievementRenderInfo():ArrayCollection 
		{
			return _achievementRenderInfo;
		}
		
		public function set achievementRenderInfo(value:ArrayCollection):void 
		{
			_achievementRenderInfo = value;
		}
		
	}

}