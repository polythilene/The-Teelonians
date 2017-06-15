package com.game.fx
{
	import flash.geom.Point;
	import org.flintparticles.common.actions.Age;
	import org.flintparticles.common.actions.Fade;
	import org.flintparticles.common.counters.Steady;
	import org.flintparticles.common.displayObjects.RadialDot;
	import org.flintparticles.common.energyEasing.Bounce;
	import org.flintparticles.common.initializers.ColorsInit;
	import org.flintparticles.common.initializers.ImageClass;
	import org.flintparticles.common.initializers.Lifetime;
	import org.flintparticles.common.initializers.ScaleImageInit;
	import org.flintparticles.twoD.actions.DeathZone;
	import org.flintparticles.twoD.actions.Move;
	import org.flintparticles.twoD.actions.RandomDrift;
	import org.flintparticles.twoD.initializers.Position;
	import org.flintparticles.twoD.initializers.Velocity;
	import org.flintparticles.twoD.zones.PointZone;
	import org.flintparticles.twoD.zones.RectangleZone;
	
	
	
	/**
	 * ...
	 * @author Kurniawan Fitriadi
	 */
	public class CEmitterForestMist extends CBaseEmitter
	{
		public function CEmitterForestMist() 
		{
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			m_lifeTime = 0;
			counter = new Steady( 2 );
			
			/* particle initializers */
			addInitializer( new ImageClass( RadialDot, 2 ) );
			addInitializer( new Position( new RectangleZone( 0, 200, 800, 450 ) ) );
			addInitializer( new Velocity( new PointZone( new Point( -15, -7 ) ) ) );
			addInitializer( new ScaleImageInit( 0.75, 1.5 ) );
			addInitializer( new ColorsInit( new Array(0xFF996600, 0xFF33CC66, 0xFFCCCC99, 0xFF888888),
											new Array(0.4, 0.4, 0.4, 0.5) ) );
			addInitializer( new Lifetime( 10, 20 ) );								

			/* actions */
			addAction( new Move() );
			addAction( new DeathZone( new RectangleZone( -10, -10, 850, 490 ), true ) );
			addAction( new RandomDrift( 100, 70 ) );
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