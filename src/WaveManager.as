package  
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Wiwitt
	 */
	public class WaveManager extends EventDispatcher
	{
		static public const DATA_LOADED:String = "data_loaded";
		
		static private var m_instance: WaveManager;
		
		private var m_spawnData:XML;
		private var m_dataLoaded:Boolean;
		
		public function WaveManager(lock:SingletonLock) 
		{
			m_dataLoaded = false;
		}
		
		public function loadExternalData():void
		{
			if ( !m_dataLoaded )
			{
				var loader:URLLoader = new URLLoader();
				loader.addEventListener( Event.COMPLETE, dataLoaded );
				loader.load( new URLRequest("SpawnData.xml") );
			}
		}
		
		private function dataLoaded(e:Event):void
		{
			m_spawnData = new XML(e.target.data);
			m_dataLoaded = true;
						
			dispatchEvent(new Event(DATA_LOADED));
		}
		
		public function loadInternalData():void
		{
			m_spawnData = SpawnData.getInstance().getData();
			m_dataLoaded = true;
			
			dispatchEvent(new Event(DATA_LOADED));
		}
		
		public function getSpawnTick(level:int, sublevel:int):int
		{
			var buff:XML = m_spawnData.children()[level];
			return buff.children()[sublevel].attribute("tick") * 1000;
		}
		
		public function getSpawnTickCount(level:int, sublevel:int):int
		{
			var buff:XML = m_spawnData.children()[level];
			return buff.children()[sublevel].attribute("count");
		}
		
		public function getLaneCount(level:int, sublevel:int):int
		{
			var buff:XML = m_spawnData.children()[level];
			return buff.children()[sublevel].attribute("lane_count");
		}
		
		public function getRPGained(level:int, sublevel:int):int
		{
			var buff:XML = m_spawnData.children()[level];
			return buff.children()[sublevel].attribute("research_point");
		}
			
		public function getWave(level:int, sublevel:int):XML
		{
			var buff:XML = m_spawnData.children()[level];
			return buff.children()[sublevel];
		}
		
		public function getFirstWaveType(level:int, sublevel:int):String
		{
			var buff:XML = m_spawnData.children()[level];
			return buff.children()[sublevel].children()[0].attribute("type");
		}
		
		public function getWaveTotalTime(level:int, sublevel:int):int
		{
			var totalTime:int = 0;
			var tick:int = getSpawnTick(level, sublevel);
			
			var buff:XML = m_spawnData.children()[level].children()[sublevel];
			
			for ( var i:int = 0; i < buff.children().length(); i++ )
			{
				var spawnData:XML = buff.children()[i];
				var waveType:String = spawnData.attribute("type");
				if ( waveType == "normal" )
				{
					for ( var j:int = 0; j < spawnData.children().length(); j++ )
					{
						var p:XML = spawnData.children()[j];
						var count:int = p.attribute("count");
						totalTime += count * tick;
					}
				}
				else if ( waveType == "big" || waveType == "final" )
				{
					totalTime += tick;
				}
				else if (waveType == "bossfight" )
				{
					totalTime = -1000;
				}
			}
			
			return totalTime;
		}
		
		public function getWaveMarks(level:int, sublevel:int):Array
		{
			var waveMarks:Array = [];
			var tick:int = getSpawnTick(level, sublevel);
			var totalTime:int = -tick;
			var buff:XML = m_spawnData.children()[level].children()[sublevel];
			
			for ( var i:int = 0; i < buff.children().length(); i++ )
			{
				var spawnData:XML = buff.children()[i];
				var waveType:String = spawnData.attribute("type");
				if ( waveType == "normal" )
				{
					for ( var j:int = 0; j < spawnData.children().length(); j++ )
					{
						var p:XML = spawnData.children()[j];
						var count:int = p.attribute("count");
						totalTime += count * tick;
					}
				}
				else if ( waveType == "big" || waveType == "final" )
				{
					waveMarks.push(totalTime);
					totalTime += tick;
				}
			}
			
			return waveMarks;
		}
			
		static public function getInstance(): WaveManager
	    {
			if( m_instance == null ){
            	m_instance = new WaveManager( new SingletonLock() );
            }
			return m_instance;
	    }
	}
}

class SingletonLock{}