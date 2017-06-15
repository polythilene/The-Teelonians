package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.CEnemyTeelos;
	import com.game.CPlayerTeelos;
	import com.game.CTeeloBaseSummoned;
	import com.game.CTeeloSeeldy;
	import com.game.IInvulnerable;
	import com.game.IJumper;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Player_Swap extends AIState
	{
		static private var m_instance:AIState_Player_Swap;
		
		public function AIState_Player_Swap(lock:SingletonLock) 
		{
			m_stateName ="AIState_Player_Swap"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(2);
			CPlayerTeelos(npc).swapping = true;
			
			if( npc.x < npc.getDestination() )
				npc.setDirection( 1);
			else	
				npc.setDirection( -1);
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			if ( !npc.isDestinationReached() )
			{
				npc.x += (elapsedTime * npc.speed) * npc.getDirection();
			}
			else
			{
				npc.setDirection(1);
				CPlayerTeelos(npc).swapping = false;
				npc.changeAIState(AIState_Player_Idle.getInstance());
			}
		}
		
		static public function getInstance() : AIState_Player_Swap 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Player_Swap( new SingletonLock() );
            }
			return m_instance;
		}
	}
}

class SingletonLock{}