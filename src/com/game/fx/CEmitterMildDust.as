package com.game.fx
{
	import flash.geom.Point;
	import org.flintparticles.common.counters.Steady;
	import org.flintparticles.common.displayObjects.RadialDot;
	import org.flintparticles.common.initializers.ColorsInit;
	import org.flintparticles.common.initializers.SharedImage;
	import org.flintparticles.common.initializers.ColorInit;
	import org.flintparticles.common.initializers.Lifetime;
	import org.flintparticles.twoD.initializers.Velocity;
	import org.flintparticles.twoD.initializers.Position
	import org.flintparticles.common.actions.Age;
	import org.flintparticles.twoD.actions.Move;
	import org.flintparticles.twoD.zones.PointZone;
	import org.flintparticles.twoD.particles.Particle2D;
	import org.flintparticles.twoD.zones.RectangleZone;
	import org.flintparticles.twoD.actions.DeathZone;
	import org.flintparticles.twoD.actions.RandomDrift;
	import org.flintparticles.common.initializers.ScaleImageInit;
	import org.flintparticles.common.initializers.ImageClass
	import org.flintparticles.twoD.zones.LineZone;
	import org.flintparticles.common.actions.Fade;
	
	import org.flintparticles.common.energyEasing.Sine;
	import org.flintparticles.common.energyEasing.Bounce;
	
	
	/**
	 * ...
	 * @author Kurniawan Fitriadi
	 */
	public class CEmitterMildDust extends CBaseEmitter
	{
		public function CEmitterMildDust() 
		{
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			m_lifeTime = 0;
			counter = new Steady( 2 );
			
			/* particle initializers */
			addInitializer( new ImageClass( RadialDot, 2 ) );
			addInitializer( new Position( new RectangleZone( 0, 100, 800, 450 ) ) );
			addInitializer( new Velocity( new PointZone( new Point( -7, -5 ) ) ) );
			addInitializer( new ScaleImageInit( 0.75 ) );
			addInitializer( new ColorsInit( new Array(0xFF996600, 0xFF33CC66, 0xFFCCCC99, 0xFF888888),
											new Array(0.4, 0.4, 0.4, 0.5) ) );
			addInitializer( new Lifetime( 5, 15 ) );								

			/* actions */
			addAction( new Move() );
			addAction( new DeathZone( new RectangleZone( -10, -10, 800, 490 ), true ) );
			addAction( new RandomDrift( 10, 10 ) );
			addAction( new Age( Bounce.easeInOut ) );
			addAction( new Fade() );
		}
		
		override public function reset(x:int, y:int/*, lifeTime:int=0*/):void 
		{
			super.reset(x, y/*, lifeTime*/);
			
			start();
		}
	}
}