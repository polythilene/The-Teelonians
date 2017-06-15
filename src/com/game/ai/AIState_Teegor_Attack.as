package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.CTeeloTeegor;
	import math.OpMath;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Teegor_Attack extends AIState
	{
		static private var m_instance:AIState_Teegor_Attack;
		
		public function AIState_Teegor_Attack(lock:SingletonLock) 
		{
			m_stateName ="AIState_Teegor_Attack"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			var dice:int = OpMath.randomNumber(20);
			if( dice < 10 )
				npc.setCurrentFrame(4);
			else	
				npc.setCurrentFrame(5);
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			if ( npc.isAnimationComplete() )
			{
				CTeeloTeegor(npc).attackArea();
				npc.changeAIState( AIState_Teegor_StandReady.getInstance() );
			}
		}
		
		static public function getInstance() : AIState_Teegor_Attack 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Teegor_Attack( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}