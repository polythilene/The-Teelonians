package 
{
	import com.flashdynamix.utils.SWFProfiler;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	
	/**
	 * ...
	 * @author Wiwitt
	 */
	public class Main extends Sprite 
	{
		private const USE_EXTERNAL_DATA:Boolean = false;
		
		
		private var m_lastFrameTime:int;
		private var m_debugData:XML;
				
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// init sub-system
			State_GameLoop.getInstance().initialize(stage);
			State_MainMenu.getInstance().initialize(stage);
			State_LoseScreen.getInstance().initialize(stage);
			State_WinScreen.getInstance().initialize(stage);
			State_ScoutScreen.getInstance().initialize(stage);
			State_StoryScreen.getInstance().initialize(stage);
			State_BarrackScreen.getInstance().initialize(stage);
			State_EndingScreen.getInstance().initialize(stage);
			
			SWFProfiler.init(stage, this);
			
			if ( USE_EXTERNAL_DATA )
			{
				var loader:URLLoader = new URLLoader();
				loader.addEventListener( Event.COMPLETE, dataLoaded );
				loader.load( new URLRequest("debug.xml") );
			}
			else
			{
				m_debugData = Debug.getInstance().getData();
				loadWaveData();
			}
		}
		
		private function dataLoaded(e:Event):void
		{
			m_debugData = new XML(e.target.data);
			
			GlobalVars.CURRENT_LEVEL = m_debugData.level_start.attribute("value") - 1;
			GlobalVars.TOTAL_COIN = m_debugData.gold.attribute("value");
			GlobalVars.LAST_RESEARCH_POINT = GlobalVars.RESEARCH_POINT = m_debugData.research_point.attribute("value");
			
			GlobalVars.UNLOCKED_TEEMY = strToBool(m_debugData.teemy.attribute("unlocked"));
			GlobalVars.LAST_STATE_LEEGOS = GlobalVars.UNLOCKED_LEEGOS = strToBool(m_debugData.leegos.attribute("unlocked"));
			GlobalVars.LAST_STATE_SEELDY = GlobalVars.UNLOCKED_SEELDY = strToBool(m_debugData.seeldy.attribute("unlocked"));
			GlobalVars.LAST_STATE_AGEESUM = GlobalVars.UNLOCKED_AGEESUM = strToBool(m_debugData.ageesum.attribute("unlocked"));
			GlobalVars.LAST_STATE_FEELA = GlobalVars.UNLOCKED_FEELA = strToBool(m_debugData.feela.attribute("unlocked"));
			GlobalVars.LAST_STATE_ELONEE = GlobalVars.UNLOCKED_ELONEE = strToBool(m_debugData.elonee.attribute("unlocked"));
			GlobalVars.LAST_STATE_ENDROGEE = GlobalVars.UNLOCKED_ENDROGEE = strToBool(m_debugData.endrogee.attribute("unlocked"));
			GlobalVars.LAST_STATE_UGEE = GlobalVars.UNLOCKED_UGEE = strToBool(m_debugData.ugee.attribute("unlocked"));
			GlobalVars.LAST_STATE_BARRICADE = GlobalVars.UNLOCKED_BARRICADE = strToBool(m_debugData.barricade.attribute("unlocked"));
			GlobalVars.LAST_STATE_TREASURY = GlobalVars.UNLOCKED_TREASURY = strToBool(m_debugData.treasury.attribute("unlocked"));
			GlobalVars.LAST_STATE_TRAP = GlobalVars.UNLOCKED_TRAP = strToBool(m_debugData.trap.attribute("unlocked"));
			GlobalVars.LAST_STATE_BALLISTA = GlobalVars.UNLOCKED_BALLISTA = strToBool(m_debugData.ballista.attribute("unlocked"));
			
			loadWaveData();
		}
		
		private function strToBool(value:String):Boolean
		{
			return (value == "true") ? true : false;
		}
		
		private function loadWaveData():void
		{
			WaveManager.getInstance().addEventListener(WaveManager.DATA_LOADED, start);
			
			if( USE_EXTERNAL_DATA )
				WaveManager.getInstance().loadExternalData();
			else
				WaveManager.getInstance().loadInternalData();
		}
		
		private function start(event:Event):void
		{
			WaveManager.getInstance().removeEventListener(WaveManager.DATA_LOADED, start);
			//GameStateManager.getInstance().setState(State_EndingScreen.getInstance());
			//GameStateManager.getInstance().setState(State_BarrackScreen.getInstance());
			//GameStateManager.getInstance().setState(State_GameLoop.getInstance());
			GameStateManager.getInstance().setState(State_MainMenu.getInstance());
			
			
			m_lastFrameTime = getTimer();
			stage.addEventListener(Event.ENTER_FRAME, onUpdateFrame);
		}
		
		private function onUpdateFrame(event:Event):void
		{
			var elapsedTime:int=getTimer()-m_lastFrameTime;
			m_lastFrameTime += elapsedTime;
			
			GameStateManager.getInstance().update(elapsedTime);
		}
		
	}
	
}