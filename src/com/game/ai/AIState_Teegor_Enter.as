package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.CTeeloTeegor;
	import math.OpMath;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Teegor_Enter extends AIState
	{
		static private var m_instance:AIState_Teegor_Enter;
		
		public function AIState_Teegor_Enter(lock:SingletonLock) 
		{
			m_stateName ="AIState_Teegor_Enter"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(2);
			npc.setDirection( -1);
			CTeeloTeegor(npc).changeLane();
			npc.setDestination(720);
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			if ( !npc.isDestinationReached() )
			{
				var length:Number = elapsedTime * npc.speed;
				npc.x -= (length - (length * npc.slowFactor));
			}
			else
			{
				npc.changeAIState( AIState_Teegor_StandReady.getInstance() );
			}
		}
		
		static public function getInstance() : AIState_Teegor_Enter 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Teegor_Enter( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}