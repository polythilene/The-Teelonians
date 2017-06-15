package  
{

	/**
	 * ...
	 * @author Matthius Andy
	 */
	//import BalloonTown.CUnemployed;
	
	//import FramerateTracker;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.ui.Keyboard;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MorphShape;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.net.SharedObject;
	import flash.geom.Rectangle;
	import flash.display.StageQuality;
	import gs.TweenMax;
	import gs.TweenLite;
	import gs.easing.*;
	import gs.plugins.*;
	
	import flash.system.Capabilities;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	
	public class State_TutorialScreen extends CGameState
	{
		static private var m_instance:State_TutorialScreen;
		
		private var m_bgm:CSoundObject;
		
		public function State_TutorialScreen(lock:SingletonLock)
		{
			
		}
		
		override public function initialize(owner:DisplayObjectContainer):void 
		{
			super.initialize(owner);

		}
		override public function enter():void 
		{
			super.enter();
	
		}
		
		override public function update(elapsedTime:int):void 
		{
			super.update(elapsedTime);

		}
		/*
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
		*/
		
		override public function exit():void 
		{
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
			mc.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseClick);
			mc.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);			
			mc.removeEventListener(MouseEvent.ROLL_OVER, onMouseOver);
			mc.removeEventListener(MouseEvent.ROLL_OUT, onMouseLeave);
		}
      
		
		private function onMouseOver(event:MouseEvent):void
		{
			
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
			
			
		}
		
	
		
		/* ============================
		 * 			SINGLETON
		 * ============================
		*/
		
		static public function getInstance(): State_TutorialScreen
		{
			if ( m_instance == null )
			{
				m_instance = new State_TutorialScreen( new SingletonLock() );
			}
			return m_instance;
		}
	}

}
class SingletonLock{}