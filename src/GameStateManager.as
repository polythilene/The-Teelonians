package  
{
	/**
	 * ...
	 * @author Kurniawan Fitriadi
	 */
	public class GameStateManager
	{
		static private var m_instance:GameStateManager;
		
		private var m_currentState:CGameState;
		
		public function GameStateManager(lock:SingletonLock) 
		{
		}
		
		public function setState(newState:CGameState): void
		{
			if( m_currentState )
				m_currentState.exit();
				
			m_currentState = newState;
			m_currentState.enter();
		}
		
		public function update(elapsedTime:int): void
		{
			if( m_currentState )
				m_currentState.update(elapsedTime);
		}
		
		static public function getInstance(): GameStateManager
		{
			if( m_instance == null ){
				m_instance = new GameStateManager( new SingletonLock() );
			}
			return m_instance;
		}
	}
}

class SingletonLock{}