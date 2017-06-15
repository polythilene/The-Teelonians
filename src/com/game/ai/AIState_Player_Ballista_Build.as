package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.CPlayerTeelos;
	import com.game.CTeeloBallistaTower;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Player_Ballista_Build extends AIState
	{
		static private var m_instance:AIState_Player_Ballista_Build;
		
		public function AIState_Player_Ballista_Build(lock:SingletonLock) 
		{
			m_stateName ="AIState_Player_Ballista_Build"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(6);
			CTeeloBallistaTower(npc).buildReady();
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			
			var tower:CTeeloBallistaTower = CTeeloBallistaTower(npc);
			if ( tower.isBuildComplete() )
			{
				tower.buildFinished();
				tower.changeAIState( AIState_Player_Ballista_Idle.getInstance() );
			}
		}
		
		static public function getInstance() : AIState_Player_Ballista_Build 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Player_Ballista_Build( new SingletonLock() );
            }
			return m_instance;
		}
	}
}

class SingletonLock{}