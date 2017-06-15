package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.CPlayerTeelos;
	import com.game.CTeeloBaseBuilding;
	import com.game.CTeeloTrap;
	import com.game.CTeeloUgee;
	import com.game.IInvulnerable;
	import com.game.IJumper;
	import com.game.IRangeAttacker;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Player_Idle extends AIState
	{
		static private var m_instance:AIState_Player_Idle;
		
		public function AIState_Player_Idle(lock:SingletonLock) 
		{
			m_stateName ="AIState_Player_Idle"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(1);
			CPlayerTeelos(npc).onDestinationReached();
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			if ( !npc.isDestinationReached() )
			{
				npc.changeAIState( AIState_Player_Walk.getInstance() );
			}
			else
			{
				if ( npc is CTeeloUgee )
				{
					// ugee will heal wounded unit
					var wounded:CBaseTeelos = null;
					var list:Array = NPCManager.getInstance().getListOfUnit(npc.laneIndex, NPCManager.FACTION_PLAYER);
					if ( list.length > 0 )
					{
						wounded = CBaseTeelos(list[0]);
						
						// heal
						if( !npc.isCoolingDown() && !(wounded is CTeeloBaseBuilding) && 
							!(wounded is CTeeloTrap) && wounded.lifePercentage < 1 )
						{
							npc.attack( wounded );
							npc.changeAIState( AIState_Player_Heal.getInstance() );
						}
					}
				}
				else
				{
					// other will attack
					var enemy:CBaseTeelos = npc.getNearestEnemy();
					
					if ( !npc.isCoolingDown() && enemy && 
						 !(enemy is IJumper && !IJumper(enemy).hasLanded()) && 
						 !(enemy is IInvulnerable) )
					{
						if ( npc is IRangeAttacker )	  
						{
							if ( !npc.isProjectileReleased() )
							{
								npc.attack( enemy );
								npc.changeAIState( AIState_Player_AttackRanged.getInstance() );
							}
						}
						else
						{
							npc.attack( enemy );
							npc.changeAIState( AIState_Player_Attack.getInstance() );
						}
					}
				}
			}
		}
		
		static public function getInstance() : AIState_Player_Idle 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Player_Idle( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}