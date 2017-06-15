package com.game.ai 
{
	import com.game.CBaseLinearMissile;
	import com.game.CBaseTeelos;
	import com.game.CEnemyTeelos;
	import com.game.CPlayerTeelos;
	import com.game.CTeeloBaseSummoned;
	import com.game.CTeeloSeeldy;
	import com.game.CTeeloTrap;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Player_Trap_Build extends AIState
	{
		static private var m_instance:AIState_Player_Trap_Build;
		
		public function AIState_Player_Trap_Build(lock:SingletonLock) 
		{
			m_stateName ="AIState_Player_Trap_Build"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(2);
			CTeeloTrap(npc).buildReady();
			CPlayerTeelos(npc).onDestinationReached();
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			
			var trap:CTeeloTrap = CTeeloTrap(npc);
			if ( trap.isBuildComplete() )
			{
				trap.buildFinished();
				trap.changeAIState( AIState_Player_Trap_Idle.getInstance() );
			}
		}
		
		static public function getInstance() : AIState_Player_Trap_Build 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Player_Trap_Build( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}