package com.game.fx
{
	/**
	 * ...
	 * @author Wiwit
	 */
	public class CEffect_Barrage extends CBaseEmitter
	{
		import org.flintparticles.common.actions.Age;
		import org.flintparticles.common.actions.Fade;
		import org.flintparticles.common.counters.Blast;
		import org.flintparticles.common.initializers.AlphaInit;
		import org.flintparticles.common.initializers.Lifetime;
		import org.flintparticles.common.initializers.ScaleImageInit;
		import org.flintparticles.common.initializers.SharedImage;
		import org.flintparticles.twoD.initializers.Rotation;
	
		public function CEffect_Barrage() { }
		
		override protected function initialize():void 
		{
			super.initialize();
			
			m_lifeTime = 1510;
			counter = new Blast( 1 );
			
			/* particle initializers */
			addInitializer( new SharedImage( new mc_fxBarrage() ) );
			addInitializer( new Lifetime( 1.5 ) );
			addInitializer( new ScaleImageInit( 1) );
			addInitializer( new AlphaInit(0.5) );
			
			/* actions */
			addAction( new Age() );
			addAction( new Fade() );
		}
		
		override public function reset(x:int, y:int):void 
		{
			super.reset(x, y);
			start();
		}
		
	}

}