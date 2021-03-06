package com.game
{
	import com.game.CBaseParabolicMissile;
	import com.game.CBaseTeelos;
	import com.game.fx.CEffect_IceExplosion;
	import flash.display.DisplayObjectContainer;
	import math.OpMath;

	/**
	 * @author Kurniawan Fitriadi
	 * @version 1.0
	 * @created 17-Dec-2010 11:48:16 AM
	 */
	public class CMissileIceBall_Teegor extends CBaseParabolicMissile
	{
		public function CMissileIceBall_Teegor(){

		}
		
		override public function initialize():void 
		{
			super.initialize();
			m_sprite = new mcIceBall_Endrogee();
			m_sprite.cacheAsBitmap = true;
		} 
		
		override protected function onGroundLevel():void 
		{
			super.onGroundLevel();
			damageArea();
		}
		
		override public function onCreate(container:DisplayObjectContainer, x:int, y:int, direction:int, faction:int, lane:int, damage:int, counterOf:int, counterDamage:int, level:int, detectInvisible:Boolean, owner:CBaseTeelos, exParams:Object = null):void 
		{
			//play sfx
			SoundManager.getInstance().playSFX("SN10");
			
			super.onCreate(container, x, y, direction, faction, lane, damage, counterOf, 
							counterDamage, level, detectInvisible, owner, exParams);
		}
		
		override protected function onHit(target:CBaseTeelos):void 
		{
			damageArea();
			ParticleManager.getInstance().add(CEffect_IceExplosion, target.x, target.y);
		}
		
		protected function damageArea():void
		{
			//play sfx
			SoundManager.getInstance().playSFX("SN15");
			
			var list:Array = NPCManager.getInstance().getListOfUnit(m_lane, NPCManager.FACTION_PLAYER);
			if( list.length > 0 )
			{
				for( var i:int = 0; i < list.length; i++ )
				{
					var teelo:CBaseTeelos = CBaseTeelos( list[i] );
					if ( !teelo.isDead() && !(teelo is IInvulnerable) &&
						 !(teelo is IJumper && !IJumper(teelo).hasLanded()) )
					{
						var dist:Number = OpMath.distance2(m_sprite.x, m_sprite.y, teelo.x, teelo.y);
						if ( dist < 150 )
						{
							var bonus:int = ( m_counterOf == teelo.unitClass ) ? m_counterDamage : 0;
							teelo.freeze( 3000, 0.75 );
							teelo.damage( (m_damage * m_level) + bonus, m_owner );
							ParticleManager.getInstance().add(CEffect_IceExplosion, teelo.x, teelo.y);
						}
					}
				}
			}
		}

	}//end CMissileIceBall_Endrogee

}