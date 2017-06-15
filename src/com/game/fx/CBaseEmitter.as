package com.game.fx
{
	import flash.geom.Point;
	
	import org.flintparticles.common.counters.Counter;
	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.zones.PointZone;
	import org.flintparticles.twoD.particles.Particle2D;
	
	/**
	 * ...
	 * @author Kurniawan Fitriadi
	 */
	public class CBaseEmitter extends Emitter2D
	{
		public var prev:CBaseEmitter;
		public var next:CBaseEmitter;
		
		protected var m_active:Boolean;
		protected var m_lifeTime:int;
		protected var m_age:int;
		protected var m_color:int;
		
		public var _blur:Boolean = false;
		
		
		public function CBaseEmitter() 
		{
			initialize();
		}
		
		protected function initialize(): void
		{
			m_color = 0xFFFFFF;
		}
		
		public function reset(x:int, y:int): void
		{
			this.x = x;
			this.y = y;
			
			m_age = m_lifeTime;
			m_active = true;
		}
		
		public function remove(): void
		{
			stop();
		}
						
		public function setDead(): void
		{
			m_active = false;
		}
		
		public function particleUpdate(elapsedTime:int): void
		{
			// FIXME: USE CAMERA COORD FEEDBACK FROM USER
			
			/*
			var camera:ActionCamera = ShadeCore.getInstance().camera;
			
			if ( particles.length > 0 &&
				 !camera.isShaking() &&
				 (camera.getLastTargetPointOffsetX() != 0 ||
				  camera.getLastTargetPointOffsetY() != 0 ) ) 
			{
				for( var i:int = 0; i < particles.length; i++ )
				{
					var particle:Particle2D = particles[i];
						
					particle.x -= camera.getLastTargetPointOffsetX() >> 1;
					particle.y -= camera.getLastTargetPointOffsetY() >> 1;
				}
			}
			
			if( m_lifeTime > 0 && m_active )
			{
				m_age -= elapsedTime;
				m_active = (m_age > 0);
			}
			*/
		}
		
		public function isAlive():Boolean
		{
			return m_active;
		}
		
		public function set color(value:int):void
		{
			m_color = value;
		}
		
		public function get color():int
		{
			return m_color;
		}
	}

}