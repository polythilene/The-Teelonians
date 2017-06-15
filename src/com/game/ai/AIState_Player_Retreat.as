package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.CEnemyTeelos;
	import com.game.CTeeloBaseSummoned;
	import com.game.CTeeloSeeldy;
	import com.game.IInvulnerable;
	import com.game.IJumper;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Player_Retreat extends AIState
	{
		static private var m_instance:AIState_Player_Retreat;
		
		public function AIState_Player_Retreat(lock:SingletonLock) 
		{
			m_stateName ="AIState_Player_Retreat"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(2);
			npc.setDirection( -1);
			npc.setDestination( -50);
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			if ( !npc.isDestinationReached() )
			{
				npc.x -= elapsedTime * npc.speed;
			}
			else
			{
				npc.setInactive();
			}
		}
		
		static public function getInstance() : AIState_Player_Retreat 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Player_Retreat( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}