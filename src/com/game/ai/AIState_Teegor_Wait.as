package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.CTeeloTeegor;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Teegor_Wait extends AIState
	{
		static private var m_instance:AIState_Teegor_Wait;
		
		public function AIState_Teegor_Wait(lock:SingletonLock) 
		{
			m_stateName ="AIState_Teegor_Wait"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(1);
			CTeeloTeegor(npc).resetWaitTime();
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			CTeeloTeegor(npc).updateWaitTime(elapsedTime);
			if ( CTeeloTeegor(npc).getWaitTime() > 10000 )
			{
				npc.changeAIState( AIState_Teegor_Enter.getInstance() );
			}
		}
		
		static public function getInstance() : AIState_Teegor_Wait 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Teegor_Wait( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}