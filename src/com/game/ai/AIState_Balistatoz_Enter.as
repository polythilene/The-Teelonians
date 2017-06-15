package com.game.ai 
{
	import com.game.CBaseTeelos;
	
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Balistatoz_Enter extends AIState
	{
		static private var m_instance:AIState_Balistatoz_Enter;
		
		public function AIState_Balistatoz_Enter(lock:SingletonLock) 
		{
			m_stateName = "AIState_Balistatoz_Enter";
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(2);
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			
			if( !npc.isDestinationReached() && !npc.isDead() )
			{
				var length:Number = elapsedTime * npc.speed;
				npc.x -= length - (length * npc.slowFactor);
			}
			else
			{
				npc.changeAIState(AIState_Balistatoz_Idle.getInstance());
			}
		}
		
		static public function getInstance() : AIState_Balistatoz_Enter 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Balistatoz_Enter( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}