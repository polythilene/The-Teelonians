package com.game.ai 
{
	import com.game.CBaseTeelos;
	import math.OpMath;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Teegor_Hit extends AIState
	{
		static private var m_instance:AIState_Teegor_Hit;
		
		public function AIState_Teegor_Hit(lock:SingletonLock) 
		{
			m_stateName ="AIState_Teegor_Hit"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(3);
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
		}
		
		static public function getInstance() : AIState_Teegor_Hit 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Teegor_Hit( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}