package com.game
{
	import com.game.CBaseParabolicMissile;
	import com.game.CBaseTeelos;
	import com.game.fx.CEffect_Barrage;
	import com.game.fx.CEffect_FireExplosion;
	import flash.display.DisplayObjectContainer;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import math.OpMath;

	/**
	 * @author poof!
	 * @version 1.0
	 * @created 16-Des-2010 0:08:49
	 */
	public class CMissileBarrage extends CBaseParabolicMissile
	{
		private var enemy_gotHit:Array = new Array() //siput
		
		public function CMissileBarrage(){}
		
		override public function initialize():void 
		{
			super.initialize();
			m_sprite = new mcMissile_Barrage();
			m_sprite.cacheAsBitmap = true;
		}
		
		override public function onCreate(container:DisplayObjectContainer, x:int, y:int, direction:int, faction:int, lane:int, damage:int, counterOf:int, counterDamage:int, level:int, detectInvisible:Boolean, owner:CBaseTeelos, exParams:Object = null):void 
		{
			// copy from CBaseMissile
			m_container = container;
			m_container.addChild( m_sprite );
			
			m_owner = owner;
			m_detectInvisible = detectInvisible;
			
			m_sprite.x = x;
			m_sprite.y = y;
		
			m_sprite.scaleX = m_direction = direction;
			
			m_faction = faction;
			m_lane = lane;
			
			m_damage = damage;
			m_counterOf = counterOf;
			m_counterDamage = counterDamage;
			m_level = level;
			
			m_active = true;
			
			// copy from CBaseParabolicMissile
			
			m_active = ( exParams != null );
			if ( m_active )
			{
				var targetX:int = exParams["targetX"];
				var targetY:int = exParams["targetY"];
				m_groundLevel = exParams["groundLevel"];
				var launchDelay:Number = exParams["delay"];
				
				var dist:Number = OpMath.distance2(-100, -20, targetX, targetY);
				var midX:int = ((targetX - targetY) / 2) * direction;
				var midY:int = m_groundLevel - (200 + (dist * 0.03));
				var time:Number = dist * 0.0035;
				TweenMax.to( m_sprite, time, { delay:launchDelay, bezier:[ { x:-100 + midX, y:midY }, { x:targetX, y:targetY - 10 } ], orientToBezier:true, 
							ease:Expo.easeIn, onStart:function():void{SoundManager.getInstance().playSFX("SN09");},
							//ease:Quad.easeIn,
							 onComplete:function():void { onGroundLevel(); } } );
			}
			
			// missile barrage
			
			enemy_gotHit = [];
			
		}
		
		override protected function onGroundLevel():void 
		{
			super.onGroundLevel();
			damageArea();
			m_active = false;
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
			ParticleManager.getInstance().add(CEffect_Barrage, m_sprite.x, m_sprite.y);
			
			
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
						if ( dist < 200 )
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