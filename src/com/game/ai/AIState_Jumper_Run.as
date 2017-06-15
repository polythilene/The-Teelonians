package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.CTeeloBarricade;
	
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_Jumper_Run extends AIState
	{
		static private var m_instance:AIState_Jumper_Run;
		
		public function AIState_Jumper_Run(lock:SingletonLock) 
		{
			m_stateName ="AIState_Jumper_Run"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(7);
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			
			if ( !npc.isDestinationReached() && !npc.isDead() )
			{
				var length:Number = elapsedTime * (npc.speed * 1.5);
				npc.x -= length - (length * npc.slowFactor);
			}
			else
			{
				npc.changeAIState(AIState_Enemy_Idle.getInstance());
			}
			
			var player:CBaseTeelos = npc.getNearestEnemy();
			if ( player )
			{
				if ( player is CTeeloBarricade )
					npc.changeAIState( AIState_Enemy_Walk.getInstance() );
				else
					npc.changeAIState( AIState_Jumper_Jump_Start.getInstance() );
			}
		}
		
		static public function getInstance() : AIState_Jumper_Run 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_Jumper_Run( new SingletonLock() );
            }
			return m_instance;
		}
		
	}
}

class SingletonLock{}