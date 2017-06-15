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
	
	
	
	public class State_LoseScreen extends CGameState
	{
		static private var m_instance:State_LoseScreen;
		
		private var Screen_Lose:mc_LoseScreen;
		
		private var m_mouseX:int;
		private var m_mouseY:int;
		
		private var m_bgm:CSoundObject;
		
		private var donationGold:int;
		private var currentGold:int;
		
		private var m_customCursor:mcCustomCursor;
		
		public function State_LoseScreen(lock:SingletonLock)
		{
			
		}
		
		override public function initialize(owner:DisplayObjectContainer):void 
		{
			super.initialize(owner);
			
			//adding new object
			Screen_Lose = new mc_LoseScreen();
			
			m_customCursor = new mcCustomCursor();
			m_customCursor.mouseEnabled = m_customCursor.mouseChildren = false;	
			//SoundManager.getInstance().addSFX("SN02", new SN02());
			//SoundManager.getInstance().addSFX("SN01", new SN01());
		}
		override public function enter():void 
		{
			super.enter();
			
			m_owner.addChild(Screen_Lose);
			
			Screen_Lose.panel.scaleX = Screen_Lose.panel.scaleY = 0;
			Screen_Lose.panel.accept_btn.gotoAndStop(1);
			Screen_Lose.panel.decline_btn.gotoAndStop(1);
			
			TweenMax.to(Screen_Lose.podium_grass , 0.25, { x:-28, y:418, ease:Quint.easeOut , onComplete:function():void {
				TweenMax.to(Screen_Lose.podium , 0.25, { x:0, y:Screen_Lose.podium.y, ease:Quint.easeOut , onComplete:function():void {
					TweenMax.to(Screen_Lose.panel , 0.25, {scaleX:1, scaleY:1 , ease:Quint.easeOut } );
					}});
			}})
			
			var curr_level:int = GlobalVars.CURRENT_LEVEL;
			var curr_sub_level:int = GlobalVars.CURRENT_SUB_LEVEL;
			donationGold = GlobalVars.LEVEL_DONATION[curr_level][curr_sub_level];
			
			currentGold = GlobalVars.TOTAL_COIN;
			
			
			Screen_Lose.panel.donation_gold.text = String(donationGold);
			Screen_Lose.panel.current_gold.text = String(currentGold);
			
			
			registerButton(Screen_Lose.panel.accept_btn);
			registerButton(Screen_Lose.panel.decline_btn);
			
			m_bgm = SoundManager.getInstance().playMusic("BM07");
			
			stage.addChild(m_customCursor);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			
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
		
		override public function update(elapsedTime:int):void 
		{
			super.update(elapsedTime);
			
			
		}
		
		
		override public function exit():void 
		{
			m_bgm.stop();
			m_owner.removeChild(Screen_Lose);
			super.exit();
		}
		
		
		private function navigateTo(url:String):void
		{
			var request:URLRequest = new URLRequest(url);
			navigateToURL(request);
		}
		
		private function onMouseClick(event:MouseEvent):void
		{
			var mc:MovieClip = MovieClip(event.currentTarget);
			SoundManager.getInstance().playSFX("SN01");
			
			mc.gotoAndStop(2);
			
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
			/*var mc:MovieClip = MovieClip(event.currentTarget);
			
			mc.gotoAndStop(2);
			
			m_sfx = SoundManager.getInstance().playSFX("SFX_BtnRollover");*/
			//trace("rollover");
			var mc:MovieClip = MovieClip(event.currentTarget);
			TweenMax.to(mc, 0.15, {glowFilter:{color:0x996600, alpha:1, blurX:10, blurY:10,strength:1.5, quality:3}});
			SoundManager.getInstance().playSFX("SN02");
		}
               
		private function onMouseLeave(event:MouseEvent):void
		{
			//trace("rollout");

			/*var mc:MovieClip = MovieClip(event.currentTarget);
			
			mc.gotoAndStop(1);*/
			var mc:MovieClip = MovieClip(event.currentTarget);
			TweenMax.to(mc, 0.15, {glowFilter:{color:0x996600, alpha:0, blurX:10, blurY:10,strength:2, quality:3}});
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			var mc:MovieClip = MovieClip(event.currentTarget);
		
			mc.gotoAndStop(1);
			
			switch (mc)
			{
				case Screen_Lose.panel.accept_btn:
				GlobalVars.TOTAL_COIN = donationGold;
				TweenMax.to(Screen_Lose.panel , 0.25, { scaleX:0, scaleY:0 , ease:Quint.easeOut, onComplete:function():void {
				TweenMax.to(Screen_Lose.podium , 0.25, { x:-300, y:0, ease:Quint.easeOut , onComplete:function():void {
					TweenMax.to(Screen_Lose.podium_grass , 0.25, { x:-28, y:500, ease:Quint.easeOut , onComplete:function():void {
						GameStateManager.getInstance().setState(State_BarrackScreen.getInstance());
						}} );
					}});
				}})
				break;
				case Screen_Lose.panel.decline_btn:
				GlobalVars.TOTAL_COIN = currentGold;
				TweenMax.to(Screen_Lose.panel , 0.25, { scaleX:0, scaleY:0 , ease:Quint.easeOut, onComplete:function():void {
				TweenMax.to(Screen_Lose.podium , 0.25, { x:-300, y:0, ease:Quint.easeOut , onComplete:function():void {
					TweenMax.to(Screen_Lose.podium_grass , 0.25, { x:-28, y:500, ease:Quint.easeOut , onComplete:function():void {
						GameStateManager.getInstance().setState(State_BarrackScreen.getInstance());
						}} );
					}});
				}})
				break;
			}
			
			/*TweenMax.to(Screen_Lose.panel , 0.25, { scaleX:0, scaleY:0 , ease:Quint.easeOut, onComplete:function():void {
				TweenMax.to(Screen_Lose.podium , 0.25, { x:-300, y:0, ease:Quint.easeOut , onComplete:function():void {
					TweenMax.to(Screen_Lose.podium_grass , 0.25, { x:-28, y:500, ease:Quint.easeOut , onComplete:function():void {
						GameStateManager.getInstance().setState(State_BarrackScreen.getInstance());
						}} );
					}});
				}})*/
			
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
		
		static public function getInstance(): State_LoseScreen
		{
			if ( m_instance == null )
			{
				m_instance = new State_LoseScreen( new SingletonLock() );
			}
			return m_instance;
		}
	}

}
class SingletonLock{}