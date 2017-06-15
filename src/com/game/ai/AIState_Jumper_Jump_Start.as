package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.UNITCLASS;
	import com.game.CTeeloUmaz;
	
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Jumper_Jump_Start extends AIState
	{
		static private var m_instance:AIState_Jumper_Jump_Start;
		
		public function AIState_Jumper_Jump_Start(lock:SingletonLock) 
		{
			m_stateName ="AIState_Jumper_Jump_Start"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(9);
			
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			
			if ( npc.isAnimationComplete() )
			{
				npc.changeAIState( AIState_Jumper_Jump_Air.getInstance() );
			}
		}
		
		static public function getInstance() : AIState_Jumper_Jump_Start 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Jumper_Jump_Start( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}