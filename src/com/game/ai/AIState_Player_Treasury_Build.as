package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.CPlayerTeelos;
	import com.game.CTeeloTreasury;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Player_Treasury_Build extends AIState
	{
		static private var m_instance:AIState_Player_Treasury_Build;
		
		public function AIState_Player_Treasury_Build(lock:SingletonLock) 
		{
			m_stateName ="AIState_Player_Treasury_Build"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(2);
			CTeeloTreasury(npc).buildReady();
			CPlayerTeelos(npc).onDestinationReached();
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			
			var treasury:CTeeloTreasury = CTeeloTreasury(npc);
			if ( treasury.isBuildComplete() )
			{
				treasury.buildFinished();
				treasury.changeAIState( AIState_Player_Treasury_Idle.getInstance() );
			}
		}
		
		static public function getInstance() : AIState_Player_Treasury_Build 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Player_Treasury_Build( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}