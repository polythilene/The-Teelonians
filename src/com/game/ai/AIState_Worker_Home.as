package com.game.ai 
{
	import com.game.CBaseTeelos;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Worker_Home extends AIState
	{
		static private var m_instance:AIState_Worker_Home;
		
		public function AIState_Worker_Home(lock:SingletonLock) 
		{
			m_stateName ="AIState_Worker_Home"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(1);
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			if ( !npc.isDestinationReached() )
			{
				npc.x -= elapsedTime * npc.speed;
			}
			else
			{
				npc.setInactive();
			}
		}
		
		static public function getInstance() : AIState_Worker_Home 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Worker_Home( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}