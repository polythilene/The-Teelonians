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
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.StageQuality;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.geom.Rectangle;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	
	
	public class State_StoryScreen extends CGameState
	{
		static private var m_instance:State_StoryScreen;
		
		private var Screen_Story:mc_ScreenStory;
		
		//text variables
		private var m_firstWord:int = 0;
		private var m_indexText:int = 1;
		private var m_indexEvent:int = 1;
		private var text_tick:int = 0;
		private var showText:Boolean = false;
		
		private var m_mouseX:int;
		private var m_mouseY:int;

		private var storyText:Array = new Array();
	
		private var m_bgm:CSoundObject;
		private var m_customCursor:mcCustomCursor;
		
		public function State_StoryScreen(lock:SingletonLock)
		{
			
		}
		
		override public function initialize(owner:DisplayObjectContainer):void 
		{
			super.initialize(owner);
			
			Screen_Story = new mc_ScreenStory();
			
			m_customCursor = new mcCustomCursor();
			m_customCursor.mouseEnabled = m_customCursor.mouseChildren = false;
		
		}
		override public function enter():void 
		{
			super.enter();
			
			m_owner.addChild(Screen_Story);
			Screen_Story.gotoAndStop(1);
			Screen_Story.scene1.gotoAndStop(1);
			Screen_Story.x = 400;
			Screen_Story.y = 258.1;
			Screen_Story.scene1.play();
			
			m_bgm = SoundManager.getInstance().playMusic("BMStory");
			
			registerButton(Screen_Story.skip_btn);
			/*Screen_Story.panel.scaleX = Screen_Story.panel.scaleY = 0;
			Screen_Story.panel.ok_btn.gotoAndStop(1);
			TweenMax.to(Screen_Story.podium_grass , 0.5, { x:-28, y:418, ease:Quint.easeOut , onComplete:function():void {
				TweenMax.to(Screen_Story.podium , 0.5, { x:0, y:Screen_Story.podium.y, ease:Quint.easeOut , onComplete:function():void {
					TweenMax.to(Screen_Story.panel , 0.5, {scaleX:1, scaleY:1 , ease:Quint.easeOut } );
					}});
			}})
			TweenMax.to(Screen_Story.panel.ok_btn, 0.5, {colorMatrixFilter:{colorize:0xffffff, amount:1, brightness:0.5}});	
			registerButton(Screen_Story.panel.ok_btn);
			registerButton(Screen_Story.panel);*/
			stage.addChild(m_customCursor);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			
			toggleCustomCursor();
		}
		
		override public function update(elapsedTime:int):void 
		{
			super.update(elapsedTime);
			stage.setChildIndex(m_customCursor, stage.numChildren - 1);
			if (Screen_Story.currentFrame == 7 && Screen_Story.scene7.endMovie)
			{
				GameStateManager.getInstance().setState(State_ScoutScreen.getInstance());
			}
			
			/*if (showText)
			{
				text_tick += elapsedTime;
				
				if (text_tick > 10)
				{
					addText();
					text_tick = 0;
				}
			}*/
				
		}
		
		private function addText():void
		{
			m_firstWord++;
			var takeString:String = storyText[m_indexEvent][m_indexText].substr(0, m_firstWord);
			Screen_Story.panel.dialogtext.text = takeString;
			//Screen_Story.dialogPanel["dialogtext_" + m_indexText].text = takeString;
			if ((m_firstWord + 1) >= storyText[m_indexEvent][m_indexText].length) {
				m_firstWord = storyText[m_indexEvent][m_indexText].length - 1;
			}
		}
		private function onStageMouseMove(event:MouseEvent):void
		{
			m_mouseX = event.stageX;
			m_mouseY = event.stageY;
		
			m_customCursor.x = m_mouseX;
			m_customCursor.y = m_mouseY;
		}
		
		override public function exit():void 
		{
			stage.removeChild(m_customCursor);
			m_bgm.stop();
			m_owner.removeChild(Screen_Story);
			super.exit();
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
		
		private function navigateTo(url:String):void
		{
			var request:URLRequest = new URLRequest(url);
			navigateToURL(request);
		}
		
		private function onMouseClick(event:MouseEvent):void
		{
			var mc:MovieClip = MovieClip(event.currentTarget);
			
			//mc.gotoAndStop(3);
			
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
			trace(mc);
			mc.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseClick);
			mc.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);			
			mc.removeEventListener(MouseEvent.ROLL_OVER, onMouseOver);
			mc.removeEventListener(MouseEvent.ROLL_OUT, onMouseLeave);
		}
      
		
		private function onMouseOver(event:MouseEvent):void
		{
			/*var mc:MovieClip = MovieClip(event.currentTarget);
			
			mc.gotoAndStop(2);
			
			m_sfx = SoundManager.getInstance().playSFX("SFX_BtnRollover");*/
			//trace("rollover");
			SoundManager.getInstance().playSFX("SN02");
		}
               
		private function onMouseLeave(event:MouseEvent):void
		{
			//trace("rollout");

			/*var mc:MovieClip = MovieClip(event.currentTarget);
			
			mc.gotoAndStop(1);*/
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			var mc:MovieClip = MovieClip(event.currentTarget);
			
			GameStateManager.getInstance().setState(State_ScoutScreen.getInstance());
			
			//TweenMax.to(mc.dialogPanel.masking, 0.5, { height:(mc.dialogPanel.masking.height + 65) } );
			/*switch(mc)
			{
				case Screen_Story.panel:
				if (m_firstWord < storyText[m_indexEvent][m_indexText].length - 1)
				{
					m_firstWord = storyText[m_indexEvent][m_indexText].length - 1;
				}
				else
				{
					m_indexText++;
					m_firstWord = 0;
				}
				
				if (m_indexText >= storyText[m_indexEvent].length)
				{
					TweenMax.to(Screen_Story.panel.ok_btn, 0.5, { colorMatrixFilter: { }} );
					unregisterButton(Screen_Story.panel);
					registerButton(Screen_Story.panel.ok_btn);
					showText = false;

				}
				break;
				case Screen_Story.panel.ok_btn:
				mc.gotoAndStop(1);
				TweenMax.to(Screen_Story.panel , 0.5, { scaleX:0, scaleY:0 , ease:Quint.easeOut, onComplete:function():void {
				TweenMax.to(Screen_Story.podium , 0.5, { x:-300, y:0, ease:Quint.easeOut , onComplete:function():void {
					TweenMax.to(Screen_Story.podium_grass , 0.5, { x:-28, y:500, ease:Quint.easeOut , onComplete:function():void {
						GameStateManager.getInstance().setState(State_BarrackScreen.getInstance());
						}} );
					}});
				}})
				break;
			}*/
			
		}
		
		private function startDragging(e:MouseEvent):void
		{
			var rect:Rectangle = new Rectangle(0, 0, 100, 0);
			e.currentTarget.startDrag(false, rect)
		}
		private function setVolume():void
		{
			/*var vol:Number = mc_ScreenOptions.volume_bar.slider_music.x / 100;
			
			SoundManager.getInstance().musicVolume = vol;*/
		}
		
		private function doneSetVol(e:MouseEvent):void
		{
			//e.currentTarget.stopDrag();
		}
		private function setCustomCursor(e:MouseEvent):void
		{
			/*useCursor = true;
			mc_ScreenOptions.select_NO.visible = false;
			mc_ScreenOptions.select_YES.visible = true;
			Mouse.hide();
			customCursor = new cursor();
			stage.addChild(customCursor);*/
		}
		private function removeCustomCursor(e:MouseEvent):void
		{
			/*useCursor = false;
			mc_ScreenOptions.select_NO.visible = true;
			mc_ScreenOptions.select_YES.visible = false;
			stage.removeChild(customCursor);
			customCursor = null;
			Mouse.show();*/
			
		}
		private function setQualityLOW(e:MouseEvent):void
		{
			stage.quality = StageQuality.LOW;
			//mc_ScreenOptions.slider.x = mc_ScreenOptions.LOW_quality.x;
			
		}
		private function setQualityMED(e:MouseEvent):void
		{
			stage.quality = StageQuality.MEDIUM;
			//mc_ScreenOptions.slider.x = mc_ScreenOptions.MED_quality.x;
		}
		private function setQualityHIGH(e:MouseEvent):void
		{
			stage.quality = StageQuality.HIGH;
			//mc_ScreenOptions.slider.x = mc_ScreenOptions.HIGH_quality.x;
		}
		
		
		
		/* ============================
		 * 			SINGLETON
		 * ============================
		*/
		
		static public function getInstance(): State_StoryScreen
		{
			if ( m_instance == null )
			{
				m_instance = new State_StoryScreen( new SingletonLock() );
			}
			return m_instance;
		}
	}

}
class SingletonLock{}