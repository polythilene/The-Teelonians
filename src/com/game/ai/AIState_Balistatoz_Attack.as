package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.UNITCLASS;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Balistatoz_Attack extends AIState
	{
		static private var m_instance:AIState_Balistatoz_Attack;
		
		public function AIState_Balistatoz_Attack(lock:SingletonLock) 
		{
			m_stateName ="AIState_Balistatoz_Attack"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(3);
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			
			if ( npc.isAnimationComplete() )
			{
				npc.releaseProjectile();
				npc.changeAIState( AIState_Balistatoz_Idle.getInstance() );
			}	
		}
		
		static public function getInstance() : AIState_Balistatoz_Attack 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Balistatoz_Attack( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}