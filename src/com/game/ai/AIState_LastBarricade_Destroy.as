package com.game.ai 
{
	import com.game.CBaseTeelos;
	import com.game.IJumper;
	import com.game.fx.CEffect_Barrage;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class AIState_LastBarricade_Destroy extends AIState
	{
		static private var m_instance:AIState_LastBarricade_Destroy;
		
		public function AIState_LastBarricade_Destroy(lock:SingletonLock) 
		{
			m_stateName ="AIState_LastBarricade_Destroy"
			m_enableTimeOut = false;
		}
		
		override public function enter(npc:CBaseTeelos):void 
		{
			super.enter(npc);
			npc.setCurrentFrame(3);
		}
		
		override public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			super.update(npc, elapsedTime);
			if (npc.isAnimationComplete())
			{
				var enemy:CBaseTeelos = npc.getNearestEnemy();
				if ( enemy && !(enemy is IJumper && !IJumper(enemy).hasLanded()) )
				{
					ParticleManager.getInstance().add(CEffect_Barrage, npc.x, npc.y);
					npc.attack(enemy);
				}
				npc.setInactive();
				//npc.setInactive();
			}
		}
		
		static public function getInstance() : AIState_LastBarricade_Destroy 
		{
			if ( m_instance == null )
			{
            	m_instance = new AIState_LastBarricade_Destroy( new SingletonLock() );
            }
			return m_instance;
		}
	}
}

class SingletonLock{}