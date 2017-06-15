package com.game.ai 
{
	import com.game.CBaseTeelos;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Teegor_Summon extends AIState
	{
		static private var m_instance:AIState_Teegor_Summon;
		
		public function AIState_Teegor_Summon(lock:SingletonLock) 
		{
			m_stateName ="AIState_Teegor_Summon"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(4);
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
		}
		
		static public function getInstance() : AIState_Teegor_Summon 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Teegor_Summon( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}