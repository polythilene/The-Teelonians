package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.CTeeloCaplozton;
	import com.game.CTeeloCaploztonCatapult;
	import com.game.CTeeloPoztazark;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Balistatoz_Idle extends AIState
	{
		static private var m_instance:AIState_Balistatoz_Idle;
		
		public function AIState_Balistatoz_Idle(lock:SingletonLock) 
		{
			m_stateName ="AIState_Balistatoz_Idle"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(1);
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			if ( !npc.isCoolingDown() )
			{
				var teelo:CBaseTeelos = NPCManager.getInstance().getNearestEnemy(npc);
				if ( teelo )
				{
					npc.changeAIState( AIState_Balistatoz_Attack.getInstance() );
				}
			}
		}
		
		static public function getInstance() : AIState_Balistatoz_Idle 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Balistatoz_Idle( new SingletonLock() );
            }
			return m_instance;
		}
	}
}

class SingletonLock{}