package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.CTeeloLastBarricade;
	import com.game.CTeeloPoztazark;
	import com.game.CTeeloWeezee;
	import com.game.FACTION;
	import math.OpMath;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Enemy_Idle extends AIState
	{
		static private var m_instance:AIState_Enemy_Idle;
		
		public function AIState_Enemy_Idle(lock:SingletonLock) 
		{
			m_stateName ="AIState_Enemy_Idle"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(1);
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			if ( !npc.isDestinationReached() )
			{
				npc.changeAIState( AIState_Enemy_Walk.getInstance() );
			}
			else 
			{
				if ( npc is CTeeloPoztazark )
				{
					// poztazark will heal wounded unit
					if ( !npc.isCoolingDown() )
					{
						var wounded:CBaseTeelos = null;
						var list:Array = NPCManager.getInstance().getListOfUnit(npc.laneIndex, NPCManager.FACTION_ENEMY);
						if ( list.length > 0 )
						{
							wounded = CBaseTeelos(list[0]);
							
							// heal
							if ( !npc.isCoolingDown() && wounded.lifePercentage < 1 )
							{
								npc.attack( wounded );
								npc.changeAIState( AIState_Enemy_Heal.getInstance() );
							}
						}
					}
				}
				else if ( npc is CTeeloWeezee )
				{
					// cast fireball
					if ( !npc.isCoolingDown() )
					{
						var playerList:Array = NPCManager.getInstance().getListOfUnit(npc.laneIndex, NPCManager.FACTION_PLAYER);
						if ( playerList.length > 0 )
						{
							var index:int = Math.floor(OpMath.randomNumber(playerList.length - 1));
							var player:CBaseTeelos = CBaseTeelos(playerList[index]);
							if ( player && !player.isDead() && npc.x < 800 && !(player is CTeeloLastBarricade) )
							{
								npc.attack(player);
								npc.changeAIState( AIState_Enemy_AttackRanged.getInstance() );
							}
						}
					}
				}
			}
		}
		
		static public function getInstance() : AIState_Enemy_Idle 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Enemy_Idle( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}