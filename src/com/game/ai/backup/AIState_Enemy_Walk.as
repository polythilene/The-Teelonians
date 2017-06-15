package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.CEnemyTeelos;
	import com.game.CPlayerTeelos;
	import com.game.IInvulnerable;
	import com.game.IRangeAttacker;
	import com.game.IStationary;
	
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Enemy_Walk extends AIState
	{
		static private var m_instance:AIState_Enemy_Walk;
		
		public function AIState_Enemy_Walk(lock:SingletonLock) 
		{
			m_stateName ="AIState_Enemy_Walk"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(2);
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			
			var player:CBaseTeelos = npc.getNearestEnemy();	// get nearest enemy
			if ( player && npc.x <= 750 )
			{
				if ( !npc.isCoolingDown() )
				{
					if ( !(npc is IStationary) )
					{
						npc.attack(player);
						if ( !(npc is IRangeAttacker) )
						{
							npc.changeAIState( AIState_Enemy_Attack.getInstance() );
						}
						else 
						{
							npc.changeAIState( AIState_Enemy_AttackRanged.getInstance() );
						}
					}
				}
				else
				{
					npc.setCurrentFrame(1);
				}
			}
			else
			{
				if ( !npc.isDestinationReached() && !npc.isDead() )
				{
					var length:Number = elapsedTime * npc.speed;
					npc.x -= (length - (length * npc.slowFactor));
					
					// slash enemy when near
					if ( !(npc is IRangeAttacker) && !CEnemyTeelos(npc).hitRun && npc.attackRange < 50 )
					{
						var enemy:CBaseTeelos = npc.getNearestEnemy();
						if ( enemy != null && !enemy.isDead() && enemy.x > npc.x && 
							(enemy.x - npc.x) < 30 && !(enemy is IInvulnerable) )
						{
							npc.attack(enemy);
							npc.changeAIState(AIState_Enemy_HitRun.getInstance());
							CEnemyTeelos(npc).hitRun = true;
						}
					}
				}
				else
				{
					npc.changeAIState(AIState_Enemy_Idle.getInstance());
				}
			}
		}
		
		static public function getInstance() : AIState_Enemy_Walk 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Enemy_Walk( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}