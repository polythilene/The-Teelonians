package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.UNITCLASS;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Balistatoz_Destroy extends AIState
	{
		static private var m_instance:AIState_Balistatoz_Destroy;
		
		public function AIState_Balistatoz_Destroy(lock:SingletonLock) 
		{
			m_stateName ="AIState_Balistatoz_Destroy"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(4);
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			
			if ( npc.isAnimationComplete() )
			{
				npc.setInactive();
			}	
		}
		
		static public function getInstance() : AIState_Balistatoz_Destroy 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Balistatoz_Destroy( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}