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
	public class AIState_Catapult_Throw extends AIState
	{
		static private var m_instance:AIState_Catapult_Throw;
		
		public function AIState_Catapult_Throw(lock:SingletonLock) 
		{
			m_stateName ="AIState_Catapult_Throw"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			CTeeloCaploztonCatapult(npc).readyThrow();
			npc.setCurrentFrame(2);
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			if ( npc.isAnimationComplete() )
			{
				npc.changeAIState( AIState_Catapult_Leave.getInstance() );
			}
		}
		
		static public function getInstance() : AIState_Catapult_Throw 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Catapult_Throw( new SingletonLock() );
            }
			return m_instance;
		}
	}
}

class SingletonLock{}