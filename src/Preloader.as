package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	/**
	 * ...
	 * @author Wiwit
	 */
	public class Preloader extends MovieClip 
	{
		private var Screen_Preloader:mc_ScreenPreloader;
		private var play_tick:int = 0;
		
		public function Preloader() 
		{
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			// show loader
			Screen_Preloader = new mc_ScreenPreloader();
			addChild(Screen_Preloader);
			//Screen_Preloader.Btn_Play.visible = false;
		}
		
		private function progress(e:ProgressEvent):void 
		{
			// update loader
			if (mc_ScreenPreloader != null)
			{
				var percentLoad:Number = e.bytesLoaded / e.bytesTotal * 100;
				Screen_Preloader.percent.text = String(Math.floor(percentLoad)) + " %";
				
				var framePos:int = percentLoad / 100 * Screen_Preloader.loading_Bar.totalFrames;
				TweenMax.killTweensOf( Screen_Preloader.loading_Bar );
				TweenMax.to( Screen_Preloader.loading_Bar, 0.5, { frame:framePos } );
			}
		}
		
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				//removeEventListener(Event.ENTER_FRAME, checkFrame);
				play_tick ++;
				if (play_tick > 20)
				{
					play_tick = 0;
					removeEventListener(Event.ENTER_FRAME, checkFrame);
					startup();
				}
				//startup();
			}
		}
		
		private function startup():void 
		{
			// hide loader
			TweenMax.killAll();
			
			//Screen_Preloader.Btn_Play.removeEventListener(MouseEvent.CLICK, playGame);
			removeChild(Screen_Preloader);
			Screen_Preloader = null;
			
			stop();
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
		private function playGame(e:MouseEvent):void
		{
			startup();
		}
	}
	
}