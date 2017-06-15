package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.IStationary;
	import com.game.UNITCLASS;
	import math.OpMath;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Enemy_AttackRanged extends AIState
	{
		static private var m_instance:AIState_Enemy_AttackRanged;
		
		public function AIState_Enemy_AttackRanged(lock:SingletonLock) 
		{
			m_stateName ="AIState_Enemy_AttackRanged"
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
				if( !npc.isProjectileReleased() )
					npc.releaseProjectile();
				
				if ( npc is IStationary )
				{
					npc.changeAIState( AIState_Enemy_Idle.getInstance() );
				}
				else
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
					{
						npc.changeAIState( AIState_Enemy_Idle.getInstance() );
					}
				}
			}
		}
		
		static public function getInstance() : AIState_Enemy_AttackRanged 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Enemy_AttackRanged( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}