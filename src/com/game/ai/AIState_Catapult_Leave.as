package com.game.ai 
{
	import com.game.CBaseTeelos;
	
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Catapult_Leave extends AIState
	{
		static private var m_instance:AIState_Catapult_Leave;
		
		public function AIState_Catapult_Leave(lock:SingletonLock) 
		{
			m_stateName ="AIState_Catapult_Leave"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void
		{
			super.enter(npc);
			npc.setDestination(850);
			npc.setCurrentFrame(3);
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			
			if ( !npc.isDestinationReached() && !npc.isDead() )
			{
				var length:Number = elapsedTime * npc.speed;
				npc.x += length - (length * npc.slowFactor);
			}
			else
			{
				npc.setInactive();
			}
		}
		
		static public function getInstance() : AIState_Catapult_Leave 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Catapult_Leave( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}