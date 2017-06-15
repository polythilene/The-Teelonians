package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.CEnemyTeelos;
	import com.game.CTeeloBaseSummoned;
	import com.game.CTeeloSeeldy;
	import com.game.CTeeloTeegor;
	import com.game.CTeeloTeemy;
	import com.game.IInvulnerable;
	import com.game.IJumper;
	import com.game.IRangeAttacker;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Player_Walk extends AIState
	{
		static private var m_instance:AIState_Player_Walk;
		
		public function AIState_Player_Walk(lock:SingletonLock) 
		{
			m_stateName ="AIState_Player_Walk"
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
			if ( !npc.isDestinationReached() )
			{
				npc.x += elapsedTime * npc.speed;
				
				if( npc is CTeeloSeeldy )
				{
					var list:Array = NPCManager.getInstance().getListOfUnit(npc.laneIndex, NPCManager.FACTION_ENEMY);
					if( list.length > 0 )
					{
						for ( var i:int = 0; i < list.length; i++ )
						{
							var enemy:CEnemyTeelos = CEnemyTeelos( list[i] );
							if ( !enemy.isDead() && enemy.x > npc.x && (enemy.x - npc.x) < 30 )
							{
								enemy.knockBack(5);
							}
						}
					}
				}
				else if( npc is CTeeloTeemy && !CTeeloTeemy(npc).bashInitiated )
				{
					enemy = CEnemyTeelos(npc.getNearestEnemy()); 
					if ( enemy != null && !enemy.isDead() && enemy.x > npc.x && (enemy.x - npc.x) < 30 && 
						 !(enemy is IInvulnerable) && !(enemy is IRangeAttacker) && 
						 !(enemy is IJumper && !IJumper(enemy).hasLanded()) && !(enemy is CTeeloTeegor) )
					{
						enemy.knockBack(200, true);
						CTeeloTeemy(npc).bashInitiated = true;
						CTeeloTeemy(npc).changeAIState(AIState_Player_Bash.getInstance());
					}
				}
				else if ( npc is CTeeloBaseSummoned )
				{
					enemy = CEnemyTeelos(NPCManager.getInstance().getNearestEnemy(npc));
					if( enemy != null && 
						!(enemy is IJumper && !IJumper(enemy).hasLanded()) &&
					    !(enemy is IInvulnerable) && !(npc.isCoolingDown()) )
					{
						npc.attack( enemy );
						npc.changeAIState(AIState_Player_Attack.getInstance());
					}
				}
			}
			else
			{
				npc.changeAIState(AIState_Player_Idle.getInstance());
			}
		}
		
		static public function getInstance() : AIState_Player_Walk 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Player_Walk( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}