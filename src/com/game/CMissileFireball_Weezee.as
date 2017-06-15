package com.game
{
	import com.game.CBaseParabolicMissile;
	import com.game.CBaseTeelos;
	import com.game.fx.CEffect_FireExplosion;
	import flash.display.DisplayObjectContainer;
	import math.OpMath;

	/**
	 * @author poof!
	 * @version 1.0
	 * @created 16-Des-2010 0:08:49
	 */
	public class CMissileFireball_Weezee extends CBaseParabolicMissile
	{
		private var enemy_gotHit:Array = new Array() //siput
		
		public function CMissileFireball_Weezee(){

		}
		
		override public function initialize():void 
		{
			super.initialize();
			m_sprite = new mcFireball_Elonee();
			m_sprite.cacheAsBitmap = true;
		}
		
		override public function onCreate(container:DisplayObjectContainer, x:int, y:int, direction:int, faction:int, lane:int, damage:int, counterOf:int, counterDamage:int, level:int, detectInvisible:Boolean, owner:CBaseTeelos, exParams:Object = null):void 
		{
			//sound fx play
			SoundManager.getInstance().playSFX("SN09");
			enemy_gotHit = [];
			super.onCreate(container, x, y, direction, faction, lane, damage, counterOf, 
						   counterDamage, level, detectInvisible, owner, exParams);
		}
		
		override protected function onGroundLevel():void 
		{
			super.onGroundLevel();
			damageArea();
		}
		
		override protected function onHit(target:CBaseTeelos):void 
		{
			damageArea();
			ParticleManager.getInstance().add(CEffect_FireExplosion, target.x, target.y);
		}
		
		protected function damageArea():void
		{
			//play sfx
			SoundManager.getInstance().playSFX("SN14");
			
			var list:Array = NPCManager.getInstance().getListOfUnit(m_lane, NPCManager.FACTION_PLAYER);
			if( list.length > 0 )
			{
				for( var i:int = 0; i < list.length; i++ )
				{
					var teelo:CBaseTeelos = CBaseTeelos( list[i] );
					if ( !teelo.isDead() && !(teelo is IInvulnerable) &&
						 enemy_gotHit.indexOf(teelo) < 0 && !(teelo is CTeeloLastBarricade) )
					{
						var dist:Number = OpMath.distance2(m_sprite.x, m_sprite.y, teelo.x, teelo.y);
						if ( dist < 150 )
						{
							var bonus:int = ( m_counterOf == teelo.unitClass ) ? m_counterDamage : 0;
							
							//siput;	
							enemy_gotHit.push(teelo);
							teelo.damage( m_damage + m_level + bonus, m_owner );	
							ParticleManager.getInstance().add(CEffect_FireExplosion, teelo.x, teelo.y);
						}
					}
				}
			}
		}

	}//end CMissileFireball_Elonee

}