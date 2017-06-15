package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.UNITCLASS;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Jumper_Jump_Land extends AIState
	{
		static private var m_instance:AIState_Jumper_Jump_Land;
		
		public function AIState_Jumper_Jump_Land(lock:SingletonLock) 
		{
			m_stateName ="AIState_Jumper_Jump_Land"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(10);
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			
			if ( npc.isAnimationComplete() )
			{
				npc.changeAIState( AIState_Enemy_Walk.getInstance() );
			}
		}
		
		static public function getInstance() : AIState_Jumper_Jump_Land 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Jumper_Jump_Land( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}