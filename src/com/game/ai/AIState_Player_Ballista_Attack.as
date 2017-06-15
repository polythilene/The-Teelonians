package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.UNITCLASS;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Player_Ballista_Attack extends AIState
	{
		static private var m_instance:AIState_Player_Ballista_Attack;
		
		public function AIState_Player_Ballista_Attack(lock:SingletonLock) 
		{
			m_stateName ="AIState_Player_Ballista_Attack"
			m_enableTimeOut = false;
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			
			if ( npc.isAnimationComplete() )
			{
				npc.releaseProjectile();
				npc.changeAIState( AIState_Player_Ballista_Idle.getInstance() );
			}	
		}
		
		static public function getInstance() : AIState_Player_Ballista_Attack 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Player_Ballista_Attack( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}