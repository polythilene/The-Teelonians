package com.game.ai 
{
	import com.game.CBaseTeelos;
	
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Player_Trap_Broken extends AIState
	{
		static private var m_instance:AIState_Player_Trap_Broken;
		
		public function AIState_Player_Trap_Broken(lock:SingletonLock) 
		{
			m_stateName ="AIState_Player_Trap_Broken"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(5);
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			if ( npc.isAnimationComplete() )
			{
				npc.setInactive();
			}
		}
		
		static public function getInstance() : AIState_Player_Trap_Broken 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Player_Trap_Broken( new SingletonLock() );
            }
			return m_instance;
		}
	}
}

class SingletonLock{}