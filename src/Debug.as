package  
{
	/**
	 * ...
	 * @author Wiwit
	 */
	public class Debug
	{
		static private var m_instance:Debug;
		
		private var m_data:XML;
		
		public function Debug(lock:SingletonLock) 
		{
			initialize();
		}
		
		private function initialize():void
		{
			m_data = new XML();
				m_data = <data>
							<level_start value="1" />
							<gold value="400" />
							<research_point value="0" />
							
							<teemy unlocked="true" />
							<leegos unlocked="false" />
							<seeldy unlocked="false" />
							<ageesum unlocked="false" />
							<feela unlocked="false" />
							<elonee unlocked="false" />
							<endrogee unlocked="false" />
							<ugee unlocked="false" />
							<barricade unlocked="false" />
							<treasury unlocked="true" />
							<trap unlocked="false" />
							<ballista unlocked="false" />
						</data>
		}
		
		public function getData():XML
		{
			return m_data;
		}
		
		static public function getInstance(): Debug
		{
			if ( m_instance == null )
			{
				m_instance = new Debug( new SingletonLock() );
			}
			return m_instance;
		}
		
	}

}

class SingletonLock{}