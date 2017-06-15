///////////////////////////////////////////////////////////
//  CTeeloUgee.as
//  Macromedia ActionScript Implementation of the Class CTeeloUgee
//  Generated by Enterprise Architect
//  Created on:      17-Dec-2010 2:09:19 PM
//  Original author: poof!
///////////////////////////////////////////////////////////

package com.game
{
	import com.game.CBaseTeelos;
	import com.game.CPlayerTeelos;
	import com.game.fx.CEffect_Heal;
	import flash.display.DisplayObjectContainer;
	import math.OpMath;

	/**
	 * @author poof!
	 * @version 1.0
	 * @created 17-Dec-2010 2:09:19 PM
	 */
	public class CTeeloUgee extends CPlayerTeelos
	{
		public function CTeeloUgee(){

		}
		
		override public function initialize():void 
		{
			super.initialize();
			
			m_attack = -8;
			m_defense = 1;
			m_maxLife = 10;
			m_unitClass = UNITCLASS.MAGE;
			m_counterClass = UNITCLASS.NONE;
			m_counterBonus = 0;
			m_baseSpeed = 0.07;
			m_baseCooldownTime = 6000;
			m_trainCost = 300;
			
			
		}
		
		override protected function createSprite():void 
		{
			super.createSprite();
			m_sprite = new mcTeelo_Ugee();
		}
		
		override public function onCreate(lane:int, targetPosX:int, container:DisplayObjectContainer):void 
		{
			super.onCreate(lane, targetPosX, container);
			m_attackRange = 10;
		}
		
		override public function attack(target:CBaseTeelos):void 
		{
			m_target = target;
			
			if ( !isCoolingDown() )
			{
				//play sfx
				SoundManager.getInstance().playSFX("SN11");
				
				m_cooldownCounter = 0;
				target.damage( attackDamage, this );
				ParticleManager.getInstance().add(CEffect_Heal, target.x, target.y);
			}
			else
			{
				if( m_sprite.currentFrame != 1 )
				{
					m_sprite.gotoAndStop(1);
					animationReset();
				}
			}
		}
	}//end CTeeloUgee

}