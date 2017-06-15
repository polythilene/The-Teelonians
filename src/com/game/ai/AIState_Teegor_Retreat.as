package com.game.ai 
{
	import com.game.CBaseTeelos;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Teegor_Retreat extends AIState
	{
		static private var m_instance:AIState_Teegor_Retreat;
		
		public function AIState_Teegor_Retreat(lock:SingletonLock) 
		{
			m_stateName ="AIState_Teegor_Retreat"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(2);
			npc.setDirection(1);
			npc.setDestination(870);
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			if ( !npc.isDestinationReached() )
			{
				var length:Number = elapsedTime * npc.speed;
				npc.x += (length - (length * npc.slowFactor));
			}
			else
			{
				npc.changeAIState(AIState_Teegor_Wait.getInstance());
			}
		}
		
		static public function getInstance() : AIState_Teegor_Retreat 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Teegor_Retreat( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}