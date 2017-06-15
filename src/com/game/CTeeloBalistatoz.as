package com.game
{
	import com.game.ai.AIState_Balistatoz_Destroy;
	import com.game.ai.AIState_Balistatoz_Enter;
	import com.game.ai.AIState_Catapult_Enter;
	import com.game.CEnemyTeelos;
	import flash.display.DisplayObjectContainer;

	/**
	 * @author poof!
	 * @version 1.0
	 * @created 05-Jan-2011 18:59:58
	 */
	public class CTeeloBalistatoz extends CEnemyTeelos implements IRangeAttacker
	{
		public function CTeeloBalistatoz(){
		}
		
		override public function initialize():void 
		{
			super.initialize();
			
			m_attack = 5;
			m_defense = 2;
			m_maxLife = 30;
			m_unitClass = UNITCLASS.SIEGE;
			m_counterClass = UNITCLASS.BUILDING;
			m_counterBonus = 10;
			m_baseSpeed = 0.12;
			m_baseCooldownTime = 20000;
		}
	
		override protected function createSprite():void 
		{
			super.createSprite();
			m_sprite = new mcTeelo_Balistatoz();
		}
		
		override public function onCreate(lane:int, xPos:int, container:DisplayObjectContainer):void 
		{
			super.onCreate(lane, xPos, container);
			m_attackRange = 600;
			setDestination(750);
			changeAIState(AIState_Balistatoz_Enter.getInstance());
		}
		
		override public function animationHit():void 
		{
			// do nothing
		}
		
		override public function releaseProjectile():void
		{
			super.releaseProjectile();
			m_cooldownCounter = 0;
			MissileManager.getInstance().launch( CMissileBallista_Balistatoz, m_container, m_sprite.x, m_sprite.y - 45, 
												 m_sprite.scaleX, getFaction(), m_lane,
												 m_attack, m_counterClass, m_counterBonus, m_level, m_detectInvisible, this );
		}
		
		override public function damage(value:int, source:CBaseTeelos):void 
		{
			if ( value > 0 )
			{
				var def:int = Math.ceil( defense / 2 );
				var dmg:int = (def > value) ? 1 : value - def;
			}
			else
			{
				dmg = value;
			}
			if (dmg == 0) dmg = 1;
			
			m_currLife -= dmg;
			if( m_currLife < 0 )
			{
				m_dead = true;
				changeAIState( AIState_Balistatoz_Destroy.getInstance() );
			}
			
			m_currLife = Math.min(m_currLife, m_maxLife);		// cap value when unit is healed
			
			// tint sprite
			var col:int = (value > 0) ? 0xFF0000 : 0x00FF00;
			tintOnHit(col);
		}

	}

}