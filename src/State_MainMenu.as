package  
{

	/**
	 * ...
	 * @author Matthius Andy
	 */
	//import BalloonTown.CUnemployed;
	
	//import FramerateTracker;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import com.greensock.TweenMax;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.StageQuality;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	
	
	
	public class State_MainMenu extends CGameState
	{
		static private var m_instance:State_MainMenu;
		
		private var m_ScreenMainMenu:mc_MainMenu;
		private var m_screenOptions:mc_OptionScreen;
		private var m_ScreenCredits:mc_CreditsScreen;
		private var activeMenu:MovieClip;
		private var btnReady:Boolean;
		
		private var m_mouseX:int;
		private var m_mouseY:int;
		
		private var m_bgm:CSoundObject;
		private var m_customCursor:mcCustomCursor;
		
		public function State_MainMenu(lock:SingletonLock)
		{
			
		}
		
		override public function initialize(owner:DisplayObjectContainer):void 
		{
			super.initialize(owner);
			
			//create new object
			m_ScreenMainMenu = new mc_MainMenu();
			
			//register bgm
			SoundManager.getInstance().addMusic("BM01" , new BM01());
			SoundManager.getInstance().addMusic("BM05" , new BM05());
			SoundManager.getInstance().addMusic("BM06" , new BM06());
			SoundManager.getInstance().addMusic("BM07" , new BM07());
			SoundManager.getInstance().addMusic("BMStory", new BMStory());
			
			//register sfx
			SoundManager.getInstance().addSFX("SN02", new SN02());
			SoundManager.getInstance().addSFX("SN01", new SN01());
			SoundManager.getInstance().addSFX("SN19", new SN19());
			SoundManager.getInstance().addSFX("SN13" , new SN13());
			SoundManager.getInstance().addSFX("SN12_1", new SN12_1());
			SoundManager.getInstance().addSFX("SN12_2", new SN12_2());
			SoundManager.getInstance().addSFX("SN_dead_1", new SN_dead_1());
			SoundManager.getInstance().addSFX("SN_dead_2", new SN_dead_2());
			SoundManager.getInstance().addSFX("SN_dead_3", new SN_dead_3());
			SoundManager.getInstance().addSFX("SN_dead_4", new SN_dead_4());
			SoundManager.getInstance().addSFX("SNCoin", new SNCoin());
			SoundManager.getInstance().addSFX("SN07", new SN07());
			SoundManager.getInstance().addSFX("SN08", new SN08());
			SoundManager.getInstance().addSFX("SN09", new SN09());
			SoundManager.getInstance().addSFX("SN14", new SN14());
			SoundManager.getInstance().addSFX("SN10", new SN10());
			SoundManager.getInstance().addSFX("SN15", new SN15());
			SoundManager.getInstance().addSFX("SN16", new SN16());
			SoundManager.getInstance().addSFX("SN17_2" , new SN17_2());
			SoundManager.getInstance().addSFX("SN11", new SN11());
			SoundManager.getInstance().addSFX("scorefx" , new scorefx());
			SoundManager.getInstance().addSFX("scoredone", new scoredone());
			SoundManager.getInstance().addSFX("bash", new bash());
			SoundManager.getInstance().addSFX("wavesign", new wavesign());
			SoundManager.getInstance().addSFX("build", new SNBuild());
			SoundManager.getInstance().addSFX("SNLvl", new levelup());
			/*SoundManager.getInstance().addMusic("BM01" , new BM01());
			SoundManager.getInstance().addSFX("", );*/
			
			m_customCursor = new mcCustomCursor();
			m_customCursor.mouseEnabled = m_customCursor.mouseChildren = false;
		}
		override public function enter():void 
		{
			super.enter();
		
			m_owner.addChild(m_ScreenMainMenu);
			TweenMax.to(m_ScreenMainMenu, 0.5, { removeTint:true} );
			TweenMax.to(m_ScreenMainMenu.titles, 0.75, {x:m_ScreenMainMenu.titles.x, y:0, ease:Expo.easeOut});
			TweenMax.to(m_ScreenMainMenu.newGame, 0.5, { x:665, y:m_ScreenMainMenu.newGame.y, ease:Back.easeIn, onComplete:function():void
			{
				TweenMax.to(m_ScreenMainMenu.continueGame, 0.5, { x:665, y:m_ScreenMainMenu.continueGame.y, ease:Back.easeIn, onComplete:function():void
				{
					TweenMax.to(m_ScreenMainMenu.options, 0.5, { x:665, y:m_ScreenMainMenu.options.y, ease:Back.easeIn, onComplete:function():void
					{
						TweenMax.to(m_ScreenMainMenu.credits, 0.5, { x:665, y:m_ScreenMainMenu.credits.y, ease:Back.easeIn, onComplete:function():void
						{
							btnReady = true;
						}})			
					}})
				}})	
			}});
			m_bgm = SoundManager.getInstance().playMusic("BM01");
			
			stage.addChild(m_customCursor);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			
			toggleCustomCursor();
		}
		override public function update(elapsedTime:int):void 
		{
			super.update(elapsedTime);
			setVolume();
			
			stage.setChildIndex(m_customCursor, stage.numChildren - 1);
			//register button when button animation done
			
			if (btnReady)
			{
				registerButton(m_ScreenMainMenu.newGame);
				registerButton(m_ScreenMainMenu.continueGame);
				registerButton(m_ScreenMainMenu.options);
				registerButton(m_ScreenMainMenu.credits);
			}
			
		}
		
		override public function exit():void 
		{
			super.exit();
			stage.removeChild(m_customCursor);
			m_bgm.stop();
			unregisterButton(m_ScreenMainMenu.newGame);
			unregisterButton(m_ScreenMainMenu.continueGame);
			unregisterButton(m_ScreenMainMenu.options);
			unregisterButton(m_ScreenMainMenu.credits);
			m_owner.removeChild(m_ScreenMainMenu);
			
		}
		
		private function navigateTo(url:String):void
		{
			var request:URLRequest = new URLRequest(url);
			navigateToURL(request);
		}
		
		private function onMouseClick(event:MouseEvent):void
		{
			SoundManager.getInstance().playSFX("SN01");
		}
		
		
		private function registerButton(mc:MovieClip):void
		{
			mc.buttonMode = true;
			mc.useHandCursor = true;
                  
			mc.addEventListener(MouseEvent.MOUSE_DOWN, onMouseClick);
			mc.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			mc.addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
			mc.addEventListener(MouseEvent.ROLL_OUT, onMouseLeave);
		}
		private function unregisterButton(mc:MovieClip):void
		{
			mc.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseClick);
			mc.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);			
			mc.removeEventListener(MouseEvent.ROLL_OVER, onMouseOver);
			mc.removeEventListener(MouseEvent.ROLL_OUT, onMouseLeave);
		}
      
		
		private function onMouseOver(event:MouseEvent):void
		{
			var mc:MovieClip = MovieClip(event.currentTarget);
			
			mc.gotoAndStop(2);
			SoundManager.getInstance().playSFX("SN02");
		}
               
		private function onMouseLeave(event:MouseEvent):void
		{
			var mc:MovieClip = MovieClip(event.currentTarget);
			
			mc.gotoAndStop(1);
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			var mc:MovieClip = MovieClip(event.currentTarget);
			
			mc.gotoAndStop(2);
			
			switch(mc)
			{
				case m_ScreenMainMenu.newGame:
				Serializer.getInstance().resetData();
				if (activeMenu != null)
				{
					TweenMax.to(activeMenu, 0.75, { x:0 ,y: -300, ease:Back.easeInOut , onComplete:function():void
					{
						m_owner.removeChild(activeMenu);
						activeMenu = null;
						m_ScreenCredits = null;
						m_screenOptions = null;
						TweenMax.to(m_ScreenMainMenu, 0.5, { tint:0x000000 , onComplete:function():void {
								GameStateManager.getInstance().setState(State_StoryScreen.getInstance());
								TweenMax.killAll();
								}});
					}});
				}
				else
				{ 
					TweenMax.to(m_ScreenMainMenu, 0.5, { tint:0x000000 , onComplete:function():void {
						GameStateManager.getInstance().setState(State_StoryScreen.getInstance());
						TweenMax.killAll();
						}});
				}
				break;
				case m_ScreenMainMenu.continueGame:
				Serializer.getInstance().loadData();
				if (activeMenu != null)
				{
					TweenMax.to(activeMenu, 0.75, { x:0 ,y: -300, ease:Back.easeInOut , onComplete:function():void
					{
						m_owner.removeChild(activeMenu);
						activeMenu = null;
						m_ScreenCredits = null;
						m_screenOptions = null;
						TweenMax.to(m_ScreenMainMenu, 0.5, { tint:0x000000 , onComplete:function():void {
							GameStateManager.getInstance().setState(State_BarrackScreen.getInstance());
							TweenMax.killAll();
							}});
					}});
				}
				else
				{ 
					TweenMax.to(m_ScreenMainMenu, 0.5, { tint:0x000000 , onComplete:function():void {
						GameStateManager.getInstance().setState(State_BarrackScreen.getInstance());
						TweenMax.killAll();
						}});
				}
				break;
				case m_ScreenMainMenu.options:
				if (m_screenOptions == null)
				{
					if (activeMenu != null)
					{	
						mc.mouseEnabled = false;
						TweenMax.to(activeMenu, 0.75, { x:0, y: -300, ease:Back.easeInOut , onComplete:function():void
						{
							mc.mouseEnabled = true;
							m_owner.removeChild(activeMenu);
							activeMenu = null;
							m_ScreenCredits = null;
							m_screenOptions = new mc_OptionScreen();
							m_owner.addChild(m_screenOptions);
							activeMenu = m_screenOptions;
							//trace(activeMenu);
							m_screenOptions.x = 0;
							m_screenOptions.y = -300;
							
							m_screenOptions.sfx_YES.visible = true;
							m_screenOptions.sfx_NO.visible = false;
							m_screenOptions.kursor_NO.visible = !GlobalVars.CUSTOM_CURSOR;
							m_screenOptions.kursor_YES.visible = GlobalVars.CUSTOM_CURSOR;
							
							m_screenOptions.volume_bar.slider_music.addEventListener(MouseEvent.MOUSE_DOWN, startDragging);
							m_screenOptions.volume_bar.slider_music.addEventListener(MouseEvent.MOUSE_UP, doneSetVol);
							m_screenOptions.volume_bar.slider_music.addEventListener(MouseEvent.ROLL_OUT, doneSetVol);
							m_screenOptions.LOW_quality.addEventListener(MouseEvent.CLICK, setQualityLOW);
							m_screenOptions.MED_quality.addEventListener(MouseEvent.CLICK, setQualityMED);
							m_screenOptions.HIGH_quality.addEventListener(MouseEvent.CLICK, setQualityHIGH);
							m_screenOptions.NO_button_sfx.addEventListener(MouseEvent.CLICK, setSFX_off);
							m_screenOptions.YES_button_sfx.addEventListener(MouseEvent.CLICK, setSFX_on);
							m_screenOptions.NO_button_cursor.addEventListener(MouseEvent.CLICK, removeCustomCursor);
							m_screenOptions.YES_button_cursor.addEventListener(MouseEvent.CLICK, setCustomCursor);
							//TweenMax.to(Screen_Options, 1, {x:260, y:300, ease:Bounce.easeOut});
							TweenMax.to(m_screenOptions, 0.55, {x:0, y:180, ease:Back.easeInOut});
						}});
					}
					else
					{
						m_screenOptions = new mc_OptionScreen();
						m_owner.addChild(m_screenOptions);
						activeMenu = m_screenOptions;
						//trace(activeMenu);
						m_screenOptions.x = 0;
						m_screenOptions.y = -300;
						
						m_screenOptions.sfx_YES.visible = true;
						m_screenOptions.sfx_NO.visible = false;

						m_screenOptions.kursor_NO.visible = !GlobalVars.CUSTOM_CURSOR;
						m_screenOptions.kursor_YES.visible = GlobalVars.CUSTOM_CURSOR;
						
						m_screenOptions.volume_bar.slider_music.addEventListener(MouseEvent.MOUSE_DOWN, startDragging);
						m_screenOptions.volume_bar.slider_music.addEventListener(MouseEvent.MOUSE_UP, doneSetVol);
						m_screenOptions.volume_bar.slider_music.addEventListener(MouseEvent.ROLL_OUT, doneSetVol);
						m_screenOptions.LOW_quality.addEventListener(MouseEvent.CLICK, setQualityLOW);
						m_screenOptions.MED_quality.addEventListener(MouseEvent.CLICK, setQualityMED);
						m_screenOptions.HIGH_quality.addEventListener(MouseEvent.CLICK, setQualityHIGH);
						m_screenOptions.NO_button_sfx.addEventListener(MouseEvent.CLICK, setSFX_off);
						m_screenOptions.YES_button_sfx.addEventListener(MouseEvent.CLICK, setSFX_on);
						m_screenOptions.NO_button_cursor.addEventListener(MouseEvent.CLICK, removeCustomCursor);
						m_screenOptions.YES_button_cursor.addEventListener(MouseEvent.CLICK, setCustomCursor);						
						
						//TweenMax.to(Screen_Options, 1, {x:260, y:300, ease:Bounce.easeOut});
						TweenMax.to(m_screenOptions, 0.55, { x:0, y:180, ease:Back.easeInOut, onComplete:function():void { mc.mouseEnabled = true; }} );
					}
					
				}
				break;
				case m_ScreenMainMenu.credits:
				
				if (m_ScreenCredits == null)
				{		
					if (activeMenu != null)
					{
						mc.mouseEnabled = false;
						TweenMax.to(activeMenu, 0.75, { x:0, y: -300, ease:Back.easeInOut , onComplete:function():void
						{
							mc.mouseEnabled = true;
							m_owner.removeChild(activeMenu);
							activeMenu = null;
							m_screenOptions = null;
							m_ScreenCredits = new mc_CreditsScreen();
							m_owner.addChild(m_ScreenCredits);
							activeMenu = m_ScreenCredits;
							m_ScreenCredits.x = 0;
							m_ScreenCredits.y = -300;
							TweenMax.to(m_ScreenCredits, 0.55, {x:0, y:180, ease:Back.easeInOut});
						}});
					}
					else
					{
						mc.mouseEnabled = false;
						m_ScreenCredits = new mc_CreditsScreen();
						m_owner.addChild(m_ScreenCredits);
						activeMenu = m_ScreenCredits;
						m_ScreenCredits.x = 0;
						m_ScreenCredits.y = -300;
						TweenMax.to(m_ScreenCredits, 0.55, { x:0, y:180, ease:Back.easeInOut , onComplete:function():void { mc.mouseEnabled = true; }} );
					}
				}
				break;
			}
		}
		
		private function startDragging(e:MouseEvent):void
		{
			var rect:Rectangle = new Rectangle(0, 0, 200, 0);
			e.currentTarget.startDrag(false, rect)
			
		}
		
		private function setVolume():void
		{
			if (m_screenOptions != null)
			{
				//var vol:Number = Screen_Options.volume_bar.slider_music.x / 100;
				var vol:Number = m_screenOptions.volume_bar.slider_music.x / (m_screenOptions.volume_bar.bar_music.width - m_screenOptions.volume_bar.bar_music.x);
	
				SoundManager.getInstance().musicVolume = vol;
			}
		}
		
		private function doneSetVol(e:MouseEvent):void
		{
			e.currentTarget.stopDrag();
		}
		
		private function setCustomCursor(e:MouseEvent):void
		{
			m_screenOptions.kursor_YES.visible = true;
			m_screenOptions.kursor_NO.visible = false;
			
			GlobalVars.CUSTOM_CURSOR = true;
			toggleCustomCursor();
			
		}
		
		private function removeCustomCursor(e:MouseEvent):void
		{
			m_screenOptions.kursor_YES.visible = false;
			m_screenOptions.kursor_NO.visible = true;		
			
			GlobalVars.CUSTOM_CURSOR = false;
			toggleCustomCursor();
		}
		
		private function onStageMouseMove(event:MouseEvent):void
		{
			m_mouseX = event.stageX;
			m_mouseY = event.stageY;
		
			m_customCursor.x = m_mouseX;
			m_customCursor.y = m_mouseY;
		}
		
		private function toggleCustomCursor():void
		{
			if ( GlobalVars.CUSTOM_CURSOR )
			{
				m_customCursor.visible = true;
				Mouse.hide();
				m_customCursor.gotoAndStop(3);
				m_customCursor.x = stage.mouseX;
				m_customCursor.y = stage.mouseY;
				stage.setChildIndex(m_customCursor, stage.numChildren - 1);
				/*if ( m_state != STATE_SWAP_PHASE_01 && m_state != STATE_SWAP_PHASE_02 && m_state != STATE_RETREAT )
				{
					m_customCursor.gotoAndStop(3);
					m_customCursor.x = m_mouseX;
					m_customCursor.y = m_mouseY;
					stage.setChildIndex(m_customCursor, stage.numChildren - 1);
				}	*/
			}
			else
			{
				m_customCursor.visible = false;
				Mouse.show();
				/*if ( m_state != STATE_SWAP_PHASE_01 && m_state != STATE_SWAP_PHASE_02 && m_state != STATE_RETREAT )
				{
					m_customCursor.visible = false;
					Mouse.show();
				}*/
			}
		}
		
		private function setSFX_off(e:MouseEvent):void
		{
			m_screenOptions.sfx_NO.visible = true;
			m_screenOptions.sfx_YES.visible = false;
			SoundManager.getInstance().sfxEnable = false;
		}
		
		private function setSFX_on(e:MouseEvent):void
		{
			m_screenOptions.sfx_NO.visible = false;
			m_screenOptions.sfx_YES.visible = true;
			SoundManager.getInstance().sfxEnable = true;			
		}
		
		private function setQualityLOW(e:MouseEvent):void
		{
			stage.quality = StageQuality.LOW;
			m_screenOptions.slider.x = m_screenOptions.LOW_quality.x;
			
		}
		
		private function setQualityMED(e:MouseEvent):void
		{
			stage.quality = StageQuality.MEDIUM;
			m_screenOptions.slider.x = m_screenOptions.MED_quality.x;
		}
		
		private function setQualityHIGH(e:MouseEvent):void
		{
			stage.quality = StageQuality.HIGH;
			m_screenOptions.slider.x = m_screenOptions.HIGH_quality.x;
		}
		
		
		
		/* ============================
		 * 			SINGLETON
		 * ============================
		*/
		
		static public function getInstance(): State_MainMenu
		{
			if ( m_instance == null )
			{
				m_instance = new State_MainMenu( new SingletonLock() );
			}
			return m_instance;
		}
	}

}
class SingletonLock{}