package com.game.ai 
{
	import com.game.CBaseTeelos;
	import math.OpMath;
	
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Enemy_Heal extends AIState
	{
		static private var m_instance:AIState_Enemy_Heal;
		
		public function AIState_Enemy_Heal(lock:SingletonLock) 
		{
			m_stateName ="AIState_Enemy_Heal"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			
			var dice:int = OpMath.randomNumber(6);
			var frame:int = ( dice < 3 ) ? 4 : 5;
			npc.setCurrentFrame(frame);
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			
			if ( npc.isAnimationComplete() )
			{
				npc.changeAIState( AIState_Enemy_Idle.getInstance() );
			}
		}
		
		static public function getInstance() : AIState_Enemy_Heal 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Enemy_Heal( new SingletonLock() );
            }
			return m_instance;
		}
	}
}

class SingletonLock{}