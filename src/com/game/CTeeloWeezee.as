package com.game
{
	import com.game.ai.AIState;
	import com.game.CEnemyTeelos;
	import flash.display.DisplayObjectContainer;

	/**
	 * @author poof!
	 * @version 1.0
	 * @created 21-Dec-2010 4:07:55 PM
	 */
	public class CTeeloWeezee extends CEnemyTeelos implements IRangeAttacker, IStationary
	{
		public function CTeeloWeezee(){}
		
		override public function initialize():void 
		{
			super.initialize();
			
			m_attack = 5;
			m_defense = 1;
			m_maxLife = 10;
			m_unitClass = UNITCLASS.MAGE;
			m_counterClass = UNITCLASS.INFANTRY;
			m_counterBonus = 5;
			m_baseSpeed = 0.07;
			m_dropMin = 4;
			m_dropMax = 6;
			m_baseCooldownTime = 5000;
		}
		
		override protected function createSprite():void 
		{
			super.createSprite();
			m_attackRange = 800;
			m_sprite = new mcTeelo_Weezee();
		}
		
		override public function onCreate(lane:int, targetPosX:int, container:DisplayObjectContainer):void 
		{
			super.onCreate(lane, targetPosX, container);
			
			setDestination(720);
			m_attackRange = 800;
		}
		
		override public function releaseProjectile():void
		{
			super.releaseProjectile();
			
			MissileManager.getInstance().launch( CMissileFireball_Weezee, m_container, m_sprite.x, m_sprite.y - 45, 
												 1, getFaction(), m_lane,
												 m_attack, m_counterClass, m_counterBonus, m_level, m_detectInvisible, this,
												 {target:m_target, groundLevel:y} );
		}
	}
}