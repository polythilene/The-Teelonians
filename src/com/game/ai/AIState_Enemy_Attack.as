package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.IRangeAttacker;
	import math.OpMath;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Enemy_Attack extends AIState
	{
		static private var m_instance:AIState_Enemy_Attack;
		
		public function AIState_Enemy_Attack(lock:SingletonLock) 
		{
			m_stateName ="AIState_Enemy_Attack"
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
				var player:CBaseTeelos = npc.getNearestEnemy();
				if ( player )
				{
					if ( npc.isCoolingDown() )
					{
						npc.setCurrentFrame(1);
					}
					else
					{
						var dice:int = OpMath.randomNumber(6);
						var frame:int = ( dice < 3 ) ? 4 : 5;
						npc.setCurrentFrame(frame);
						npc.attack(player);
					}
				}
				else
					npc.changeAIState( AIState_Enemy_Idle.getInstance() );
			}
		}
		
		static public function getInstance() : AIState_Enemy_Attack 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Enemy_Attack( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}