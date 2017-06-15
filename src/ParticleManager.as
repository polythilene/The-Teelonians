package 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;
	import org.flintparticles.twoD.renderers.BitmapRenderer;
	import com.game.fx.CBaseEmitter;
	
	
	
	/**
	 * ...
	 * @author Kurniawan Fitriadi
	 */
	public class ParticleManager extends EventDispatcher
	{
		static private var m_instance:ParticleManager;
		
		static public const PARTICLE_ENABLED:String = "particle_enabled";
		static public const PARTICLE_DISABLED:String = "particle_disabled";
					
		private var m_head:CBaseEmitter;
		private var m_tail:CBaseEmitter;
			
		private var m_owner:DisplayObjectContainer;
		
		private var m_stageWidth:int;
		private var m_stageHeight:int;
		
		private var m_rendererDefault:BitmapRenderer;
		private var m_rendererBlur:BitmapRenderer;
		
		private var m_emitterCount:int = 0;
		private var m_enable:Boolean = true;
		
		private var m_blurFilter:BlurFilter;
		private var m_colorFilter:ColorMatrixFilter;
		
		
		/* object pool */
		private var m_emitterNames:Array;
		private var m_emitterClasses:Array;
			
		public function ParticleManager(lock:SingletonLock)	
		{
		}
			
		public function initialize(stageWidth:int, stageHeight:int):void
		{
			if ( m_enable )
			{
				trace("Init particle manager");
				m_stageWidth = stageWidth;
				m_stageHeight = stageHeight;
				
				m_rendererDefault = new BitmapRenderer( new Rectangle( 0, 0, m_stageWidth, m_stageHeight ) );
				m_rendererBlur = new BitmapRenderer( new Rectangle( 0, 0, m_stageWidth, m_stageHeight ) );
				
				m_blurFilter = new BlurFilter( 3, 3, 1 );
				m_colorFilter = new ColorMatrixFilter( [ 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0.95, 0 ] );
				
				m_rendererBlur.addFilter( m_blurFilter );
				m_rendererBlur.addFilter( m_colorFilter );
				
				m_emitterNames = [];
				m_emitterClasses = [];
			}
		}
		
		private function chooseRenderer(emitter:CBaseEmitter):BitmapRenderer
		{
			return (emitter._blur) ? m_rendererBlur : m_rendererDefault;
		}
		
		public function attach(owner:DisplayObjectContainer, index:int=-1):void
		{
			if ( index != -1 )
			{
				owner.addChildAt( m_rendererDefault, index );
				owner.addChildAt( m_rendererBlur, index );
			}
			else
			{
				owner.addChild( m_rendererDefault );
				owner.addChild( m_rendererBlur );
			}
			
			m_owner = owner;	
			m_rendererDefault.x = m_rendererDefault.y = 
			m_rendererBlur.x = m_rendererBlur.y = 0;
		}
		
		public function detach():void
		{
			m_owner.removeChild( m_rendererDefault );
			m_owner.removeChild( m_rendererBlur );
			m_owner = null;
		}
		
		public function clear(): void
		{
			if ( m_enable )
			{
				/* send all particles to pool */
				var emitter:CBaseEmitter = m_head;
				while( emitter != null ) 
				{
					emitter.setDead();
					
					var garbage:CBaseEmitter = emitter;
					emitter = emitter.next;
					
					remove(garbage);
					sendToPool(garbage);
				}
			}
		}
		
		public function registerEmitter(emitterClass:Object, initCount:int):void
		{
			var name:String = getQualifiedClassName(emitterClass);
			
			m_emitterNames.push(name);
			m_emitterClasses[name] = emitterClass;
			
			PoolManager.getInstance().registerClass(emitterClass, initCount);
		}
		
		public function add(emitterClass:Object, x:int=0, y:int=0): CBaseEmitter
		{
			var emitter:CBaseEmitter;
			
			m_emitterCount++;
			
			var name:String = getQualifiedClassName(emitterClass);
			emitter = PoolManager.getInstance().borrowItem( m_emitterClasses[name] );
			emitter.reset(x, y);
			chooseRenderer(emitter).addEmitter(emitter);
							
			// add to list
			if( m_head == null )
			{
				m_head = emitter;
				m_tail = emitter;
			}
			else
			{
				m_tail.next = emitter;
				emitter.prev = m_tail;
				m_tail = emitter;
			}
			
			return emitter;
		}
		
		public function update(elapsedTime:int):void
		{
			if ( m_enable )
			{
				var emitter:CBaseEmitter = m_head;
			
				while( emitter != null ) 
				{
					if( emitter.isAlive() )
					{
						emitter.particleUpdate(elapsedTime);
						emitter = emitter.next;
					}
					else	
					{
						var garbage:CBaseEmitter = emitter;
						emitter = emitter.next;
						
						remove(garbage);
						sendToPool(garbage);
					}
				}
			}
		}
			
		public function remove(emitter:CBaseEmitter): void
		{
			m_emitterCount--;
			emitter.remove();
			
			chooseRenderer(emitter).removeEmitter(emitter);
			
			/* check if object is a list head */
			if( emitter.prev == null )
			{
				if( emitter.next != null )
				{
					m_head = emitter.next;
					emitter.next.prev = null;
					emitter.next = null;
				}
				else 
				{
					m_head = null;
					m_tail = null;
				}
			}
			
			/* check if object is a list body */
			else if( emitter.prev != null && emitter.next != null )
			{
				// this is a body
				emitter.prev.next = emitter.next;
				emitter.next.prev = emitter.prev;
				
				emitter.prev = null;
				emitter.next = null;
			}
			
			/* check if object is a list tail */
			else if( emitter.next == null )
			{
				if (emitter.prev != null) 
				{
					// this is the tail
					m_tail = emitter.prev;
					emitter.prev.next = null;
					emitter.prev = null;
				}
			}
		}
		
		private function sendToPool(emitter:CBaseEmitter): void
		{
			/* send object to pool */
			
			var found:Boolean = false;
			var length:int = m_emitterNames.length;
			var index:int = 0;
			
			while ( !found && index < length )
			{
				var name:String = m_emitterNames[index];
				if( emitter is m_emitterClasses[name] )
				{
					PoolManager.getInstance().recycleItem(m_emitterClasses[name], emitter);
					found = true;
				}
				index++;
			}
			
			if( !found )
			{
				trace("Cannot find pool for: ", getQualifiedClassName(emitter));
			}
		}
		
		public function get stageWidth():int 
		{
			return m_stageWidth;
		}
			
		public function get stageHeight():int 
		{
			return m_stageHeight;
		}
		
		public function set enable(value:Boolean):void
		{
			if( value != m_enable )
			{
				var eventId:String;
			
				m_enable = value;
				switch(m_enable)
				{
					case true: 
						eventId = PARTICLE_ENABLED;
						break;
					case false:
						eventId = PARTICLE_DISABLED;
						break;
				}
				dispatchEvent(new Event(eventId));
			}
		}
		
		public function get enable():Boolean
		{
			return m_enable;
		}
		
		public function toggleParticle():void
		{
			enable = !m_enable;
		}
			
		static public function getInstance(): ParticleManager
		{
			if( m_instance == null ){
				m_instance = new ParticleManager( new SingletonLock() );
			}
			return m_instance;
		}
	}
}

class SingletonLock{}