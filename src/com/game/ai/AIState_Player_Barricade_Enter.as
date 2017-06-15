package com.game.ai 
{
	import com.game.CBaseTeelos;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Player_Barricade_Enter extends AIState
	{
		static private var m_instance:AIState_Player_Barricade_Enter;
		
		public function AIState_Player_Barricade_Enter(lock:SingletonLock) 
		{
			m_stateName ="AIState_Player_Barricade_Enter"
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
			if ( !npc.isDestinationReached() )
			{
				npc.x += elapsedTime * npc.speed;
			}
			else
			{
				npc.changeAIState(AIState_Player_Barricade_Build.getInstance());
			}
		}
		
		static public function getInstance() : AIState_Player_Barricade_Enter 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Player_Barricade_Enter( new SingletonLock() );
            }
			return m_instance;
		}
	}
}

class SingletonLock{}