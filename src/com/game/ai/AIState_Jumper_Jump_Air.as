package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.UNITCLASS;
	import com.game.CTeeloUmaz;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Jumper_Jump_Air extends AIState
	{
		static private var m_instance:AIState_Jumper_Jump_Air;
		
		public function AIState_Jumper_Jump_Air(lock:SingletonLock) 
		{
			m_stateName ="AIState_Jumper_Jump_Air"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			CTeeloUmaz(npc).doJump();
			npc.setCurrentFrame(8);
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			
			if ( npc.isAnimationComplete() )
			{
				npc.changeAIState( AIState_Jumper_Jump_Land.getInstance() );
			}
		}
		
		static public function getInstance() : AIState_Jumper_Jump_Air 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Jumper_Jump_Air( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}