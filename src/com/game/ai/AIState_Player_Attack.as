package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.IJumper;
	import com.game.IRangeAttacker;
	import com.game.UNITCLASS;
	import math.OpMath;
	
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Player_Attack extends AIState
	{
		static private var m_instance:AIState_Player_Attack;
		
		public function AIState_Player_Attack(lock:SingletonLock) 
		{
			m_stateName ="AIState_Player_Attack"
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
				npc.changeAIState( AIState_Player_Idle.getInstance() );
			}
		}
		
		static public function getInstance() : AIState_Player_Attack 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Player_Attack( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}