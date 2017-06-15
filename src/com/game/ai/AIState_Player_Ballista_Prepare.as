package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.CPlayerTeelos;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Player_Ballista_Prepare extends AIState
	{
		static private var m_instance:AIState_Player_Ballista_Prepare;
		
		public function AIState_Player_Ballista_Prepare(lock:SingletonLock) 
		{
			m_stateName ="AIState_Player_Ballista_Prepare"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(2);
			CPlayerTeelos(npc).onDestinationReached();
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			if ( npc.isAnimationComplete() )
			{
				npc.changeAIState(AIState_Player_Ballista_Build.getInstance());
			}
		}
		
		static public function getInstance() : AIState_Player_Ballista_Prepare
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Player_Ballista_Prepare( new SingletonLock() );
            }
			return m_instance;
		}
	}
}

class SingletonLock{}