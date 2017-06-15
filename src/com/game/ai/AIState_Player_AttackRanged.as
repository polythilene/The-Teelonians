package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.UNITCLASS;
	import math.OpMath;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Player_AttackRanged extends AIState
	{
		static private var m_instance:AIState_Player_AttackRanged;
		
		public function AIState_Player_AttackRanged(lock:SingletonLock) 
		{
			m_stateName ="AIState_Player_AttackRanged"
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
			
			if ( npc.isAnimationComplete() && !npc.isProjectileReleased() )
			{
				npc.releaseProjectile();
				npc.changeAIState( AIState_Player_Idle.getInstance() );
			}
		}
		
		static public function getInstance() : AIState_Player_AttackRanged 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Player_AttackRanged( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}