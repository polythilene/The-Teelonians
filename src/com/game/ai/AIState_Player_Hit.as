package com.game.ai 
{
	import com.game.CBaseTeelos;
	
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Player_Hit extends AIState
	{
		static private var m_instance:AIState_Player_Hit;
		
		public function AIState_Player_Hit(lock:SingletonLock) 
		{
			m_stateName ="AIState_Player_Hit"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			if ( npc.getSprite().currentFrame != 4 &&
				 npc.getSprite().currentFrame != 5 )
			{
				npc.setCurrentFrame(3);
			}
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			
			if ( npc.isAnimationComplete() )
			{
				npc.changeAIState( AIState_Player_Idle.getInstance() );
			}
		}
		
		static public function getInstance() : AIState_Player_Hit 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Player_Hit( new SingletonLock() );
            }
			return m_instance;
		}
	}
}

class SingletonLock{}