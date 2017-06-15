package com.game
{
	import com.game.ai.AIState_LastBarricade_Destroy;
	import com.game.ai.AIState_LastBarricade_Idle;
	import com.game.CBaseTeelos;
	import math.OpMath;
	import com.game.fx.CEffect_FireExplosion;
	import com.game.fx.CEffect_Barrage;
	import com.game.CTeeloBaseBuilding;
	import flash.display.DisplayObjectContainer;

	/**
	 * @author poof!
	 * @version 1.0
	 * @created 21-Dec-2010 3:21:50 PM
	 */
	public class CTeeloLastBarricade extends CTeeloBaseBuilding
	{
		
		private var enemy_gotHit:Array = new Array()
		
		public function CTeeloLastBarricade(){

		}

		override public function initialize():void 
		{
			super.initialize();
			
			m_attack = 1000;
			m_defense = 0;
			m_maxLife = 30;
			m_unitClass = UNITCLASS.BUILDING;
			m_counterClass = UNITCLASS.NONE;
			m_counterBonus = 0;
			m_baseSpeed = 0.05;
			m_baseCooldownTime = 0;
			m_trainCost = 0;
			
		}
		
		override protected function createSprite():void 
		{
			super.createSprite();
			m_sprite = new mcTeelo_LastBarricade();
		}
		
		override public function attack(target:CBaseTeelos):void 
		{
			super.attack(target);
			//play sfx
			SoundManager.getInstance().playSFX("SN14");
			
			
			var list:Array = NPCManager.getInstance().getListOfUnit(m_lane, NPCManager.FACTION_ENEMY);
			if( list.length > 0 )
			{
				for( var i:int = 0; i < list.length; i++ )
				{
					var teelo:CBaseTeelos = CBaseTeelos( list[i] );
					if ( !teelo.isDead() && !(teelo is IInvulnerable) &&
						 !(teelo is IJumper && !IJumper(teelo).hasLanded()) && enemy_gotHit.indexOf(teelo) < 0 )
					{
						var dist:Number = OpMath.distance2(m_sprite.x, m_sprite.y, teelo.x, teelo.y);
						if ( dist < 150 )
						{
							var bonus:int = ( m_counterClass == teelo.unitClass ) ? m_counterBonus : 0;
							enemy_gotHit.push(teelo);
							teelo.damage( m_attack + bonus , this );
							
							ParticleManager.getInstance().add(CEffect_FireExplosion, teelo.x, teelo.y);
						}
					}
				}
			}
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
				changeAIState( AIState_LastBarricade_Destroy.getInstance() );
			}
			
			m_currLife = Math.min(m_currLife, m_maxLife);		// cap value when unit is healed
			
			// tint sprite
			var col:int = (value > 0) ? 0xFF0000 : 0x00FF00;
			tintOnHit(col);
		}
		
		override public function animationHit():void 
		{
			// do nothing
		}
		
		override public function onCreate(lane:int, targetPosX:int, container:DisplayObjectContainer):void 
		{
			super.onCreate(lane, targetPosX, container);
			changeAIState( AIState_LastBarricade_Idle.getInstance() );
			onDestinationReached();
		}
	}//end CTeeloBallistaTower

}