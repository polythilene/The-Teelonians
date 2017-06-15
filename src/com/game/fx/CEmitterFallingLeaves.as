package com.game.fx
{
	import flash.geom.Point;
	import org.flintparticles.common.counters.Steady;
	
	import org.flintparticles.common.initializers.SharedImages;
	import org.flintparticles.twoD.initializers.Rotation;
	import org.flintparticles.twoD.initializers.Velocity;
	import org.flintparticles.twoD.initializers.Position
	import org.flintparticles.common.initializers.ScaleImageInit;
	import org.flintparticles.common.initializers.ImageClass
	
	import org.flintparticles.twoD.actions.RotateToDirection;
	import org.flintparticles.twoD.actions.Move;
	import org.flintparticles.twoD.actions.DeathZone;
	import org.flintparticles.twoD.actions.RandomDrift;
	import org.flintparticles.twoD.zones.PointZone;
	import org.flintparticles.common.actions.Age;
	
	import org.flintparticles.twoD.particles.Particle2D;
	import org.flintparticles.twoD.zones.RectangleZone;
	import org.flintparticles.twoD.zones.LineZone;
		
	
	/**
	 * ...
	 * @author Kurniawan Fitriadi
	 */
	public class CEmitterFallingLeaves extends CBaseEmitter
	{
		public function CEmitterFallingLeaves() 
		{
		}
		
		override protected function initialize():void 
		{
			super.initialize();
		
			m_lifeTime = 0;
			counter = new Steady( 0.25 );
						
			/* particle initializers */
			addInitializer( new SharedImages( new Array( new FallingLeaf01(), new FallingLeaf02(), new FallingLeaf03() ) ) );
			addInitializer( new Position( new LineZone( new Point( -5, -5 ), new Point( 810, -5 ) ) ) );
			addInitializer( new Velocity( new PointZone( new Point( -100, 70 ) ) ) );
			addInitializer( new ScaleImageInit( 0.75, 1 ) );
			addInitializer( new Rotation(0, 90) );

			/* actions */
			addAction( new Move() );
			addAction( new DeathZone( new RectangleZone( -10, -10, 850, 490 ), true ) );
			addAction( new RandomDrift( 300, 100 ) );
			addAction( new RotateToDirection() );
		}
		
		override public function reset(x:int, y:int):void 
		{
			super.reset(x, y);
			
			start();
		}
		
		override public function remove():void 
		{
			super.remove();
		}
	}
}