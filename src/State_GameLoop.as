package  
{
	import com.game.*;
	import com.game.ai.*;
	import com.game.fx.*;
	import com.greensock.easing.*;
	import com.greensock.TweenMax;
	import flash.display.*;
	import flash.display.StageQuality;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.ui.*;
	import flash.utils.*;
	import math.*;
	
	
	/**
	 * ...
	 * @author Wiwitt
	 */
	public class State_GameLoop extends CGameState
	{
		static private var m_instance:State_GameLoop;
		
		static private var MOUSE_TRAIL_ENABLE:Boolean = false;
		
		private const STATE_DEFAULT:int 		= 1000;
		private const STATE_PLACING:int 		= 2000;
		private const STATE_RETREAT:int 		= 3000;
		private const STATE_SWAP_PHASE_01:int 	= 4001;
		private const STATE_SWAP_PHASE_02:int 	= 4002;
		private const STATE_BARRAGE_TARGET:int	= 5000;
		private const STATE_PAUSE:int			= 6000;
		
		private const WAVE_NORMAL:String 	= "normal";
		private const WAVE_BIG:String 		= "big";
		private const WAVE_FINAL:String 	= "final";
		private const WAVE_BOSSFIGHT:String = "bossfight";
		private const WAVE_COMPLETE:String 	= "complete";
		
		private const COST_TEEMY:int 		= 25;
		private const COST_LEEGOS:int 		= 220; //siput
		private const COST_SEELDY:int 		= 200;
		private const COST_AGEESUM:int 		= 600;
		private const COST_FEELA:int 		= 180;
		private const COST_ELONEE:int 		= 500;
		private const COST_ENDROGEE:int		= 350;
		private const COST_UGEE:int 		= 300;
		private const COST_BARRICADE:int 	= 750;
		private const COST_TREASURY:int 	= 150;
		private const COST_TRAP:int 		= 250; //siput
		private const COST_BALLISTA:int 	= 2000;
		
		
		private var m_background:mcBackground;
		private var m_bgOverlay:MovieClip;
		private var m_battleLayer:MovieClip;
		private var m_interface:mcUserInterface;
		private var m_effectLayer:MovieClip;
		private var m_nodes:Array;
		private var m_nodeView:Array;
		
		private var m_state:int;
		
		private var m_idleTimer:Timer;
		private var m_spawnActive:Boolean;
		private var m_startWave:Boolean; //siput;
		private var m_dummyCursor:mcDummyCursor;
		
		private var m_mouseX:int;
		private var m_mouseY:int;
		
		private var m_selectedButton:MovieClip;
		private var m_selectedCost:int;
		private var m_selectedBar:MovieClip;
		private var m_selectedCooldown:int;
		private var m_laneLayers:Array;
		private var m_placementNodeShown:Boolean;
		private var m_barrageUsed:Boolean;
		
		
		// wave data
		private var m_currSpawnTick:int;
		private var m_spawnTick:int;
		private var m_spawnCount:int;
		private var m_laneMax:int;
		private var m_ctrLane:int; //siput
		private var m_researchPointGain:int;
		private var m_tickCounter:int;
		
		private var m_waveIndex:int;
		private var m_waveCurrGroup:int;
		private var m_waveCurrGroupIndex:int; //siput
		private var m_waveCurrCtr:int;
		
		private var m_currentWaveState:String;
		private var m_waves:XML;
		private var m_totalWaveTime:int;
		private var m_currentWaveTime:int;
		private var m_waveMarks:Array;			// wave icons
		private var m_gameComplete:Boolean;
		
		// swap data
		private var m_swapUnit01:CBaseTeelos;
		private var m_swapUnit02:CBaseTeelos;
		
		//misc objects
		private var m_bgm:CSoundObject;
		private var m_screenOption:mc_OptionInGame;
		private var m_bgOption:mc_optionBG;
		private var m_exitPrompt:exit_prompt;
		private var m_customCursor:mcCustomCursor;
		private var m_debris:mc_debris;
		private var m_barrageTarget:mcBarrageTarget;
		
		private var m_lastRetreatHover:CBaseTeelos;
		
		public function State_GameLoop(lock:SingletonLock) {}
		
		override public function initialize(owner:DisplayObjectContainer):void 
		{
			super.initialize(owner);
			m_background = new mcBackground();
			m_bgOverlay = new MovieClip();
			m_interface = new mcUserInterface();
			m_idleTimer = new Timer(22000);
			m_battleLayer = new MovieClip();
			m_dummyCursor = new mcDummyCursor();
			m_effectLayer = new MovieClip();
			m_customCursor = new mcCustomCursor();
			m_customCursor.mouseEnabled = m_customCursor.mouseChildren = false;
			m_debris = new mc_debris();
			m_debris.cacheAsBitmap = true;
			m_dummyCursor.alpha = 0.5;
			m_dummyCursor.mouseChildren = m_dummyCursor.mouseEnabled = false;
			m_barrageTarget = new mcBarrageTarget();
			m_bgOverlay.addChild(m_barrageTarget);
			m_barrageTarget.visible = false;
			m_barrageTarget.alpha = 0.3;
			m_barrageTarget.x = 0;
			m_barrageTarget.y = 192;
			
			m_waveMarks = [];
			
			SoundManager.getInstance().addMusic("BGM_Throne", new BGM_Throne());
			SoundManager.getInstance().addMusic("BGM_01", new BGM_01());
			SoundManager.getInstance().addMusic("BGM_02", new BGM_02());
			SoundManager.getInstance().addMusic("BGM_03", new BGM_03());
			
			ParticleManager.getInstance().enable = true;
			ParticleManager.getInstance().initialize(800, 500);
			
			m_laneLayers = [];
			for ( var i:int = 0; i < 5; i++ )
			{
				m_laneLayers[i] = new MovieClip();
			}
			m_laneLayers.reverse();
			registerGameObjects();
			createNodes();
		}
		
		private function registerGameObjects():void
		{
			// player teelos
			NPCManager.getInstance().registerEntity( CTeeloTeemy, 1 );
			NPCManager.getInstance().registerEntity( CTeeloLeegos, 1 );
			NPCManager.getInstance().registerEntity( CTeeloFeela, 1 );
			NPCManager.getInstance().registerEntity( CTeeloElonee, 1 );
			NPCManager.getInstance().registerEntity( CTeeloSeeldy, 1 );
			NPCManager.getInstance().registerEntity( CTeeloEndrogee, 1 );
			NPCManager.getInstance().registerEntity( CTeeloUgee, 1 );
			NPCManager.getInstance().registerEntity( CTeeloAgeesum, 1 );
			NPCManager.getInstance().registerEntity( CTeeloTrap, 1 );
			NPCManager.getInstance().registerEntity( CTeeloBallistaTower, 1 );
			NPCManager.getInstance().registerEntity( CTeeloTreasury, 1 );
			NPCManager.getInstance().registerEntity( CTeeloBarricade, 1 );
			NPCManager.getInstance().registerEntity( CTeeloLastBarricade, 1 );
			
			NPCManager.getInstance().registerEntity( CTeeloSummonedLevel02, 1 );
			NPCManager.getInstance().registerEntity( CTeeloWorkerReturn, 1 );
			
			// enemy teelos
			NPCManager.getInstance().registerEntity( CTeeloUztan, 1 );
			NPCManager.getInstance().registerEntity( CTeeloRazark, 1 );
			NPCManager.getInstance().registerEntity( CTeeloCroztan, 1 );
			NPCManager.getInstance().registerEntity( CTeeloTeeclon, 1 );
			NPCManager.getInstance().registerEntity( CTeeloUdizark, 1 );
			NPCManager.getInstance().registerEntity( CTeeloPoztazark, 1 );
			NPCManager.getInstance().registerEntity( CTeeloUmaz, 1 );
			NPCManager.getInstance().registerEntity( CTeeloCaplozton, 1 );
			NPCManager.getInstance().registerEntity( CTeeloCaploztonCatapult, 1 );
			NPCManager.getInstance().registerEntity( CTeeloFlagee, 1 );
			NPCManager.getInstance().registerEntity( CTeeloHestaclan, 1 );
			NPCManager.getInstance().registerEntity( CTeeloRammer, 1 );
			NPCManager.getInstance().registerEntity( CTeeloBalistatoz, 1 );
			NPCManager.getInstance().registerEntity( CTeeloWeezee, 1 );
			NPCManager.getInstance().registerEntity( CTeeloTeegor, 1 );
			
			// register projectiles
			MissileManager.getInstance().registerEntity( CMissileArrow_Feela, 1 );
			MissileManager.getInstance().registerEntity( CMissileFireball_Elonee, 1 );
			MissileManager.getInstance().registerEntity( CMissileIceBall_Endrogee, 1 );
			MissileManager.getInstance().registerEntity( CMissileBallista_Tower, 1 );
			MissileManager.getInstance().registerEntity( CMissileArrow_Croztan, 1 );
			MissileManager.getInstance().registerEntity( CMissileArrow_Hestaclan, 1 );
			MissileManager.getInstance().registerEntity( CMissileBallista_Balistatoz, 1 );
			MissileManager.getInstance().registerEntity( CMissileBarrage, 1 );
			MissileManager.getInstance().registerEntity( CMissileFireball_Weezee, 1 );
			MissileManager.getInstance().registerEntity( CMissileFireball_Teegor, 1 );
			MissileManager.getInstance().registerEntity( CMissileIceBall_Teegor, 1 );
			
			// register effects
			ParticleManager.getInstance().registerEmitter( CEffect_FireExplosion, 1 );
			ParticleManager.getInstance().registerEmitter( CEffect_IceExplosion, 1 );
			ParticleManager.getInstance().registerEmitter( CEffect_Heal, 1 );
			ParticleManager.getInstance().registerEmitter( CEffect_Barrage, 1 );
			ParticleManager.getInstance().registerEmitter( CEffect_Summon , 1);
						
			// register particle
			ParticleManager.getInstance().registerEmitter( CEmitterForestMist, 1);
			ParticleManager.getInstance().registerEmitter( CEmitterFallingLeaves, 1);
			ParticleManager.getInstance().registerEmitter( CEmitterMildDust, 1);
			
			// items
			ItemManager.getInstance().registerEntity( CItem_GoldCoin, 1 );
			ItemManager.getInstance().registerEntity( CItem_SilverCoin, 1);
		}
		
		override public function enter():void 
		{
			super.enter();
			
			m_state = STATE_DEFAULT;
			m_spawnActive = false;
			m_gameComplete = false;
			
			stage.addChild( m_background );
			stage.addChild( m_bgOverlay );
			stage.addChild( m_battleLayer );
			for ( var i:int = 0; i < 5; i++ )
			{
				m_battleLayer.addChild( m_laneLayers[i] );
			}
			stage.addChild( m_effectLayer );
			stage.addChild( m_debris );
			stage.addChild( m_interface );
			switch( GlobalVars.CURRENT_LEVEL )
			{
				case 0: 
					m_background.gotoAndStop(1); 
					m_bgm = SoundManager.getInstance().playMusic("BGM_01");
					break;
				case 1: 
					m_background.gotoAndStop(2);	
					m_bgm = SoundManager.getInstance().playMusic("BGM_02");
					break;
				case 2: 
					m_background.gotoAndStop(3);	
					m_bgm = SoundManager.getInstance().playMusic("BGM_02");
					break;
				default: 
					m_background.gotoAndStop(4);	
					m_bgm = SoundManager.getInstance().playMusic("BGM_03");	
					break;
			}	
			
			registerButtons();
			invalidateGold();
			GlobalVars.KILL_SCORE = 0;
			invalidateScore();
			
			stage.addChild(m_dummyCursor);
			stage.addChild(m_customCursor);
			setupNodes();
			
			m_interface.topBar.cooldownBar01.visible = 
			m_interface.topBar.cooldownBar02.visible = 
			m_interface.topBar.cooldownBar03.visible = 
			m_interface.topBar.cooldownBar04.visible = 
			m_interface.topBar.cooldownBar05.visible = 
			m_interface.topBar.cooldownBar06.visible = 
			m_interface.topBar.cooldownBar07.visible = 
			m_interface.topBar.cooldownBar08.visible = 
			m_interface.topBar.cooldownBar09.visible = 
			m_interface.topBar.cooldownBar10.visible = 
			m_interface.topBar.cooldownBar11.visible = 
			m_interface.topBar.cooldownBar12.visible = false;
			m_interface.waveMessage.visible = false;
			m_dummyCursor.visible = false;
			m_customCursor.visible = false;
			m_barrageUsed = false;
			m_tickCounter = 0;
			m_barrageTarget.visible = false;
			m_lastRetreatHover = null;
			
			if ( GlobalVars.CURRENT_LEVEL + 1 == 5 )
			{
				m_interface.topBar.levelText.text = "BOSS FIGHT";
				m_interface.bottomBar.progressLevel.progressMask.gotoAndStop(100);
			}
			else
			{
				m_interface.topBar.levelText.text = "Level " + String(GlobalVars.CURRENT_LEVEL + 1) + "-" + String(GlobalVars.CURRENT_SUB_LEVEL + 1);
				m_interface.bottomBar.progressLevel.progressMask.gotoAndStop(1);
			}
			
			m_interface.topBar.y = -100;
			m_interface.bottomBar.y = 600;
			TweenMax.to(m_interface.topBar, 0.5, { y:0 } );
			TweenMax.to(m_interface.bottomBar, 0.5, { y:500 } );
			
			m_interface.topBar.barrageButton.gotoAndStop(1);
			
			GlobalVars.LAST_GOLD_STATE = GlobalVars.TOTAL_COIN;
			GlobalVars.LAST_ASSET_STATE = NPCManager.getInstance().returnTrainCost();
			
			loadWaveData();
			placeTowers();
			setupWaveProgressBar();
			
			switch( m_laneMax )
			{
				case 1: m_debris.gotoAndStop(2); break;
				case 3: m_debris.gotoAndStop(3); break;
				case 5: m_debris.gotoAndStop(1); break;
			}
				
			m_idleTimer.delay = ( GlobalVars.IS_VICTORY ) ? 22000 : 44000;
			m_idleTimer.addEventListener(TimerEvent.TIMER, onIdleComplete);
			m_idleTimer.reset();
			m_idleTimer.start();
			
			m_interface.bottomBar.progressLevel.progressMask.gotoAndStop(100);
			
			
			var mc:MovieClip = m_interface.bottomBar.progressLevel.bar;
			TweenMax.to( mc, 0.1, 
						 { colorMatrixFilter: { colorize:0x00CC00, amount:1 },
						   onComplete:function():void
						   {
							   TweenMax.to(mc, m_idleTimer.delay / 1000, {colorMatrixFilter:{colorize:0xCC0000, amount:1} });
						   }
						 });
			
			
			TweenMax.to(m_interface.bottomBar.progressLevel.progressMask, m_idleTimer.delay / 1000, { frame:1 } );
			
			m_interface.topBar.debug.text = "";
			toggleCustomCursor();
			
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			m_interface.topBar.debug.visible = false;
			
			ParticleManager.getInstance().attach(m_effectLayer);
			
			switch( GlobalVars.CURRENT_LEVEL )
			{
				case 0: ParticleManager.getInstance().add(CEmitterForestMist); break;
				case 1: ParticleManager.getInstance().add(CEmitterFallingLeaves); break;
				case 2: ParticleManager.getInstance().add(CEmitterFallingLeaves); break;
				default: ParticleManager.getInstance().add(CEmitterMildDust); break;
			}
			
			if( MOUSE_TRAIL_ENABLE )
				stage.addEventListener(MouseEvent.CLICK, _checkMouseEventTrail);
		}
		
		private function setupWaveProgressBar():void
		{
			m_currentWaveTime = 0;
			
			m_totalWaveTime = WaveManager.getInstance().getWaveTotalTime(GlobalVars.CURRENT_LEVEL, GlobalVars.CURRENT_SUB_LEVEL) - 
							  WaveManager.getInstance().getSpawnTick(GlobalVars.CURRENT_LEVEL, GlobalVars.CURRENT_SUB_LEVEL);	
			
			
			var waveMarks:Array = WaveManager.getInstance().getWaveMarks(GlobalVars.CURRENT_LEVEL, GlobalVars.CURRENT_SUB_LEVEL);
			
			if ( waveMarks.length > 0 )
			{
				var barLength:int = 203;
				for ( var i:int; i < waveMarks.length; i++ )
				{
					var finalW:Boolean = (i == waveMarks.length - 1) ? true : false;
					
					if( !finalW )
						var percentage:Number = waveMarks[i] / m_totalWaveTime;
					else	
						percentage = 1;
					
					var pos:int = barLength * percentage;
					var icon:MovieClip = new mcWaveMilestone();
					m_interface.bottomBar.addChild(icon);
					
					var offset:int = (finalW) ? 12 : 8;
					icon.x = (757 - pos) + offset;
					icon.y = -18.50;
					icon.alpha = 0;
					icon.scaleX = icon.scaleY = 4;
					
					m_waveMarks.push(icon);
				}
			}
		}
		
		private function showWaveMilestone():void
		{
			if ( m_waveMarks.length > 0 )
			{
				for ( var i:int; i < m_waveMarks.length; i++ )
				{
					var mc:MovieClip = MovieClip(m_waveMarks[i]);
					TweenMax.to(mc, 0.75, { alpha:1, scaleX:1, scaleY:1, delay:i*0.2, ease:Back.easeOut } );
				}
			}
		}
		
		private function clearWaveProgressBar():void
		{
			while ( m_waveMarks.length > 0 )
			{
				var icon:MovieClip = MovieClip(m_waveMarks[0]);
				m_interface.bottomBar.removeChild(icon);
				
				m_waveMarks.splice(0, 1);
			}
		}
		
		private function loadWaveData():void
		{
			var curr_level:int = GlobalVars.CURRENT_LEVEL;
			var curr_sub_level:int = GlobalVars.CURRENT_SUB_LEVEL;
			
			m_currentWaveState = WaveManager.getInstance().getFirstWaveType(curr_level, curr_sub_level);
			m_currSpawnTick = 0;
			
			m_spawnTick = WaveManager.getInstance().getSpawnTick(curr_level, curr_sub_level);
			m_spawnCount = WaveManager.getInstance().getSpawnTickCount(curr_level, curr_sub_level);
			m_laneMax = WaveManager.getInstance().getLaneCount(curr_level, curr_sub_level);
			m_researchPointGain = WaveManager.getInstance().getRPGained(curr_level, curr_sub_level);
			
			m_waveIndex = 0;
			m_waveCurrGroup = 0;
			m_waveCurrGroupIndex = 0;
			m_waveCurrCtr = 0;
			m_ctrLane = 0;
			
			m_waves = WaveManager.getInstance().getWave(curr_level, curr_sub_level);
		}
		
		override public function exit():void 
		{
			m_bgm.stop();
			
			if( MOUSE_TRAIL_ENABLE )
				stage.removeEventListener(MouseEvent.CLICK, _checkMouseEventTrail);
			
			clearWaveProgressBar();
			
			ParticleManager.getInstance().clear();
			ParticleManager.getInstance().detach();
			MissileManager.getInstance().clear();
			ItemManager.getInstance().clear();
			
			var clearPlayer:Boolean = (GlobalVars.CURRENT_SUB_LEVEL == 0);
			NPCManager.getInstance().removeBarricades();
			NPCManager.getInstance().clear(clearPlayer, true);
			
			
			stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			m_idleTimer.removeEventListener(TimerEvent.TIMER, onIdleComplete);
			m_idleTimer.reset();
			
			m_state = STATE_DEFAULT ;
			m_dummyCursor.visible = false;
			m_customCursor.visible = false;
			Mouse.show();
			
			stage.removeChild(m_customCursor);
			stage.removeChild(m_dummyCursor);
			unregisterButtons();
			removeNodes();
			stage.removeChild( m_interface );
			stage.removeChild( m_debris );
			stage.removeChild( m_effectLayer );
			
			for ( var i:int = 0; i < 5; i++ )
			{
				m_battleLayer.removeChild( m_laneLayers[i] );
			}
			stage.removeChild( m_battleLayer );
			stage.removeChild( m_bgOverlay );
			stage.removeChild( m_background );
			super.exit();
		}
		
		private function onIdleComplete(event:TimerEvent):void
		{
			m_idleTimer.reset();
			m_spawnActive = true;
			m_startWave = true;
			m_currSpawnTick = m_spawnTick;
			//m_totalWaveTime -= m_spawnTick;
			showWaveMilestone();
		}
		
		private function registerButtons():void
		{
			m_interface.topBar.buttonTeemy.visible = GlobalVars.UNLOCKED_TEEMY;
			m_interface.topBar.buttonLeegos.visible = GlobalVars.UNLOCKED_LEEGOS;
			m_interface.topBar.buttonFeela.visible = GlobalVars.UNLOCKED_FEELA;
			m_interface.topBar.buttonElonee.visible = GlobalVars.UNLOCKED_ELONEE;
			m_interface.topBar.buttonSeeldy.visible = GlobalVars.UNLOCKED_SEELDY;
			m_interface.topBar.buttonEndrogee.visible = GlobalVars.UNLOCKED_ENDROGEE;
			m_interface.topBar.buttonUgee.visible = GlobalVars.UNLOCKED_UGEE;
			m_interface.topBar.buttonAgeesum.visible = GlobalVars.UNLOCKED_AGEESUM;
			m_interface.topBar.buttonTrap.visible = GlobalVars.UNLOCKED_TRAP;
			m_interface.topBar.buttonBallista.visible = GlobalVars.UNLOCKED_BALLISTA;
			m_interface.topBar.buttonTreasury.visible = GlobalVars.UNLOCKED_TREASURY;
			m_interface.topBar.buttonBarricade.visible = GlobalVars.UNLOCKED_BARRICADE;
			
			m_interface.topBar.buttonTeemy.costText.text = String(COST_TEEMY);
			m_interface.topBar.buttonLeegos.costText.text = String(COST_LEEGOS);
			m_interface.topBar.buttonFeela.costText.text = String(COST_FEELA);
			m_interface.topBar.buttonElonee.costText.text = String(COST_ELONEE);
			m_interface.topBar.buttonSeeldy.costText.text = String(COST_SEELDY);
			m_interface.topBar.buttonEndrogee.costText.text = String(COST_ENDROGEE);
			m_interface.topBar.buttonUgee.costText.text = String(COST_UGEE);
			m_interface.topBar.buttonAgeesum.costText.text = String(COST_AGEESUM);
			m_interface.topBar.buttonTrap.costText.text = String(COST_TRAP);
			m_interface.topBar.buttonBallista.costText.text = String(COST_BALLISTA);
			m_interface.topBar.buttonTreasury.costText.text = String(COST_TREASURY);
			m_interface.topBar.buttonBarricade.costText.text = String(COST_BARRICADE);
			
			registerButtonEvents(m_interface.topBar.buttonTeemy);
			registerButtonEvents(m_interface.topBar.buttonLeegos);
			registerButtonEvents(m_interface.topBar.buttonFeela);
			registerButtonEvents(m_interface.topBar.buttonElonee);
			registerButtonEvents(m_interface.topBar.buttonSeeldy);
			registerButtonEvents(m_interface.topBar.buttonEndrogee);
			registerButtonEvents(m_interface.topBar.buttonUgee);
			registerButtonEvents(m_interface.topBar.buttonAgeesum);
			registerButtonEvents(m_interface.topBar.buttonTrap);
			registerButtonEvents(m_interface.topBar.buttonBallista);
			registerButtonEvents(m_interface.topBar.buttonTreasury);
			registerButtonEvents(m_interface.topBar.buttonBarricade);
			
			/*siput*/
			m_interface.bottomBar.buttonMenu.addEventListener(MouseEvent.MOUSE_DOWN, onBottomBarMouseDown);
			m_interface.bottomBar.buttonMenu.addEventListener(MouseEvent.MOUSE_UP, onBottomBarMouseUp);
			
			m_interface.bottomBar.buttonExit.addEventListener(MouseEvent.MOUSE_DOWN, onBottomBarMouseDown);
			m_interface.bottomBar.buttonExit.addEventListener(MouseEvent.MOUSE_UP, onBottomBarMouseUp);
			
			
			m_interface.topBar.retreatButton.addEventListener(MouseEvent.MOUSE_UP, onTacticButtonMouseUp);
			m_interface.topBar.swapButton.addEventListener(MouseEvent.MOUSE_UP, onTacticButtonMouseUp);
			m_interface.topBar.barrageButton.addEventListener(MouseEvent.MOUSE_UP, onBarrageButtonMouseUp);
			
			m_interface.topBar.retreatButton.buttonMode = m_interface.topBar.retreatButton.useHandCursor = true;
			m_interface.topBar.swapButton.buttonMode = m_interface.topBar.swapButton.useHandCursor = true;
			m_interface.bottomBar.buttonMenu.buttonMode = m_interface.bottomBar.buttonMenu.useHandCursor = true;
			m_interface.bottomBar.buttonExit.buttonMode = m_interface.bottomBar.buttonExit.useHandCursor = true;
		}
		
		private function unregisterButtons():void
		{
			m_interface.topBar.retreatButton.removeEventListener(MouseEvent.MOUSE_UP, onTacticButtonMouseUp);
			m_interface.topBar.swapButton.removeEventListener(MouseEvent.MOUSE_UP, onTacticButtonMouseUp);
			m_interface.topBar.barrageButton.removeEventListener(MouseEvent.MOUSE_UP, onBarrageButtonMouseUp);
			
			unregisterButtonEvents(m_interface.topBar.buttonBarricade);
			unregisterButtonEvents(m_interface.topBar.buttonTreasury);
			unregisterButtonEvents(m_interface.topBar.buttonTeemy);
			unregisterButtonEvents(m_interface.topBar.buttonLeegos);
			unregisterButtonEvents(m_interface.topBar.buttonFeela);
			unregisterButtonEvents(m_interface.topBar.buttonElonee);
			unregisterButtonEvents(m_interface.topBar.buttonSeeldy);
			unregisterButtonEvents(m_interface.topBar.buttonEndrogee);
			unregisterButtonEvents(m_interface.topBar.buttonUgee);
			unregisterButtonEvents(m_interface.topBar.buttonAgeesum);
			unregisterButtonEvents(m_interface.topBar.buttonTrap);
			unregisterButtonEvents(m_interface.topBar.buttonBallista);
		}
				
		private function createNodes():void
		{
			var yStart:int = 218;
			var xStart:int = 121;
			var xIncr:int = 72;
			var yIncr:int = 63;
			
			// node object
			m_nodes = [];
			var ypos:int = yStart;
			for( var y:int = 0; y < 5; y++ )
			{
				var xpos:int = xStart;
				
				m_nodes[y] = [];
				for (var x:int = 0; x < 9; x++ )
				{
					var node:CPlacementNode = new CPlacementNode();
					node.x = xpos;
					node.y = ypos;
					node.laneId = y;
					node.alpha = 0;
					
					m_nodes[y][x] = node;
					
					xpos += xIncr;
				}
				
				ypos += yIncr;
			}
			
			// node view
			m_nodeView = [];
			for( y = 0; y < 5; y++ )
			{
				m_nodeView[y] = [];
				for(x = 0; x < 9; x++ )
				{
					node = m_nodes[y][x];
					
					var dummy:PlacementDummy = new PlacementDummy();
					dummy.x = node.x-5;
					dummy.y = node.y-10;
					dummy.visible = false;
					m_bgOverlay.addChild(dummy);
					
					m_nodeView[y][x] = dummy;
				}
			}
		}
		
		private function setupNodes():void
		{
			for (var y:int = 0; y < 5; y++ )
			{
				for (var x:int = 0; x < 9; x++ )
				{
					var node:CPlacementNode = m_nodes[y][x];
					stage.addChild(node);
					
					node.addEventListener(MouseEvent.MOUSE_DOWN, onNodeMouseDown);
					node.addEventListener(MouseEvent.MOUSE_UP, onNodeMouseUp);
					node.addEventListener(MouseEvent.MOUSE_OVER, onNodeMouseOver);
					node.addEventListener(MouseEvent.MOUSE_OUT, onNodeMouseOut);
				}
			}
			m_placementNodeShown = false;
			toggleNodeMouseEnable(false);
			toggleBottomBarEnable(true);
		}
		
		private function toggleNodeMouseEnable(value:Boolean):void
		{
			for (var y:int = 0; y < 5; y++ )
			{
				for (var x:int = 0; x < 9; x++ )
				{
					var node:CPlacementNode = m_nodes[y][x];
					node.mouseEnabled = value;
					if ( value )
						stage.setChildIndex(node, stage.numChildren - 1);
					
				}
			}
		}
		
		private function toggleBottomBarEnable(value:Boolean):void
		{
			m_interface.bottomBar.mouseEnabled = m_interface.bottomBar.mouseChildren = value;
		}
		
		private function removeNodes():void
		{
			hidePlacementNode();
			for (var y:int = 0; y < 5; y++ )
			{
				for (var x:int = 0; x < 7; x++ )
				{
					var node:CPlacementNode = m_nodes[y][x];
					
					node.removeEventListener(MouseEvent.MOUSE_DOWN, onNodeMouseDown);
					node.removeEventListener(MouseEvent.MOUSE_UP, onNodeMouseUp);
					node.removeEventListener(MouseEvent.MOUSE_OVER, onNodeMouseOver);
					node.removeEventListener(MouseEvent.MOUSE_OUT, onNodeMouseOut);
					
					stage.removeChild(node);
				}
			}
		}
		
		private function placeTowers():void
		{
			for ( var i:int = 0; i < m_laneMax; i++ )
			{
				NPCManager.getInstance().add( CTeeloLastBarricade, i, 20, m_laneLayers[i] );
			}
		}
		
		private function onNodeMouseDown(event:MouseEvent):void
		{
		}
		
		private function onNodeMouseUp(event:MouseEvent):void
		{
			var node:CPlacementNode = CPlacementNode(event.currentTarget);
			if (m_state == STATE_PLACING && node.laneId < m_laneMax)
			{
				if ( !node.obtained )
				{
					hidePlacementNode();
					m_state = STATE_DEFAULT ;
					toggleNodeMouseEnable(false);
					toggleBottomBarEnable(true);
					
					SoundManager.getInstance().playSFX("SN16");
					
					node.obtained = true;
					
					m_dummyCursor.visible = false;
					showCooldown(m_selectedBar, m_selectedCooldown, m_selectedButton);
					
					GlobalVars.TOTAL_COIN -= m_selectedCost;
					invalidateGold();
					
					var teelo:CPlayerTeelos;
					var teeloClass:Class;
					
					switch( m_selectedButton )
					{
						case m_interface.topBar.buttonTeemy:
								teeloClass = CTeeloTeemy; 		break;
						case m_interface.topBar.buttonLeegos:
								teeloClass = CTeeloLeegos; 		break;
						case m_interface.topBar.buttonFeela:
								teeloClass = CTeeloFeela; 		break;
						case m_interface.topBar.buttonElonee:
								teeloClass = CTeeloElonee; 		break;		
						case m_interface.topBar.buttonSeeldy:
								teeloClass = CTeeloSeeldy;		break;
						case m_interface.topBar.buttonEndrogee:
								teeloClass = CTeeloEndrogee;	break;
						case m_interface.topBar.buttonUgee:
								teeloClass = CTeeloUgee;		break;
						case m_interface.topBar.buttonAgeesum:
								teeloClass = CTeeloAgeesum;		break;		
						case m_interface.topBar.buttonTrap:
								teeloClass = CTeeloTrap;		break;
						case m_interface.topBar.buttonTreasury:
								teeloClass = CTeeloTreasury;	break;
						case m_interface.topBar.buttonBallista:
								teeloClass = CTeeloBallistaTower;		break;		
						case m_interface.topBar.buttonBarricade:
								teeloClass = CTeeloBarricade;		break;			
					}
					teelo = CPlayerTeelos( NPCManager.getInstance().add( teeloClass, node.laneId, 0, m_laneLayers[node.laneId] ) );	
					
					teelo.setDestination( node.x );
					teelo.placementNode = node;
					
				}
			}
		}
		
		private function onNodeMouseOver(event:MouseEvent):void
		{
			
		}
		
		private function onNodeMouseOut(event:MouseEvent):void
		{
			
		}
		
		private function registerButtonEvents(button:MovieClip):void
		{
			button.buttonMode = button.useHandCursor = true;
			button.addEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
			button.addEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseUp);
			button.addEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseOver);
			button.addEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseOut);
		}
		
		private function unregisterButtonEvents(button:MovieClip):void
		{
			button.removeEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
			button.removeEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseUp);
			button.removeEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseOver);
			button.removeEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseOut);
		}
		
		private function onButtonMouseDown(event:MouseEvent):void
		{
		
		}
		
		private function onButtonMouseUp(event:MouseEvent):void
		{
			var button:MovieClip = MovieClip(event.currentTarget);
		
			SoundManager.getInstance().playSFX("SN01");
			
			if (m_state == STATE_DEFAULT)
			{
				m_selectedButton = button;
				var createFlag:Boolean = false;
												
				switch( m_selectedButton )
				{
					case m_interface.topBar.buttonTreasury:
							if( GlobalVars.TOTAL_COIN >= COST_TREASURY )
							{
								m_dummyCursor.gotoAndStop(11); 
								m_selectedBar = m_interface.topBar.cooldownBar01;
								m_selectedCooldown = 60;
								m_selectedCost = COST_TREASURY;
								invalidateGold();
								createFlag = true;
							}		
							break;	
					case m_interface.topBar.buttonTeemy:
							if( GlobalVars.TOTAL_COIN >= COST_TEEMY )
							{
								m_dummyCursor.gotoAndStop(1);
								m_selectedBar = m_interface.topBar.cooldownBar02;
								m_selectedCooldown = 3;
								m_selectedCost = COST_TEEMY;
								invalidateGold();
								createFlag = true;
							}
							break;
					case m_interface.topBar.buttonLeegos:
							if( GlobalVars.TOTAL_COIN >= COST_LEEGOS )
							{
								m_dummyCursor.gotoAndStop(2);
								m_selectedBar = m_interface.topBar.cooldownBar03;
								m_selectedCooldown = 3;
								m_selectedCost = COST_LEEGOS;
								invalidateGold();
								createFlag = true;
							}
							break;
					case m_interface.topBar.buttonFeela:
							if( GlobalVars.TOTAL_COIN >= COST_FEELA )
							{
								m_dummyCursor.gotoAndStop(3); 
								m_selectedBar = m_interface.topBar.cooldownBar04;
								m_selectedCooldown = 15;
								m_selectedCost = COST_FEELA;
								invalidateGold();
								createFlag = true;
							}
							break;
					case m_interface.topBar.buttonSeeldy:
							if( GlobalVars.TOTAL_COIN >= COST_SEELDY )
							{
								m_dummyCursor.gotoAndStop(4); 
								m_selectedBar = m_interface.topBar.cooldownBar05;
								m_selectedCooldown = 15;
								m_selectedCost = COST_SEELDY;
								invalidateGold();
								createFlag = true;
							}
							break;		
					case m_interface.topBar.buttonElonee:
							if( GlobalVars.TOTAL_COIN >= COST_ELONEE )
							{
								m_dummyCursor.gotoAndStop(5); 
								m_selectedBar = m_interface.topBar.cooldownBar06;
								m_selectedCooldown = 20;
								m_selectedCost = COST_ELONEE;
								invalidateGold();
								createFlag = true;
							}
							break;	
					case m_interface.topBar.buttonEndrogee:
							if( GlobalVars.TOTAL_COIN >= COST_ENDROGEE )
							{
								m_dummyCursor.gotoAndStop(6); 
								m_selectedBar = m_interface.topBar.cooldownBar07;
								m_selectedCooldown = 15;
								m_selectedCost = COST_ENDROGEE;
								invalidateGold();
								createFlag = true;
							}
							break;
					case m_interface.topBar.buttonAgeesum:
							if( GlobalVars.TOTAL_COIN >= COST_AGEESUM )
							{
								m_dummyCursor.gotoAndStop(7); 
								m_selectedBar = m_interface.topBar.cooldownBar08;
								m_selectedCooldown = 20;
								m_selectedCost = COST_AGEESUM;
								invalidateGold();
								createFlag = true;
							}
							break;
					case m_interface.topBar.buttonUgee:
							if( GlobalVars.TOTAL_COIN >= COST_UGEE )
							{
								m_dummyCursor.gotoAndStop(8); 
								m_selectedBar = m_interface.topBar.cooldownBar09;
								m_selectedCooldown = 12;
								m_selectedCost = COST_UGEE;
								invalidateGold();
								createFlag = true;
							}
							break;
					case m_interface.topBar.buttonTrap:
							if( GlobalVars.TOTAL_COIN >= COST_TRAP )
							{
								m_dummyCursor.gotoAndStop(9); 
								m_selectedBar = m_interface.topBar.cooldownBar10;
								m_selectedCooldown = 15;
								m_selectedCost = COST_TRAP;
								invalidateGold();
								createFlag = true;
							}
							break;
					case m_interface.topBar.buttonBallista:
							if( GlobalVars.TOTAL_COIN >= COST_BALLISTA )
							{
								m_dummyCursor.gotoAndStop(10); 
								m_selectedBar = m_interface.topBar.cooldownBar11;
								m_selectedCooldown = 120;
								m_selectedCost = COST_BALLISTA;
								invalidateGold();
								createFlag = true;
							}
							break;
					case m_interface.topBar.buttonBarricade:
							if( GlobalVars.TOTAL_COIN >= COST_BARRICADE )
							{
								m_dummyCursor.gotoAndStop(12); 
								m_selectedBar = m_interface.topBar.cooldownBar12;
								m_selectedCooldown = 30;
								m_selectedCost = COST_BARRICADE;
								invalidateGold();
								createFlag = true;
							}		
							break;			
				}
				
				if ( createFlag )
				{
					m_state = STATE_PLACING;
					m_dummyCursor.visible = true;
					m_dummyCursor.x = m_mouseX;
					m_dummyCursor.y = m_mouseY;
					showPlacementNode();
					toggleNodeMouseEnable(true);
					toggleBottomBarEnable(false);
				}
			}
			else
			{
				m_state = STATE_DEFAULT;
				m_dummyCursor.visible = false;
				m_dummyCursor.x = m_mouseX;
				m_dummyCursor.y = m_mouseY;
				hidePlacementNode();
			}
		}
		
		public function showCooldown(plate:MovieClip, intervalSeconds:int, owner:MovieClip):void
		{
			plate.visible = true;
			plate.bar.scaleX = 0;
			TweenMax.to(plate.bar, intervalSeconds, 
						{ scaleX:1, 
						  onComplete:function():void 
						  { 
							  plate.visible = false;
							  // TODO: GLOW BUTTON
						  } 
						} ); 
		}
		
		private function onButtonMouseOver(event:MouseEvent):void
		{
			
		}
		
		private function onButtonMouseOut(event:MouseEvent):void
		{
			
		}
		
		override public function update(elapsedTime:int):void 
		{
			super.update(elapsedTime);
			
			setVolume();
			if ( m_state != STATE_PAUSE )
			{
				if( m_spawnActive )
				{
					/*
					if ( GlobalVars.CURRENT_LEVEL + 1 < 5 )
					{
						m_currentWaveTime += elapsedTime;
						
						var waveProgress:int = Math.floor (m_currentWaveTime / m_totalWaveTime * 100);
						waveProgress = Math.max(1, waveProgress);
						
						if ( waveProgress <= 100 )
						{
							m_interface.topBar.debug.text = String(m_currentWaveTime) + "/" +
															String(m_totalWaveTime) + "=" +
															String(waveProgress) + "%";
						
							m_interface.bottomBar.progressLevel.progressMask.gotoAndStop(waveProgress);
						}
					}
					else
					{
						if ( GlobalVars.BOSS_INSTANCE )
						{
							var bossHP:int = Math.floor(GlobalVars.BOSS_INSTANCE.lifePercentage * 100);
							m_interface.bottomBar.progressLevel.progressMask.gotoAndStop(bossHP);
						}
					}
					*/
					
					if( !m_gameComplete )
						updateWave( elapsedTime );
				}
				
				NPCManager.getInstance().update(elapsedTime);
				MissileManager.getInstance().update(elapsedTime);
				ItemManager.getInstance().update(elapsedTime);
				ParticleManager.getInstance().update(elapsedTime);
			}
		}
		
		
		private function slideMessage():void
		{
			TweenMax.killTweensOf(m_interface.waveMessage);
			m_interface.waveMessage.visible = true;
			m_interface.waveMessage.scaleX = m_interface.waveMessage.scaleY = 4;
			m_interface.waveMessage.alpha = 0;
			
			TweenMax.to(m_interface.waveMessage, 0.75, { scaleX:1, scaleY:1, alpha:1, ease:Back.easeIn,onComplete:function():void
							{
								SoundManager.getInstance().playSFX("wavesign");
								TweenMax.to(m_interface.waveMessage, 3, { onComplete:function():void
												{
													TweenMax.to(m_interface.waveMessage, 0.5, { alpha:0, onComplete:function():void
																	{
																		m_interface.waveMessage.visible = false;
																	}
																});	
												}
											});	
							}
						});
		}
		
		private function updateWave(elapsedTime:int):void
		{
			
			if ( GlobalVars.CURRENT_LEVEL + 1 < 5 )
			{
				m_currentWaveTime += elapsedTime;
					
				var waveProgress:int = Math.floor (m_currentWaveTime / m_totalWaveTime * 100);
				waveProgress = Math.max(1, waveProgress);
						
				if ( waveProgress <= 100 )
				{
					m_interface.topBar.debug.text = String(m_currentWaveTime) + "/" +
													String(m_totalWaveTime) + "=" +
													String(waveProgress) + "%";
						
					m_interface.bottomBar.progressLevel.progressMask.gotoAndStop(waveProgress);
				}
			}
			else
			{
				if ( GlobalVars.BOSS_INSTANCE )
				{
					var bossHP:int = Math.floor(GlobalVars.BOSS_INSTANCE.lifePercentage * 100);
					m_interface.bottomBar.progressLevel.progressMask.gotoAndStop(bossHP);
				}
			}
			
			
			var offset:int;
			m_currSpawnTick += elapsedTime;
			if ( m_currSpawnTick >  m_spawnTick )
			{
				m_tickCounter++;
				
				//show first attack message /*by siput*/
				if (m_waveIndex == 0 && m_startWave)
				{
					m_startWave = false;
					m_interface.waveMessage.gotoAndStop(1);
					slideMessage();
				}
				
				if( m_currentWaveState == WAVE_NORMAL)
				{
					var unitId:String = m_waves.children()[m_waveIndex].children()[m_waveCurrGroup].attribute("id");
						
					var levelmin:int = m_waves.children()[m_waveIndex].children()[m_waveCurrGroup].attribute("min_rank"); 
					var levelmax:int = m_waves.children()[m_waveIndex].children()[m_waveCurrGroup].attribute("max_rank"); 
					var level:int = OpMath.randomRange(levelmin, levelmax);
					var spawnMax:int = m_waves.children()[m_waveIndex].children()[m_waveCurrGroup].attribute("count");
					
					m_waveCurrCtr++;
					
					for (var count:int = 0 ; count < m_spawnCount; count++)
					{
						var diff:int = spawnMax - m_waveCurrCtr;
						//m_waveCurrCtr++;
						
						if (diff >= 1)
						{
							offset = count * OpMath.randomRange(10, 13);
							spawnUnit(unitId, level ,offset);
						}
						else 
						{
							if ( m_waveCurrCtr >= spawnMax )
							{
								m_waveCurrGroup++;
								m_waveCurrCtr = 0;
							}
						}
					}
				
					if ( m_waveCurrGroup >= m_waves.children()[m_waveIndex].children().length() )
					{
						m_waveIndex++; 
						m_currentWaveState = m_waves.children()[m_waveIndex].attribute("type");
						
						if( m_currentWaveState == WAVE_BIG )
						{
							m_interface.waveMessage.gotoAndStop(WAVE_BIG);
							slideMessage();
						}
						else if( m_currentWaveState == WAVE_FINAL )
						{
							m_interface.waveMessage.gotoAndStop(WAVE_FINAL);
							slideMessage();
						}
						
						m_waveCurrGroup = 0;
						m_waveCurrCtr = 0;
					}
				}
				else if( m_currentWaveState == WAVE_BIG)
				{
					for ( var i:int = 0; i < m_waves.children()[m_waveIndex].children().length(); i++ )
					{
						unitId = m_waves.children()[m_waveIndex].children()[i].attribute("id");
						levelmin = m_waves.children()[m_waveIndex].children()[i].attribute("min_rank"); 
						levelmax = m_waves.children()[m_waveIndex].children()[i].attribute("max_rank"); 
						level = OpMath.randomRange(levelmin, levelmax);
						spawnMax = m_waves.children()[m_waveIndex].children()[i].attribute("count"); 
						
						for ( var j:int = 0; j < spawnMax; j++ )
						{
							offset = j * 20;
							spawnUnit(unitId, level, offset);
						}
					}
					
					m_currentWaveState = WAVE_NORMAL;
					m_waveIndex++;
					m_waveCurrGroup = 0;
					m_waveCurrCtr = 0;
				}
				else if( m_currentWaveState == WAVE_FINAL)
				{
					spawnUnit("E13", 1, 20);
					for ( i = 0; i < m_waves.children()[m_waveIndex].children().length(); i++ )
					{
						unitId = m_waves.children()[m_waveIndex].children()[i].attribute("id");
						levelmin = m_waves.children()[m_waveIndex].children()[i].attribute("min_rank"); 
						levelmax = m_waves.children()[m_waveIndex].children()[i].attribute("max_rank"); 
						level = OpMath.randomRange(levelmin, levelmax);
						spawnMax = m_waves.children()[m_waveIndex].children()[i].attribute("count"); 
						
						for ( j = 0; j < spawnMax; j++ )
						{
							offset = j * 20;
							spawnUnit(unitId, level, offset);
						}
					}
					m_currentWaveState = WAVE_COMPLETE;
				}
				if( m_currentWaveState == WAVE_BOSSFIGHT)
				{
					for ( i = 0; i < m_waves.children()[m_waveIndex].children().length(); i++ )
					{
						unitId = m_waves.children()[m_waveIndex].children()[i].attribute("id");
						levelmin = m_waves.children()[m_waveIndex].children()[i].attribute("min_rank"); 
						levelmax = m_waves.children()[m_waveIndex].children()[i].attribute("max_rank"); 
						level = OpMath.randomRange(levelmin, levelmax);
						spawnMax = m_waves.children()[m_waveIndex].children()[i].attribute("count"); 
						
						for ( j = 0; j < spawnMax; j++ )
						{
							offset = j * 20;
							spawnUnit(unitId, level, offset);
						}
					}
					m_currentWaveState = WAVE_COMPLETE;
				}
				else if( m_currentWaveState == WAVE_COMPLETE && NPCManager.getInstance().getEnemyCount() == 0 )
				{
					progressLevel();
				}
				
				m_currSpawnTick = 0;
				m_ctrLane = 0;
			}
		}
		
		private function progressLevel():void
		{
			m_gameComplete = true;
			
			GlobalVars.UNIT_BONUS = NPCManager.getInstance().getPlayerCount();
			GlobalVars.RES_POINT_GAIN = m_researchPointGain;
			GlobalVars.RESEARCH_POINT += m_researchPointGain;
			GlobalVars.IS_VICTORY = true;
					
			GlobalVars.CURRENT_SUB_LEVEL++;
			if ( GlobalVars.CURRENT_SUB_LEVEL >= 5 )
			{
				GlobalVars.CURRENT_LEVEL++;
				GlobalVars.CURRENT_SUB_LEVEL = 0;
				GlobalVars.TOTAL_COIN += NPCManager.getInstance().returnTrainCost();
			}
			
			var dummy:MovieClip = new MovieClip();
			
			TweenMax.to(dummy, 3, { onComplete:function():void 
									{ 
										if ( GlobalVars.CURRENT_LEVEL < 4 )
										{
											GameStateManager.getInstance().setState( State_WinScreen.getInstance() );
										}
										else
										{
											GameStateManager.getInstance().setState( State_EndingScreen.getInstance() );
										}
									} 
								  } );
		}
		
		
		
		private function spawnUnit(unitId:String, level:int, offset:int=0 ):void
		{
			var lane:int = Math.floor(OpMath.randomNumber(m_laneMax));
			var spawn:CBaseTeelos;
			
			if(unitId == "E01")
			{
				spawn = NPCManager.getInstance().add(CTeeloUztan, lane, 850 + offset, m_laneLayers[lane]);
			}
			else if(unitId == "E02")
			{
				spawn = NPCManager.getInstance().add(CTeeloRazark, lane, 850+offset, m_laneLayers[lane]);	
			}
			else if(unitId == "E03")
			{
				spawn = NPCManager.getInstance().add(CTeeloCroztan, lane, 850+offset, m_laneLayers[lane]);	
			}
			else if(unitId == "E04")
			{
				spawn = NPCManager.getInstance().add(CTeeloHestaclan, lane, 850 + offset, m_laneLayers[lane]);	
			}
			else if(unitId == "E05")
			{
				spawn = NPCManager.getInstance().add(CTeeloTeeclon, lane, 850+offset, m_laneLayers[lane]);	
			}
			else if(unitId == "E06")
			{
				spawn = NPCManager.getInstance().add(CTeeloUdizark, lane, 850+offset, m_laneLayers[lane]);	
			}
			else if(unitId == "E07")
			{
				spawn = NPCManager.getInstance().add(CTeeloUmaz, lane, 850+offset, m_laneLayers[lane]);	
			}
			else if(unitId == "E08")
			{
				spawn = NPCManager.getInstance().add(CTeeloRammer, lane, 850+offset, m_laneLayers[lane]);	
			}
			else if(unitId == "E09")
			{
				spawn = NPCManager.getInstance().add(CTeeloCaploztonCatapult, lane, 850+offset, m_laneLayers[lane]);	
			}
			else if(unitId == "E10")
			{
				spawn = NPCManager.getInstance().add(CTeeloBalistatoz, lane, 850+offset, m_laneLayers[lane]);	
			}
			else if(unitId == "E11")
			{
				spawn = NPCManager.getInstance().add(CTeeloPoztazark, lane, 850+offset, m_laneLayers[lane]);	
			}
			else if(unitId == "E13")
			{
				spawn = NPCManager.getInstance().add(CTeeloFlagee , lane, 850 + offset, m_laneLayers[lane]);	
			}
			else if(unitId == "E12")
			{
				spawn = NPCManager.getInstance().add(CTeeloTeegor, 2, 850+offset, m_laneLayers[2]);	
			}
			else if(unitId == "E14")
			{
				spawn = NPCManager.getInstance().add(CTeeloWeezee, lane, 850+offset, m_laneLayers[lane]);	
			}
			
			spawn.setLevel(level);
		}

		
		public function invalidateGold():void
		{
			m_interface.topBar.goldText.text = String(GlobalVars.TOTAL_COIN);
		}
		
		public function invalidateScore():void
		{
			m_interface.bottomBar.scoreText.text = String(GlobalVars.KILL_SCORE);
		}
		
		public function onStageMouseMove(event:MouseEvent):void
		{
			m_mouseX = event.stageX;
			m_mouseY = event.stageY;
		
			if ( m_state == STATE_PLACING || GlobalVars.CUSTOM_CURSOR )
			{
				m_dummyCursor.x = m_mouseX;
				m_dummyCursor.y = m_mouseY;
			}
			
			if ( m_state == STATE_RETREAT || m_state == STATE_SWAP_PHASE_01 || m_state == STATE_SWAP_PHASE_02 || GlobalVars.CUSTOM_CURSOR )
			{
				m_customCursor.x = m_mouseX;
				m_customCursor.y = m_mouseY;
			}
			
			if ( m_state == STATE_BARRAGE_TARGET )
			{
				//m_barrageTarget.x = m_mouseX;
				m_barrageTarget.y = 192;
				TweenMax.killTweensOf(m_barrageTarget);
				TweenMax.to(m_barrageTarget, 0.5, { x:m_mouseX } );
			}
			
			
			// TODO: GLOW UNIT ON HOVER
			/*
			// glow object (test)
			if ( m_state == STATE_RETREAT || m_state == STATE_SWAP_PHASE_01 || m_state == STATE_SWAP_PHASE_02 )
			{
				var teelo:CBaseTeelos = NPCManager.getInstance().queryUnitByHit(m_mouseX, m_mouseY);
				
				if( m_lastRetreatHover && teelo != m_lastRetreatHover )
					TweenMax.to(m_lastRetreatHover.getSprite(), 0.5, { glowFilter: { color:0x91e600, alpha:0, blurX:0, blurY:0 } } );
					
				if ( teelo && teelo != m_lastRetreatHover )
				{
					m_lastRetreatHover = teelo;
					TweenMax.to(teelo.getSprite(), 0.5, { glowFilter: { color:0x91e600, alpha:1, blurX:10, blurY:10 } } );
				}
			}
			*/
		}
		
		public function onStageMouseUp(event:MouseEvent):void
		{
			var cursorX:int = event.stageX;
			var cursorY:int = event.stageY;
			
			if ( m_state == STATE_RETREAT )
			{
				var teelo:CBaseTeelos = NPCManager.getInstance().queryUnitByHit(cursorX, cursorY);
				if ( teelo != null && !teelo.isDead() && !(teelo is CTeeloBaseSummoned) 
					 && !(teelo is CTeeloLastBarricade) && !CPlayerTeelos(teelo).retreated )
				{
					CPlayerTeelos(teelo).retreated = true;
					CPlayerTeelos(teelo).placementNode.obtained = false;
					CPlayerTeelos(teelo).placementNode = null;
						
					GlobalVars.TOTAL_COIN += Math.ceil( CPlayerTeelos(teelo).getTrainingCost() / 2 );
					invalidateGold();
					
					if ( teelo is CTeeloBaseBuilding || teelo is CTeeloTrap )
					{	if( CTeeloBaseBuilding(teelo).isBuildComplete() ) 
							teelo.damage(1000000, null);
					}
					else
					{
						teelo.changeAIState( AIState_Player_Retreat.getInstance() );
					}
					
					m_state = STATE_DEFAULT;
					
					if ( m_lastRetreatHover )
					{
						TweenMax.to(m_lastRetreatHover.getSprite(), 0.5, { glowFilter: { color:0x91e600, alpha:0, blurX:0, blurY:0 } } );
						m_lastRetreatHover = null;
					}
					
					toggleCustomCursor();
				}
			}
			else if ( m_state == STATE_SWAP_PHASE_01 )
			{
				teelo = NPCManager.getInstance().queryUnitByHit(cursorX, cursorY);
				
				if( teelo != null && !teelo.isDead() && !(teelo is CTeeloBaseSummoned) && !CPlayerTeelos(teelo).retreated )
				{
					if ( teelo is CTeeloBaseBuilding )
					{
						trace("Cannot swap building");
					}
					else
					{
						m_swapUnit01 = teelo;
						m_state = STATE_SWAP_PHASE_02;
					}
				}
			}
			else if ( m_state == STATE_SWAP_PHASE_02 )
			{
				teelo = NPCManager.getInstance().queryUnitByHit(cursorX, cursorY);
				if ( m_swapUnit01 && !m_swapUnit01.isDead() )
				{
					if( teelo != null && !teelo.isDead() && !(teelo is CTeeloBaseSummoned) && 
						!(teelo is CTeeloBaseBuilding) && !CPlayerTeelos(teelo).retreated )
					{
						if ( teelo is CTeeloBaseBuilding )
						{
							trace("Cannot swap building");
						}
						else if ( m_swapUnit01.laneIndex != teelo.laneIndex )
						{
							trace("Cannot swap units in different lane");
						}
						else
						{
							m_swapUnit02 = teelo;
							
							var node:CPlacementNode = CPlayerTeelos(m_swapUnit01).placementNode;
							var temp:int = node.x;
							
							m_swapUnit01.setDestination(CPlayerTeelos(m_swapUnit02).placementNode.x);
							m_swapUnit01.changeAIState(AIState_Player_Swap.getInstance());
							CPlayerTeelos(m_swapUnit01).placementNode = CPlayerTeelos(m_swapUnit02).placementNode;
							
							m_swapUnit02.setDestination(temp);
							m_swapUnit02.changeAIState( AIState_Player_Swap.getInstance() );
							CPlayerTeelos(m_swapUnit02).placementNode = node;
							
							m_state = STATE_DEFAULT;
							toggleCustomCursor();
						}
					}
				}
				else
				{
					m_customCursor.visible = false;
					Mouse.show();
					m_state = STATE_DEFAULT;
				}
			}
			else if ( m_state == STATE_BARRAGE_TARGET )
			{
				var targetLane:Array = [];
				
				for ( var i:int = 0; i < m_laneMax; i++ )
				{
					var nodeY:int = CPlacementNode(m_nodes[i][0]).y;
					if ( cursorY > nodeY - 40 && cursorY < nodeY + 20 )
					{
						for ( var j:int = 0; j < m_laneMax ; j ++)
						{
							targetLane.push(j);
						}
					}
				}
				
				// launch artillery
				if ( targetLane.length > 0 )
				{
					for ( i = 0; i < targetLane.length; i++ )
					{
						node = CPlacementNode(m_nodes[targetLane[i]][0]);
						var launchDelay:Number = OpMath.randomNumber(1);
						MissileManager.getInstance().launch(CMissileBarrage, m_effectLayer, -100, -50, 1, 
															FACTION.PLAYER, targetLane[i], 3100, UNITCLASS.NONE, 0, 1, true, null, 
															{targetX:cursorX, targetY:node.y, groundLevel:node.y, delay:launchDelay } );
					}
					
					m_interface.topBar.barrageButton.gotoAndStop(3);
					m_barrageUsed = true;
					m_barrageTarget.visible = false;
					m_state = STATE_DEFAULT;
				}
			}
		}
		
		public function onKeyUp(event:KeyboardEvent):void
		{
			if ( event.keyCode == Keyboard.ESCAPE )
			{
				m_state = STATE_DEFAULT;
				m_dummyCursor.visible = false;
				m_dummyCursor.x = m_mouseX;
				m_dummyCursor.y = m_mouseY;
				toggleNodeMouseEnable(false);
				toggleBottomBarEnable(true);
				m_barrageTarget.visible = false;
				
				if (!m_barrageUsed)
				{
					m_interface.topBar.barrageButton.gotoAndStop(1);
				}
				hidePlacementNode();
				
				if ( GlobalVars.CUSTOM_CURSOR )
				{
					m_customCursor.gotoAndStop(3);
				}
				else
				{
					m_customCursor.visible = false;
					Mouse.show();
				}
				
			}
		}
		
		public function onBottomBarMouseDown(event:MouseEvent):void
		{
			var button:MovieClip = MovieClip(event.currentTarget);
			
			button.gotoAndStop(2);
		}
		
		public function onBottomBarMouseUp(event:MouseEvent):void
		{
			var button:MovieClip = MovieClip(event.currentTarget);
			
			button.gotoAndStop(1);
			
			SoundManager.getInstance().playSFX("SN01");
			
			switch(button)
			{
				case m_interface.bottomBar.buttonMenu:
					if( m_state == STATE_DEFAULT )
					{
						m_screenOption = new mc_OptionInGame();
						m_bgOption = new mc_optionBG();
						m_owner.addChild(m_bgOption);
						m_owner.addChild(m_screenOption);
						m_screenOption.x = 137.5;
						m_screenOption.y = -300;
						m_bgOption.alpha = 0;
						m_bgOption.x = m_bgOption.y = 0;
						
						m_screenOption.sfx_YES.visible = true;
						m_screenOption.sfx_NO.visible = false;
						m_screenOption.kursor_NO.visible = !GlobalVars.CUSTOM_CURSOR;
						m_screenOption.kursor_YES.visible = GlobalVars.CUSTOM_CURSOR;
						
						m_screenOption.volume_bar.slider_music.addEventListener(MouseEvent.MOUSE_DOWN, startDragging);
						m_screenOption.volume_bar.slider_music.addEventListener(MouseEvent.MOUSE_UP, doneSetVol);
						m_screenOption.volume_bar.slider_music.addEventListener(MouseEvent.ROLL_OUT, doneSetVol);
						m_screenOption.LOW_quality.addEventListener(MouseEvent.CLICK, setQualityLOW);
						m_screenOption.MED_quality.addEventListener(MouseEvent.CLICK, setQualityMED);
						m_screenOption.HIGH_quality.addEventListener(MouseEvent.CLICK, setQualityHIGH);
						m_screenOption.NO_button_sfx.addEventListener(MouseEvent.CLICK, setSFX_off);
						m_screenOption.YES_button_sfx.addEventListener(MouseEvent.CLICK, setSFX_on);
						m_screenOption.NO_button_cursor.addEventListener(MouseEvent.CLICK, removeCustomCursor);
						m_screenOption.YES_button_cursor.addEventListener(MouseEvent.CLICK, setCustomCursor);	
						
						TweenMax.to(m_bgOption, 0.3, { 	alpha:1, 
														onComplete:function():void 
														{
															m_screenOption.close_menu.buttonMode = m_screenOption.close_menu.useHandCursor = true;
															m_screenOption.close_menu.addEventListener(MouseEvent.CLICK, closeMenuOption); 
														
														}
													} );
						TweenMax.to(m_screenOption, 0.55, {  x:137.5, y:128, ease:Back.easeInOut, 
															onComplete:function():void 
															{ 
																TweenMax.pauseAll();
															} 
														 });
													
						m_state = STATE_PAUSE;
					}
					break;
				case m_interface.bottomBar.buttonExit:
					if( m_state == STATE_DEFAULT )
					{
						m_exitPrompt = new exit_prompt();
						m_bgOption = new mc_optionBG();
						m_owner.addChild(m_bgOption);
						m_owner.addChild(m_exitPrompt);
						
						m_exitPrompt.x = 400;
						m_exitPrompt.y = 250;
						m_exitPrompt.scaleX = m_exitPrompt.scaleY = 0;
						m_bgOption.alpha = 0;
						m_bgOption.x = m_bgOption.y = 0;
						
						TweenMax.to(m_bgOption, 0.3, { alpha:1 } );
						TweenMax.to(m_exitPrompt, 0.25, { scaleX:1, scaleY:1, ease:Quint.easeIn , onComplete:function():void {
							TweenMax.pauseAll();
							m_exitPrompt.yes.alpha = 0;
							m_exitPrompt.no.alpha = 0;
							m_exitPrompt.yes.buttonMode = m_exitPrompt.yes.useHandCursor = true;
							m_exitPrompt.no.buttonMode = m_exitPrompt.no.useHandCursor = true;
							m_exitPrompt.yes.addEventListener(MouseEvent.MOUSE_UP, exitGame);
							m_exitPrompt.no.addEventListener(MouseEvent.MOUSE_UP, backToGame);
							}});
						
						m_state = STATE_PAUSE
					}
					break;
			}
			
			invalidateCursor();
		}
		
		private function invalidateCursor():void
		{
			if ( GlobalVars.CUSTOM_CURSOR )
			{
				stage.setChildIndex(m_customCursor, stage.numChildren - 1);
			}
		}
		
		private function exitGame(e:MouseEvent):void
		{
			m_owner.removeChild(m_bgOption);
			m_owner.removeChild(m_exitPrompt);
			GameStateManager.getInstance().setState(State_MainMenu.getInstance());
		}
		
		private function backToGame(e:MouseEvent):void
		{	
			TweenMax.to(m_exitPrompt, 0.25, { scaleX:1, scaleY:1, ease:Back.easeIn , onComplete:function():void {
							
							TweenMax.resumeAll();
							m_state = STATE_DEFAULT;
							m_exitPrompt.yes.removeEventListener(MouseEvent.MOUSE_UP, exitGame);
							m_exitPrompt.no.removeEventListener(MouseEvent.MOUSE_UP, backToGame);
							m_owner.removeChild(m_exitPrompt);
							}});
			TweenMax.to(m_bgOption, 0.3, { alpha:0 , onComplete:function():void {
							m_owner.removeChild(m_bgOption);
							}} );
		}
		
		private function startDragging(e:MouseEvent):void
		{
			var rect:Rectangle = new Rectangle(0, 0, 200, 0);
			e.currentTarget.startDrag(false, rect)
			
		}
		
		private function setVolume():void
		{
			if (m_screenOption != null)
			{
				//var vol:Number = Screen_Options.volume_bar.slider_music.x / 100;
				var vol:Number = m_screenOption.volume_bar.slider_music.x / (m_screenOption.volume_bar.bar_music.width - m_screenOption.volume_bar.bar_music.x);
	
				SoundManager.getInstance().musicVolume = vol;
			}
		}
		
		private function doneSetVol(e:MouseEvent):void
		{
			e.currentTarget.stopDrag();
		}
		
		private function setCustomCursor(e:MouseEvent):void
		{
			m_screenOption.kursor_YES.visible = true;
			m_screenOption.kursor_NO.visible = false;
			
			GlobalVars.CUSTOM_CURSOR = true;
			toggleCustomCursor();
		}
		
		private function toggleCustomCursor():void
		{
			if ( GlobalVars.CUSTOM_CURSOR )
			{
				m_customCursor.visible = true;
				Mouse.hide();
			
				if ( m_state != STATE_SWAP_PHASE_01 && m_state != STATE_SWAP_PHASE_02 && m_state != STATE_RETREAT )
				{
					m_customCursor.gotoAndStop(3);
					m_customCursor.x = m_mouseX;
					m_customCursor.y = m_mouseY;
					stage.setChildIndex(m_customCursor, stage.numChildren - 1);
				}	
			}
			else
			{
				if ( m_state != STATE_SWAP_PHASE_01 && m_state != STATE_SWAP_PHASE_02 && m_state != STATE_RETREAT )
				{
					m_customCursor.visible = false;
					Mouse.show();
				}
			}
		}
		
		
		private function removeCustomCursor(e:MouseEvent):void
		{
			m_screenOption.kursor_YES.visible = false;
			m_screenOption.kursor_NO.visible = true;		
			
			GlobalVars.CUSTOM_CURSOR = false;
			toggleCustomCursor();
		}
		
		private function setSFX_off(e:MouseEvent):void
		{
			m_screenOption.sfx_NO.visible = true;
			m_screenOption.sfx_YES.visible = false;
			SoundManager.getInstance().sfxEnable = false;
		}
		private function setSFX_on(e:MouseEvent):void
		{
			m_screenOption.sfx_NO.visible = false;
			m_screenOption.sfx_YES.visible = true;
			SoundManager.getInstance().sfxEnable = true;			
		}
		
		private function setQualityLOW(e:MouseEvent):void
		{
			stage.quality = StageQuality.LOW;
			m_screenOption.slider.x = m_screenOption.LOW_quality.x;
			
		}
		private function setQualityMED(e:MouseEvent):void
		{
			stage.quality = StageQuality.MEDIUM;
			m_screenOption.slider.x = m_screenOption.MED_quality.x;
		}
		private function setQualityHIGH(e:MouseEvent):void
		{
			stage.quality = StageQuality.HIGH;
			m_screenOption.slider.x = m_screenOption.HIGH_quality.x;
		}
		
		private function closeMenuOption(event:MouseEvent):void
		{
			
			TweenMax.to(m_bgOption, 0.25, { alpha:0 , 
											onComplete:function():void 
											{
												m_screenOption.close_menu.removeEventListener(MouseEvent.CLICK, closeMenuOption);
												m_owner.removeChild(m_bgOption);
												m_bgOption = null;
											} 
										} );
										
			TweenMax.to(m_screenOption, 0.75, { 	x:137.5, y: -300, ease:Back.easeInOut, 
												onComplete:function():void 
												{
													m_owner.removeChild(m_screenOption);
													m_screenOption = null;
													TweenMax.resumeAll();
													m_state = STATE_DEFAULT;
												}
											 } );
		}
		
		public function onTacticButtonMouseUp(event:MouseEvent):void
		{
			var button:MovieClip = MovieClip(event.currentTarget);
			
			SoundManager.getInstance().playSFX("SN01");
			
			if ( button == m_interface.topBar.retreatButton )
			{
				m_state = STATE_RETREAT;
				m_customCursor.x = m_mouseX;
				m_customCursor.y = m_mouseY;
				m_customCursor.visible = true;
				m_customCursor.gotoAndStop(1);
				Mouse.hide();
			}
			else if ( button == m_interface.topBar.swapButton )
			{
				m_state = STATE_SWAP_PHASE_01;
				m_customCursor.x = m_mouseX;
				m_customCursor.y = m_mouseY;
				m_customCursor.visible = true;
				m_customCursor.gotoAndStop(2);
				Mouse.hide();
			}
		}
		
		public function onBarrageButtonMouseUp(event:MouseEvent):void
		{
			if( !m_barrageUsed )
			{
				m_state = STATE_BARRAGE_TARGET;
				m_interface.topBar.barrageButton.gotoAndStop(2);
				m_barrageTarget.visible = true;
			}
		}
		
		public function displayLostScreen():void
		{
			GlobalVars.IS_VICTORY = false;
			
			//GlobalVars.TOTAL_COIN += NPCManager.getInstance().returnTrainCost();
			GlobalVars.TOTAL_COIN = GlobalVars.LAST_GOLD_STATE + GlobalVars.LAST_ASSET_STATE;
			
			GlobalVars.UNLOCKED_LEEGOS = GlobalVars.LAST_STATE_LEEGOS;
			GlobalVars.UNLOCKED_SEELDY = GlobalVars.LAST_STATE_SEELDY;
			GlobalVars.UNLOCKED_AGEESUM = GlobalVars.LAST_STATE_AGEESUM;
			GlobalVars.UNLOCKED_FEELA = GlobalVars.LAST_STATE_FEELA;
			GlobalVars.UNLOCKED_ELONEE = GlobalVars.LAST_STATE_ELONEE;
			GlobalVars.UNLOCKED_ENDROGEE = GlobalVars.LAST_STATE_ENDROGEE;
			GlobalVars.UNLOCKED_UGEE = GlobalVars.LAST_STATE_UGEE;
			GlobalVars.UNLOCKED_BARRICADE = GlobalVars.LAST_STATE_BARRICADE;
			GlobalVars.UNLOCKED_TREASURY = GlobalVars.LAST_STATE_TREASURY;
			GlobalVars.UNLOCKED_TRAP = GlobalVars.LAST_STATE_TRAP;
			GlobalVars.UNLOCKED_BALLISTA = GlobalVars.LAST_STATE_BALLISTA;
			
			GlobalVars.RESEARCH_POINT = GlobalVars.LAST_RESEARCH_POINT;
			
			
			NPCManager.getInstance().clear(true, true);
			GameStateManager.getInstance().setState( State_LoseScreen.getInstance() );
		}
		
		public function showPlacementNode():void
		{
			var d:Number = 0;
			
			if ( !m_placementNodeShown )
			{
				for( var y:int = 0; y < m_laneMax; y++ )
				{
					for(var x:int = 0; x < 9; x++ )
					{
						var node:CPlacementNode = m_nodes[y][x];
						var dummy:PlacementDummy = m_nodeView[y][x];
						
						if ( !node.obtained )
						{
							dummy.visible = true;
							dummy.scaleX = dummy.scaleY = 0;
							TweenMax.killTweensOf(dummy);
							TweenMax.to(dummy, 0.25, { delay:d, alpha:0.3, scaleX:1, scaleY:1 } );
							
							d += 0.05;
							
						}
					}
					d = 0;
				}
				
				m_placementNodeShown = true;
			}
		}
		
		public function hidePlacementNode():void
		{
			var d:Number = 0;
			
			if ( m_placementNodeShown )
			{
				for( var y:int; y < m_laneMax; y++ )
				{
					for( var x:int = 0; x < 9; x++ )
					{
						var dummy:PlacementDummy = m_nodeView[y][x];
						TweenMax.killTweensOf(dummy, true);
						TweenMax.to(dummy, 0.25, { delay:d, alpha:0, scaleX:0, scaleY:0, onComplete:function():void
													{
														dummy.visible = false;
													}
												});
						d += 0.05;						
					}
					d = 0;
				}
				
				m_placementNodeShown = false;
			}
		}
		
		public function getLaneYPos(index:int):int
		{
			return CPlacementNode(m_nodes[index][0]).y;
		}
		
		public function getLaneLayer(index:int):MovieClip
		{
			return m_laneLayers[index];
		}
		
		public function showBuildCursor(value:Boolean):void
		{
			switch(value)
			{
				case true:
					m_customCursor.gotoAndStop(4);
					if ( !GlobalVars.CUSTOM_CURSOR )
					{
						m_customCursor.visible = true;
						Mouse.hide();
						
						m_customCursor.x = m_mouseX;
						m_customCursor.y = m_mouseY;
					}
					break;
				case false:
					m_customCursor.gotoAndStop(3);
					if ( !GlobalVars.CUSTOM_CURSOR )
					{
						m_customCursor.visible = false;
						Mouse.show();
					}
					break;
			}
		}
		
		private function _checkMouseEventTrail($e:MouseEvent):void
		{
			trace("==================");
			var p:* = $e.target;
			
			while (p)
			{
				trace(">>", p.name,": ",p);
				p = p.parent;
			}
		};
		
		static public function getInstance(): State_GameLoop
		{
			if( m_instance == null ){
				m_instance = new State_GameLoop( new SingletonLock() );
			}
			return m_instance;
		}
	}
}

class SingletonLock{}