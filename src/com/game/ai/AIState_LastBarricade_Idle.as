package com.game.ai 
{
	import com.game.CBaseTeelos;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_LastBarricade_Idle extends AIState
	{
		static private var m_instance:AIState_LastBarricade_Idle;
		
		public function AIState_LastBarricade_Idle(lock:SingletonLock) 
		{
			m_stateName ="AIState_LastBarricade_Idle"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(1);
		}
		
		static public function getInstance() : AIState_LastBarricade_Idle 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_LastBarricade_Idle( new SingletonLock() );
            }
			return m_instance;
		}
	}
}

class SingletonLock{}