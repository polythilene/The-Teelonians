package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.UNITCLASS;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Enemy_HitRun extends AIState
	{
		static private var m_instance:AIState_Enemy_HitRun;
		
		public function AIState_Enemy_HitRun(lock:SingletonLock) 
		{
			m_stateName ="AIState_Enemy_HitRun"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			
			if ( npc.isAnimationComplete() )
			{
				npc.changeAIState( AIState_Enemy_Walk.getInstance() );
			}
		}
		
		static public function getInstance() : AIState_Enemy_HitRun 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Enemy_HitRun( new SingletonLock() );
            }
			return m_instance;
		}
	}
}

class SingletonLock{}