package com.game.ai 
{
	import com.game.CBaseTeelos;
	
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Player_Trap_Idle extends AIState
	{
		static private var m_instance:AIState_Player_Trap_Idle;
		
		public function AIState_Player_Trap_Idle(lock:SingletonLock) 
		{
			m_stateName ="AIState_Player_Trap_Idle"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(3);
		}
		
		static public function getInstance() : AIState_Player_Trap_Idle 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Player_Trap_Idle( new SingletonLock() );
            }
			return m_instance;
		}
	}
}

class SingletonLock{}