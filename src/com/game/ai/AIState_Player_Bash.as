package com.game.ai 
{
	import com.game.CBaseTeelos;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Player_Bash extends AIState
	{
		static private var m_instance:AIState_Player_Bash;
		
		public function AIState_Player_Bash(lock:SingletonLock) 
		{
			m_stateName ="AIState_Player_Bash"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(5);
			SoundManager.getInstance().playSFX("bash");
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			if( npc.isAnimationComplete() )
			{
				npc.changeAIState( AIState_Player_Walk.getInstance() );
			}
		}
		
		static public function getInstance() : AIState_Player_Bash 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Player_Bash( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}