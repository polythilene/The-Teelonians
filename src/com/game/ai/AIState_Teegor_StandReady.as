package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.CTeeloTeegor;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Teegor_StandReady extends AIState
	{
		static private var m_instance:AIState_Teegor_StandReady;
		
		public function AIState_Teegor_StandReady(lock:SingletonLock) 
		{
			m_stateName ="AIState_Teegor_StandReady"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(1);
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			var teegor:CTeeloTeegor = CTeeloTeegor(npc);
			if ( !teegor.isCoolingDown()  )
			{
				if ( teegor.getAttackCount() < 3 )
				{
					teegor.increaseAttackCount();
					npc.changeAIState( AIState_Teegor_Attack.getInstance() );
				}
				else
				{
					teegor.resetAttackCount();
					npc.changeAIState( AIState_Teegor_Retreat.getInstance() );
				}
			}
		}
		
		static public function getInstance() : AIState_Teegor_StandReady 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Teegor_StandReady( new SingletonLock() );
            }
			return m_instance;
		}
	}
}

class SingletonLock{}