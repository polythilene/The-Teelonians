package com.game.ai 
{
	import com.game.CBaseTeelos;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Dead extends AIState
	{
		static private var m_instance:AIState_Dead;
		
		public function AIState_Dead(lock:SingletonLock) 
		{
			m_stateName ="AIState_Dead"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(6);
			npc.onKilled();
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			if( npc.isAnimationComplete() )
				npc.setInactive();
		}
		
		static public function getInstance() : AIState_Dead 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Dead( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}