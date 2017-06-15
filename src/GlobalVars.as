package
{
	import com.game.CBaseTeelos;
	/**
	 * ...
	 * @author Wiwitt
	 */
	public class GlobalVars
	{
		// DATA
		static public var TOTAL_COIN:int = 200;
		static public var RESEARCH_POINT:int = 0;
		
		// GAME VARS
		static public var CURRENT_LEVEL:int;
		static public var CURRENT_SUB_LEVEL:int;
		static public var IS_VICTORY:Boolean = true;
		static public var CUSTOM_CURSOR:Boolean = true;
		
		//static public var LEVEL:int = 1;					//	dari siput
		
		static public function getLevelGlobal():int
		{
			var ret:int;
			switch(CURRENT_LEVEL)
			{
				case 0:
						ret = CURRENT_SUB_LEVEL + 1; break;
				case 1:
						ret = CURRENT_SUB_LEVEL + 6; break;
				case 2:
						ret = CURRENT_SUB_LEVEL + 11; break;
				case 3:
						ret = CURRENT_SUB_LEVEL + 16; break;		
			}
			
			return ret;
		}
		
		// STAT DATA (AFTER PLAY)
		static public var UNIT_BONUS:int = 100;
		static public var KILL_SCORE:int;
		static public var RES_POINT_GAIN:int;
		
		// UNIT LOCK STATUS
		static public var UNLOCKED_TEEMY:Boolean 		= true;
		static public var UNLOCKED_LEEGOS:Boolean		= false;
		static public var UNLOCKED_SEELDY:Boolean		= false;
		static public var UNLOCKED_AGEESUM:Boolean		= false;
		static public var UNLOCKED_FEELA:Boolean		= false;	
		static public var UNLOCKED_ELONEE:Boolean		= false;
		static public var UNLOCKED_ENDROGEE:Boolean		= false;
		static public var UNLOCKED_UGEE:Boolean			= false;	
		static public var UNLOCKED_BARRICADE:Boolean	= false;
		static public var UNLOCKED_TREASURY:Boolean		= true;
		static public var UNLOCKED_TRAP:Boolean			= false;
		static public var UNLOCKED_BALLISTA:Boolean		= false;
		
		// ROLLBACK STATUS
		static public var LAST_RESEARCH_POINT:int 		= 0;
		static public var LAST_STATE_LEEGOS:Boolean		= false;
		static public var LAST_STATE_SEELDY:Boolean		= false;
		static public var LAST_STATE_AGEESUM:Boolean	= false;
		static public var LAST_STATE_FEELA:Boolean		= false;	
		static public var LAST_STATE_ELONEE:Boolean		= false;
		static public var LAST_STATE_ENDROGEE:Boolean	= false;
		static public var LAST_STATE_UGEE:Boolean		= false;	
		static public var LAST_STATE_BARRICADE:Boolean	= false;
		static public var LAST_STATE_TREASURY:Boolean	= false;
		static public var LAST_STATE_TRAP:Boolean		= false;
		static public var LAST_STATE_BALLISTA:Boolean	= false;
		
		static public var LAST_ASSET_STATE:int			= 0;
		static public var LAST_GOLD_STATE:int			= 0;
		// ....
		
		//GOLD TRIBUTE
		static public var LEVEL_DONATION:Array = [ [250, 350, 500 , 750, 1000], 
												   [3000,4000,5000,6000,7000],
												   [7000, 8000, 9000, 10000],
												   [10000, 10000, 10000, 10000],
												   [25000] ];
												   
												   
		// BOSS FIGHT
		static public var BOSS_INSTANCE:CBaseTeelos = null;
		
	}
}