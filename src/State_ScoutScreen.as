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
	
	
	
	public class State_ScoutScreen extends CGameState
	{
		static private var m_instance:State_ScoutScreen;
		
		private var Screen_Scout:mc_ScoutScreen;
		private var description:enemy_desc;
		private var sign:mc_newEnemy_sign;
		
		private var unit_id:int;
		
		private var level:int = GlobalVars.getLevelGlobal();
		private var wave:Array = new Array();
		private var enemyDesc:Array = new Array();
		private var enemyName:Array = new Array();
		private var enemy_weakCounter:Array = new Array();
		private var game_tips:Array = new Array();
		
		private var m_mouseX:int;
		private var m_mouseY:int;

		private var m_bgm:CSoundObject;
		
		private var m_customCursor:mcCustomCursor;
		
		public function State_ScoutScreen(lock:SingletonLock)
		{
			
		}
		
		override public function initialize(owner:DisplayObjectContainer):void 
		{
			super.initialize(owner);
			
			//adding new object			
			Screen_Scout = new mc_ScoutScreen();
			
			wave = [[0],[1], [1], [1, 3], [1, 3],
					[1, 3, 2], [1, 3, 2], [1, 3, 2, 7], [1, 3, 2, 7],
					[1, 3, 2, 7 ,5], [1, 3, 2, 7 ,5], [1, 3, 2, 7 ,5, 4], [1, 3, 2, 7 ,5, 4, 9],
					[1, 3, 2, 7 ,5 ,4, 9, 11], [1, 3, 2, 7 ,5, 4, 9, 11,8], [1, 3, 2, 7 ,5, 4, 9, 11,8,10], [1, 3, 2, 7 ,5, 4, 9, 11, 8,10,6],
					[1, 3, 2, 7 ,5, 4, 9, 11, 8,10,6,12], [1, 3, 2, 7 ,5, 4, 9, 11, 8,10,6,12], [1, 3, 2, 7 ,5, 4, 9, 11, 8,10,6,12], [1, 3, 2, 7 ,5, 4, 9, 11, 8,10,6, 12 ,13]];
			
			enemyDesc = [0, "Basic melee attacker", "Powerful Melee unit, but he’s darn slow", "Basic ranged attacker, he will attack randomly on the first 2 units on sight.", "Elite ranged attacker, he will attack using 2 projectiles randomly on all placed units on his line.",
						"Basic Cavalry attacker", "Elite Cavalry attacker" , "A unit that can jump and go through 1 unit in front of him." , "Rammer can easily destroy walls or buildings in seconds." ,
						"Throw a infantry unit randomly to the front line." , "Siege unit that will shoot big arrow horizontally, giving damage to the 3 first units in the same line." , "This unit will show and then stop in his place and heal any single unit that hurt (+10% health)" , 
						"Mage unit that throws a fireball" ,
						"-Unidentified unit-"];
			
			enemyName = [0 , "Uztan" , "Razark" , "Croztan" ,
							"Hestaclan" , "Teeclon" , "Udizark" , "Umaz" ,
							"Rammer" , "Caplozton" , "Balistatoz", "Poztazark",	
							"Teegor", "Flagee"];
			
			enemy_weakCounter	= [0 , "Teemy", "Feela" , "Feela" ,
									   "Elonee", "Leegos,Trap", "Ballista" , "Barricade",
									   "Ageesum", "Teemy", "Endrogee", "Feela",
									   "Unknown", "Nobody"];
									   
			game_tips = [["Build a Treasury to help you gain more gold","Teemy can bash enemies on first encounter and throw them backward (this only can be done once)", "Croztan is weak against Feela, so don't forget to recruit them","Remember to always place your troops on all lanes of defense","Your units will level up after several kills"],
						 ["You can cancel your action by pressing 'ESC' key", "Retreat your units to give you back gold , half-price of it", "You can swap your troops on the same lanes","Leegos is strong againts enemy cavalry. Use this advantage to beat them","Seeldy can block enemies to prevent them too close to our palace"],
						 ["God power can only be used once, so pick the right time to use it","Caplozton is dangerous and tricky , be careful against them!","Umaz can't jump over a barricade","Keep the rammers away from your building","Most of enemy infantry will show up on this attack"],
						 ["You can disband your troops and get back your research points","Spear attack is very helpful on this attack","Don't forget to check both your troops and enemy units weakness","Trap instantly kill any enemy units that pass it,but destroyed after 3 attacks","DANGER!!!"]];
									   
			m_customCursor = new mcCustomCursor();
			m_customCursor.mouseEnabled = m_customCursor.mouseChildren = false;			
			//SoundManager.getInstance().addSFX("SN02", new SN02());
			//SoundManager.getInstance().addSFX("SN01", new SN01());		
		}
		override public function enter():void 
		{
			super.enter();
			
			//add to stage
			m_owner.addChild(Screen_Scout);
			
			Screen_Scout.bg_scoutscr.gotoAndStop(GlobalVars.CURRENT_LEVEL + 1);
			Screen_Scout.panel.tips_text.text = game_tips[GlobalVars.CURRENT_LEVEL][GlobalVars.CURRENT_SUB_LEVEL];
			Screen_Scout.panel.scaleX = Screen_Scout.panel.scaleY = 0;
			Screen_Scout.panel.ok_btn.gotoAndStop(1);
			TweenMax.to(Screen_Scout.podium_grass , 0.25, { x:-28, y:418, ease:Quint.easeOut , onComplete:function():void {
				TweenMax.to(Screen_Scout.podium , 0.25, { x:0, y:Screen_Scout.podium.y, ease:Quint.easeOut , onComplete:function():void {
					TweenMax.to(Screen_Scout.panel , 0.25, {scaleX:1, scaleY:1 , ease:Quint.easeOut } );
					}});
			}})
			
			for (var i:int = 1 ; i <= 13 ; i++)
			{
				//unit_id = (i + 1);
				//Screen_Scout["unit_" + i].id = unit_id;
				Screen_Scout.panel["unit_" + i].hitarea.alpha = 0;
				Screen_Scout.panel["unit_" + i].visible = false;
				//Screen_Scout["unit_" + i].gotoAndStop(unit_id);
				//registerButton(Screen_Scout["unit_" + i]);
			}
			
			level = GlobalVars.getLevelGlobal();
			show_wave();
			
			m_bgm = SoundManager.getInstance().playMusic("BM05");
			
			trace("LEVEL:" , level);
			stage.addChild(m_customCursor);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			
			toggleCustomCursor();
			//register button
			registerButton(Screen_Scout.panel.ok_btn);
		}
		
		override public function update(elapsedTime:int):void 
		{
			super.update(elapsedTime);
			stage.setChildIndex(m_customCursor, stage.numChildren - 1);
			
		}
		
		
		override public function exit():void 
		{
			stage.removeChild(m_customCursor);
			m_bgm.stop();
			m_owner.removeChild(Screen_Scout);	
			super.exit();
		}
		
		private function show_wave():void
		{
			var len:int = wave[level].length;
			var prevLen:int = wave[level - 1].length;
		
			for (var i:int = 0; i < len ; i++)
			{
				unit_id = wave[level][i];
				Screen_Scout.panel["unit_" + wave[level][i]].id = unit_id;
				Screen_Scout.panel["unit_" + wave[level][i]].visible = true;
				Screen_Scout.panel["unit_" + wave[level][i]].gotoAndStop(unit_id);
				registerButton(Screen_Scout.panel["unit_" + wave[level][i]]);
			}
			
			if (wave[level][len - 1] != wave[level - 1][prevLen - 1] && level > 1)
			{
				trace("NEW ENEMIES!");
				sign = new mc_newEnemy_sign();
				Screen_Scout.panel.addChild(sign);
				sign.x = Screen_Scout.panel["unit_" + wave[level][(len - 1)]].x;
				sign.y = (Screen_Scout.panel["unit_" + wave[level][(len - 1)]].y - Screen_Scout.panel["unit_" + wave[level][(len - 1)]].width);
				TweenMax.to(sign, 0.5, {glowFilter:{color:0xffcc00, alpha:1, blurX:30, blurY:30,quality:2}});
				TweenMax.to(Screen_Scout.panel["unit_" + wave[level][(len - 1)]], 0.5, { glowFilter: { color:0xffcc00, alpha:1, blurX:30, blurY:30, strength:1.5, quality:2 }} );
			}
			/*else
			{
				if (sign != null)
				{
					trace("DELETE");
					TweenMax.to(sign, 0.5, {glowFilter:{color:0xffcc00, alpha:0, blurX:30, blurY:30,quality:2}});
					Screen_Scout.panel.removeChild(sign);
					sign = null;
					TweenMax.to(Screen_Scout.panel["unit_" + wave[level][(len - 1)]], 0.5, { glowFilter: { color:0xffcc00, alpha:0, blurX:30, blurY:30, strength:1.5, quality:2 }} );
				}
			}*/
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
			
			switch(mc)
			{
				case Screen_Scout.panel.ok_btn:
				mc.gotoAndStop(2);
				break;
			}
			
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
			mc.mouseChildren = false;
			SoundManager.getInstance().playSFX("SN02");
			
			switch (mc)
			{
				case Screen_Scout.panel.ok_btn:
				TweenMax.to(mc, 0.15, {glowFilter:{color:0x996600, alpha:1, blurX:10, blurY:10,strength:1.5, quality:3}});
				break;
				default:
				description = new enemy_desc();
				Screen_Scout.panel.addChild(description);
				description.mouseChildren = false;
				description.mouseEnabled = false;
				description.x = mc.x;
				description.y = mc.y;
				description.desc_txt.text = enemyDesc[mc.id];
				description.name_txt.text = enemyName[mc.id];
				description.counter_txt.text = enemy_weakCounter[mc.id];
				break;
			}
			
		
			/*var mc:MovieClip = MovieClip(event.currentTarget);
			
			mc.gotoAndStop(2);
			
			m_sfx = SoundManager.getInstance().playSFX("SFX_BtnRollover");*/
			//trace("rollover");
			
		}
               
		private function onMouseLeave(event:MouseEvent):void
		{
			if (description != null)
			{
				Screen_Scout.panel.removeChild(description);
				description = null;
			}
			//trace("rollout");

			var mc:MovieClip = MovieClip(event.currentTarget);
			
			switch(mc)
			{
				case Screen_Scout.panel.ok_btn:
				TweenMax.to(mc, 0.15, {glowFilter:{color:0x996600, alpha:0, blurX:10, blurY:10,strength:2, quality:3}});
				break;
			}
			
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			var mc:MovieClip = MovieClip(event.currentTarget);
			var len:int = wave[level].length;
			var prevLen:int = wave[level - 1].length;
			
			switch(mc)
			{
				case Screen_Scout.panel.ok_btn:
				if (sign != null)
				{
					trace("DELETE");
					TweenMax.to(sign, 0.5, {glowFilter:{color:0xffcc00, alpha:0, blurX:30, blurY:30,quality:2}});
					Screen_Scout.panel.removeChild(sign);
					sign = null;
					TweenMax.to(Screen_Scout.panel["unit_" + wave[level][(len - 1)]], 0.5, { glowFilter: { color:0xffcc00, alpha:0, blurX:30, blurY:30, strength:1.5, quality:2 }} );
				}
				mc.gotoAndStop(1);
				TweenMax.to(Screen_Scout.panel , 0.25, { scaleX:0, scaleY:0 , ease:Quint.easeOut, onComplete:function():void {
				TweenMax.to(Screen_Scout.podium , 0.25, { x:-300, y:0, ease:Quint.easeOut , onComplete:function():void {
					TweenMax.to(Screen_Scout.podium_grass , 0.5, { x:-28, y:500, ease:Quint.easeOut , onComplete:function():void {
						GameStateManager.getInstance().setState(State_BarrackScreen.getInstance());
						}} );
					}});
				}})
				break;
			}
		}
		private function _checkMouseEventTrail($e:MouseEvent):void
		{
			trace("==================");
			var p:* = $e.target;
			while(p)
			{
				trace(">>", p.name,": ",p);
				p = p.parent;
			}
		};
		
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
		
		static public function getInstance(): State_ScoutScreen
		{
			if ( m_instance == null )
			{
				m_instance = new State_ScoutScreen( new SingletonLock() );
			}
			return m_instance;
		}
	}

}
class SingletonLock{}