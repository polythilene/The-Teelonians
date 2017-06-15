package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.CTeeloCaplozton;
	
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Catapult_Fly extends AIState
	{
		static private var m_instance:AIState_Catapult_Fly;
		
		public function AIState_Catapult_Fly(lock:SingletonLock) 
		{
			m_stateName ="AIState_Catapult_Fly"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(7);
			CTeeloCaplozton(npc).fly();
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			
			if ( CTeeloCaplozton(npc).hasLanded() )
			{
				npc.changeAIState(AIState_Enemy_Idle.getInstance());
			}
		}
		
		static public function getInstance() : AIState_Catapult_Fly 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Catapult_Fly( new SingletonLock() );
            }
			return m_instance;
		}
	}
}

class SingletonLock{}