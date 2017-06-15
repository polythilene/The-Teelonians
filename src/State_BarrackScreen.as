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
	
	
	
	public class State_BarrackScreen extends CGameState
	{
		static private var m_instance:State_BarrackScreen;
		
		private var Screen_Barrack:mc_ScreenBarrack;
		private var preview:Unit_Preview;
		private var preview_desc:Unit_Desc;
		private var warning_text:Notification;
		
		private var unit_id:int;
		private var unlock_point:int;
		private var cost_unit:int;
		private var selected_unit:int;
		private var ticker:int = 0;
		
		private static const LEEGOS_RESPOINT_UNLOCK:int		= 3;
		private static const SEELDY_RESPOINT_UNLOCK:int 	= 3;
		private static const AGEESUM_RESPOINT_UNLOCK:int 	= 5;
		private static const FEELA_RESPOINT_UNLOCK:int 		= 2;
		private static const ELONEE_RESPOINT_UNLOCK:int 	= 6;
		private static const ENDROGEE_RESPOINT_UNLOCK:int 	= 3;
		private static const UGEE_RESPOINT_UNLOCK:int 		= 2;
		private static const BARRICADE_RESPOINT_UNLOCK:int 	= 4;
		//private static const TREASURY_RESPOINT_UNLOCK:int 	= 1;
		private static const TRAP_RESPOINT_UNLOCK:int 		= 2;
		private static const BALLISTA_RESPOINT_UNLOCK:int 	= 8;
		
		private static const LEEGOS_COST:int	= 220;
		private static const SEELDY_COST:int	= 200;
		private static const AGEESUM_COST:int	= 600;
		private static const FEELA_COST:int		= 180;
		private static const ELONEE_COST:int	= 500;
		private static const ENDROGEE_COST:int	= 350;
		private static const UGEE_COST:int		= 300;
		private static const BARRICADE_COST:int	= 750;
		private static const TREASURY_COST:int	= 150;
		private static const TRAP_COST:int		= 250;
		private static const BALLISTA_COST:int	= 2000;
		
		private var unit_power_desc:Array = new Array();
		private var unit_special_desc:Array = new Array();
		private var unit_story:Array = new Array();
		private var unit_names:Array = new Array();
		private var unit_weakness:Array = new Array();
		private var unit_class:Array = new Array();
		
		private var m_mouseX:int;
		private var m_mouseY:int;
		
		private var m_bgm:CSoundObject;
		
		private var m_customCursor:mcCustomCursor;
		
		public function State_BarrackScreen(lock:SingletonLock)
		{
			
		}
		
		override public function initialize(owner:DisplayObjectContainer):void 
		{
			super.initialize(owner);
			
			//create new object
			Screen_Barrack 	= new mc_ScreenBarrack();
			preview 	 	= new Unit_Preview();
			preview_desc 	= new Unit_Desc();
			
			//unit names
			unit_names = [0 , "Market"  , "Teemy", "Leegos" , "Seeldy" ,
							"Ageesum", "Feela" , "Elonee" , "Endrogee" , 
							"Ugee" , "Barricade" , "Trap", 
							"Ballista"]
			
			//unit story
			unit_story = [0, "Will produce 25 gold every 5 seconds.", 
							 "Teemy can bash enemies. Teemy said: “Teey will see my true power without clothes”",
							 "Leegos likes to extract milk from the horses and drink it, he smells like stinky horses." , 
							 "Armed with a huge shield, acted as blocker and he will push the enemy back to their starting point. Seeldy only knows one thing, PUSH!!" ,
							 "He will summon a monster that will keep on moving until the edge of his own line and kill enemies on sight. The old Ageesum will never chase anyone other than young girl with his ugly summoned monster." , "Feela likes to hunt little birds on his neighbour’s garden in his spare time",
							 "Elonee emits fire projectiles in parabolic course and will cause area damage on impact. Eloone is the the BBQ master on the Kingdom’s Kitchen and Teey will know how when Teey meet her." ,
							 "Endrogee emits ice projectiles in parabolic course and will cause slow movement (-75% speed) on impact. No need of formalin anymore, Endrogee will gladly freeze your fresh tomatoes for free.",
							 "Healer, that will heal units on the same line (+4 Heal). Ugee is the royal shaman, and also the expert on the disfunction of male’s reproduction (especially for the king’s “thing”).",
							 "Built to block the enemy attack and thwart the jumper unit.",
							 "This unit needs to be placed on ground and when the enemies walk through it will cause 8 damages every 2 seconds. Destroyed after 5 attacks.",
							 "This Unit hits horizontally and the damage affects all the enemies on the same line."];
			
			//unit power description
			unit_power_desc = [0, "-" ,"Medium" , "Medium" , "Very Strong" , "Weak",
								  "Weak" , "Weak" , "Weak" , "Weak" ,
								  "-" , "-" ,  "-"];
			
			//unit special description
			unit_special_desc = [0 ,"-", "Infantry Destroyer", "Cavalry Destroyer " , "Push Away enemies" , 
									"Summon monster", "Ranged attack" , "Fire-balls", "Ice-balls",
									"Healing", "-" , "-",  "-"];
			
			//unit weakness description
			unit_weakness = [0, "Rammer" , "Croztan" , "Udizark", "Teeclon",
									"Hestaclan,Caplozton" , "Teeclon" , "Hestaclan,Caplozton",
									"Hestaclan,Caplozton", "Hestaclan,Caplozton", "Rammer", "Rammer",
									"Rammer","Rammer"];						
			
			//unit class description
			unit_class = [0, "Siege" , "Infantry" , "Infantry" , "Infantry",
							"Mage", "Archer", "Mage", "Mage", "Mage",
							"Siege","Siege","Siege"]
									
			m_customCursor = new mcCustomCursor();
			m_customCursor.mouseEnabled = m_customCursor.mouseChildren = false;							
			//SoundManager.getInstance().addSFX("SN02", new SN02());
			//SoundManager.getInstance().addSFX("SN01", new SN01());
		}
		override public function enter():void 
		{
			super.enter();
			
			m_owner.addChild(Screen_Barrack);
			
			GlobalVars.LAST_STATE_LEEGOS = GlobalVars.UNLOCKED_LEEGOS;
			GlobalVars.LAST_STATE_SEELDY = GlobalVars.UNLOCKED_SEELDY
			GlobalVars.LAST_STATE_AGEESUM = GlobalVars.UNLOCKED_AGEESUM
			GlobalVars.LAST_STATE_FEELA = GlobalVars.UNLOCKED_FEELA
			GlobalVars.LAST_STATE_ELONEE = GlobalVars.UNLOCKED_ELONEE
			GlobalVars.LAST_STATE_ENDROGEE = GlobalVars.UNLOCKED_ENDROGEE
			GlobalVars.LAST_STATE_UGEE = GlobalVars.UNLOCKED_UGEE
			GlobalVars.LAST_STATE_BARRICADE = GlobalVars.UNLOCKED_BARRICADE
			GlobalVars.LAST_STATE_TREASURY = GlobalVars.UNLOCKED_TREASURY
			GlobalVars.LAST_STATE_TRAP = GlobalVars.UNLOCKED_TRAP
			GlobalVars.LAST_STATE_BALLISTA = GlobalVars.UNLOCKED_BALLISTA
			
			GlobalVars.LAST_RESEARCH_POINT = GlobalVars.RESEARCH_POINT;
			
			
			//register unit button
			for (var i:int = 0; i < 12 ; i++)
			{
				unit_id = (i + 1);
				Screen_Barrack["unit_" + i].id = unit_id;
				Screen_Barrack["unit_" + i].gotoAndStop(unit_id);
				registerButton(Screen_Barrack["unit_" + i]);
			}
			
			Screen_Barrack.disband_btn.visible = false;
			
			registerButton(Screen_Barrack.goWar_btn);
			registerButton(Screen_Barrack.recruit_btn);
			
			TweenMax.to(Screen_Barrack.goWar_btn, 0.5, {x:24, y:-70, ease:Back.easeInOut});
			
			m_bgm = SoundManager.getInstance().playMusic("BM05");
			
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
		
		private function update_icon():void
		{
			for (var j:int = 0; j < 12 ; j++)
			{
				unit_id = (j + 1);
				Screen_Barrack["unit_" + j].id = unit_id;
				//Screen_Barrack["unit_" + j].gotoAndStop(unit_id);
				switch(unit_id)
				{
					/*case 1:
					if (!GlobalVars.UNLOCKED_TREASURY)
					{
						Screen_Barrack["unit_" + j].icon.gotoAndStop(2);
						TweenMax.to(Screen_Barrack["unit_" + j], 0.25, {colorMatrixFilter:{colorize:0x000000, amount:0.7}});
					}
					else
					{
						Screen_Barrack["unit_" + j].icon.gotoAndStop(1);
						TweenMax.to(Screen_Barrack["unit_" + j], 0.25, {colorMatrixFilter:{colorize:0x000000, amount:0}});							
					}
					break;*/
					case 3:
					if (!GlobalVars.UNLOCKED_LEEGOS)
					{
						Screen_Barrack["unit_" + j].icon.gotoAndStop(2);
						TweenMax.to(Screen_Barrack["unit_" + j], 0.25, {colorMatrixFilter:{colorize:0x000000, amount:0.7}});
					}
					else
					{
						Screen_Barrack["unit_" + j].icon.gotoAndStop(1);
						TweenMax.to(Screen_Barrack["unit_" + j], 0.25, {colorMatrixFilter:{colorize:0x000000, amount:0}});							
					}
					break;
					case 4:
					if (!GlobalVars.UNLOCKED_SEELDY)
					{
						Screen_Barrack["unit_" + j].icon.gotoAndStop(2);
						TweenMax.to(Screen_Barrack["unit_" + j], 0.25, {colorMatrixFilter:{colorize:0x000000, amount:0.7}});
					}
					else
					{
						Screen_Barrack["unit_" + j].icon.gotoAndStop(1);
						TweenMax.to(Screen_Barrack["unit_" + j], 0.25, {colorMatrixFilter:{colorize:0x000000, amount:0}});							
					}
					break;
					case 5:
					if (!GlobalVars.UNLOCKED_AGEESUM)
					{
						Screen_Barrack["unit_" + j].icon.gotoAndStop(2);
						TweenMax.to(Screen_Barrack["unit_" + j], 0.25, {colorMatrixFilter:{colorize:0x000000, amount:0.7}});
					}
					else
					{
						Screen_Barrack["unit_" + j].icon.gotoAndStop(1);
						TweenMax.to(Screen_Barrack["unit_" + j], 0.25, {colorMatrixFilter:{colorize:0x000000, amount:0}});							
					}
					break;
					case 6:
					if (!GlobalVars.UNLOCKED_FEELA)
					{
						Screen_Barrack["unit_" + j].icon.gotoAndStop(2);
						TweenMax.to(Screen_Barrack["unit_" + j], 0.25, {colorMatrixFilter:{colorize:0x000000, amount:0.7}});
					}
					else
					{
						Screen_Barrack["unit_" + j].icon.gotoAndStop(1);
						TweenMax.to(Screen_Barrack["unit_" + j], 0.25, {colorMatrixFilter:{colorize:0x000000, amount:0}});							
					}
					break;
					case 7:
					if (!GlobalVars.UNLOCKED_ELONEE)
					{
						Screen_Barrack["unit_" + j].icon.gotoAndStop(2);
						TweenMax.to(Screen_Barrack["unit_" + j], 0.25, {colorMatrixFilter:{colorize:0x000000, amount:0.7}});
					}
					else
					{
						Screen_Barrack["unit_" + j].icon.gotoAndStop(1);
						TweenMax.to(Screen_Barrack["unit_" + j], 0.25, {colorMatrixFilter:{colorize:0x000000, amount:0}});							
					}
					break;
					case 8:
					if (!GlobalVars.UNLOCKED_ENDROGEE)
					{
						Screen_Barrack["unit_" + j].icon.gotoAndStop(2);
						TweenMax.to(Screen_Barrack["unit_" + j], 0.25, {colorMatrixFilter:{colorize:0x000000, amount:0.7}});
					}
					else
					{
						Screen_Barrack["unit_" + j].icon.gotoAndStop(1);
						TweenMax.to(Screen_Barrack["unit_" + j], 0.25, {colorMatrixFilter:{colorize:0x000000, amount:0}});							
					}
					break;
					case 9:
					if (!GlobalVars.UNLOCKED_UGEE)
					{
						Screen_Barrack["unit_" + j].icon.gotoAndStop(2);
						TweenMax.to(Screen_Barrack["unit_" + j], 0.25, {colorMatrixFilter:{colorize:0x000000, amount:0.7}});
					}
					else
					{
						Screen_Barrack["unit_" + j].icon.gotoAndStop(1);
						TweenMax.to(Screen_Barrack["unit_" + j], 0.25, {colorMatrixFilter:{colorize:0x000000, amount:0}});							
					}
					break;
					case 10:
					if (!GlobalVars.UNLOCKED_BARRICADE)
					{
						Screen_Barrack["unit_" + j].icon.gotoAndStop(2);
						TweenMax.to(Screen_Barrack["unit_" + j], 0.25, {colorMatrixFilter:{colorize:0x000000, amount:0.7}});
					}
					else
					{
						Screen_Barrack["unit_" + j].icon.gotoAndStop(1);
						TweenMax.to(Screen_Barrack["unit_" + j], 0.25, {colorMatrixFilter:{colorize:0x000000, amount:0}});							
					}
					break;
					case 11:
					if (!GlobalVars.UNLOCKED_TRAP)
					{
						Screen_Barrack["unit_" + j].icon.gotoAndStop(2);
						TweenMax.to(Screen_Barrack["unit_" + j], 0.25, {colorMatrixFilter:{colorize:0x000000, amount:0.7}});
					}
					else
					{
						Screen_Barrack["unit_" + j].icon.gotoAndStop(1);
						TweenMax.to(Screen_Barrack["unit_" + j], 0.25, {colorMatrixFilter:{colorize:0x000000, amount:0}});							
					}
					break;
					case 12:
					if (!GlobalVars.UNLOCKED_BALLISTA)
					{
						Screen_Barrack["unit_" + j].icon.gotoAndStop(2);
						TweenMax.to(Screen_Barrack["unit_" + j], 0.25, {colorMatrixFilter:{colorize:0x000000, amount:0.7}});
					}
					else
					{
						Screen_Barrack["unit_" + j].icon.gotoAndStop(1);
						TweenMax.to(Screen_Barrack["unit_" + j], 0.25, {colorMatrixFilter:{colorize:0x000000, amount:0}});							
					}
					break;
				}
			}
		}
		override public function update(elapsedTime:int):void 
		{
			super.update(elapsedTime);
			stage.setChildIndex(m_customCursor, stage.numChildren - 1);
			//preview unit
			if (Screen_Barrack.idle)
			{
				Screen_Barrack.idle = false;
				Screen_Barrack.preview.preview_mc.gotoAndStop(2);
			}
			if (Screen_Barrack.changePreview)
			{
				trace(Screen_Barrack.currentFrame);
				if (Screen_Barrack.currentFrame >= 20)
				{
					Screen_Barrack.play();
					Screen_Barrack.preview.preview_mc.gotoAndStop(1);
				}
				else
				{
					Screen_Barrack.changePreview = false;
					Screen_Barrack.preview.preview_mc.gotoAndStop(1);
					Screen_Barrack.preview.gotoAndStop(selected_unit);
					Screen_Barrack.gotoAndPlay(2);
				}
			}
			//show research point
			Screen_Barrack.point_txt.text = String(GlobalVars.RESEARCH_POINT);
			
			//show gold
			Screen_Barrack.coin_txt.text = String(GlobalVars.TOTAL_COIN);
			
			//notification text ticker
			if (warning_text != null)
			{
				ticker += elapsedTime;
				if (ticker > 1000)
				{
					TweenMax.to(warning_text, 0.1, { scaleX:0, scaleY:0, onComplete:function():void {
						m_owner.removeChild(warning_text);
						warning_text = null;
						ticker = 0;
						TweenMax.killAll();
						}});
				}
			}
			
			//update unit icon
			update_icon();
			
		}
		
		
		override public function exit():void 
		{
			stage.removeChild(m_customCursor);
			m_bgm.stop();
			m_owner.removeChild(Screen_Barrack);
			super.exit();
		}
		
		private function Recruit(selected:int):void
		{
				/*case 1:
				if (!GlobalVars.UNLOCKED_TREASURY)
				{
					if (GlobalVars.RESEARCH_POINT >= unlock_point)
					{
						GlobalVars.RESEARCH_POINT -= unlock_point;
						GlobalVars.UNLOCKED_TREASURY = true;
					}
					else
					{
						if (warning_text == null)
						{
							warning_text = new Notification();
							m_owner.addChild(warning_text);
							warning_text.notification.text = "not enough points to unlock!";
							warning_text.scaleX = warning_text.scaleY = 0;
							warning_text.x = 400;
							warning_text.y = 250;
							TweenMax.to(warning_text, 0.25, {scaleX:1, scaleY:1});
							//trace("insufficient point");
						}
					}
				}
				else
				{
					if (warning_text == null)
					{
						warning_text = new Notification();
						m_owner.addChild(warning_text);
						warning_text.notification.text = "you're already have this unit!";
						warning_text.scaleX = warning_text.scaleY = 0;
						warning_text.x = 400;
						warning_text.y = 250;
						TweenMax.to(warning_text, 0.25, {scaleX:1, scaleY:1});
						//trace("insufficient point");
					}
				}
				break;*/
			switch(selected)
			{
				
				case 3:
				if (!GlobalVars.UNLOCKED_LEEGOS)
				{
					if (GlobalVars.RESEARCH_POINT >= unlock_point)
					{
						GlobalVars.RESEARCH_POINT -= unlock_point;
						GlobalVars.UNLOCKED_LEEGOS = true;
						
						Screen_Barrack.recruit_btn.visible = false;
						Screen_Barrack.disband_btn.visible = true;
						registerButton(Screen_Barrack.disband_btn);
						
					}
					else
					{
						if (warning_text == null)
						{
							warning_text = new Notification();
							m_owner.addChild(warning_text);
							warning_text.notification.text = "not enough points to unlock!";
							warning_text.scaleX = warning_text.scaleY = 0;
							warning_text.x = 400;
							warning_text.y = 250;
							TweenMax.to(warning_text, 0.25, {scaleX:1, scaleY:1});
							//trace("insufficient point");
						}
					}
				}
				else
				{
					GlobalVars.RESEARCH_POINT += unlock_point;
					GlobalVars.UNLOCKED_LEEGOS = false;
					Screen_Barrack.recruit_btn.visible = true;
					Screen_Barrack.disband_btn.visible = false;
					unregisterButton(Screen_Barrack.disband_btn);
					//registerButton(Screen_Barrack.disband_btn);
					/*if (warning_text == null)
					{
						warning_text = new Notification();
						m_owner.addChild(warning_text);
						warning_text.notification.text = "you're already have this unit!";
						warning_text.scaleX = warning_text.scaleY = 0;
						warning_text.x = 400;
						warning_text.y = 250;
						TweenMax.to(warning_text, 0.25, {scaleX:1, scaleY:1});
						//trace("insufficient point");
					}*/
				}
				break;
				case 4:
				if (!GlobalVars.UNLOCKED_SEELDY)
				{
					if (GlobalVars.RESEARCH_POINT >= unlock_point)
					{
						GlobalVars.RESEARCH_POINT -= unlock_point;
						GlobalVars.UNLOCKED_SEELDY = true;
						
						Screen_Barrack.recruit_btn.visible = false;
						Screen_Barrack.disband_btn.visible = true;
						registerButton(Screen_Barrack.disband_btn);
					}
					else
					{
						if (warning_text == null)
						{
							warning_text = new Notification();
							m_owner.addChild(warning_text);
							warning_text.notification.text = "not enough points to unlock!";
							warning_text.scaleX = warning_text.scaleY = 0;
							warning_text.x = 400;
							warning_text.y = 250;
							TweenMax.to(warning_text, 0.25, {scaleX:1, scaleY:1});
							//trace("insufficient point");
						}
					}
				}
				else
				{
					GlobalVars.RESEARCH_POINT += unlock_point;
					GlobalVars.UNLOCKED_SEELDY = false;
					Screen_Barrack.recruit_btn.visible = true;
					Screen_Barrack.disband_btn.visible = false;
					unregisterButton(Screen_Barrack.disband_btn);
					/*if (warning_text == null)
					{
						warning_text = new Notification();
						m_owner.addChild(warning_text);
						warning_text.notification.text = "you're already have this unit!";
						warning_text.scaleX = warning_text.scaleY = 0;
						warning_text.x = 400;
						warning_text.y = 250;
						TweenMax.to(warning_text, 0.25, {scaleX:1, scaleY:1});
						//trace("insufficient point");
					}*/
				}
				break;
				case 5:
				if (!GlobalVars.UNLOCKED_AGEESUM)
				{
					if (GlobalVars.RESEARCH_POINT >= unlock_point)
					{
						GlobalVars.RESEARCH_POINT -= unlock_point;
						GlobalVars.UNLOCKED_AGEESUM = true;
						
						Screen_Barrack.recruit_btn.visible = false;
						Screen_Barrack.disband_btn.visible = true;
						registerButton(Screen_Barrack.disband_btn);
					}
					else
					{
						if (warning_text == null)
						{
							warning_text = new Notification();
							m_owner.addChild(warning_text);
							warning_text.notification.text = "not enough points to unlock!";
							warning_text.scaleX = warning_text.scaleY = 0;
							warning_text.x = 400;
							warning_text.y = 250;
							TweenMax.to(warning_text, 0.25, {scaleX:1, scaleY:1});
							//trace("insufficient point");
						}
					}
				}
				else
				{
					GlobalVars.RESEARCH_POINT += unlock_point;
					GlobalVars.UNLOCKED_AGEESUM = false;
					Screen_Barrack.recruit_btn.visible = true;
					Screen_Barrack.disband_btn.visible = false;
					unregisterButton(Screen_Barrack.disband_btn);
					/*if (warning_text == null)
					{
						warning_text = new Notification();
						m_owner.addChild(warning_text);
						warning_text.notification.text = "you're already have this unit!";
						warning_text.scaleX = warning_text.scaleY = 0;
						warning_text.x = 400;
						warning_text.y = 250;
						TweenMax.to(warning_text, 0.25, {scaleX:1, scaleY:1});
						//trace("insufficient point");
					}*/
				}
				break;
				case 6:
				if (!GlobalVars.UNLOCKED_FEELA)
				{
					if (GlobalVars.RESEARCH_POINT >= unlock_point)
					{
						GlobalVars.RESEARCH_POINT -= unlock_point;
						GlobalVars.UNLOCKED_FEELA = true;
						
						Screen_Barrack.recruit_btn.visible = false;
						Screen_Barrack.disband_btn.visible = true;
						registerButton(Screen_Barrack.disband_btn);
					}
					else
					{
						if (warning_text == null)
						{
							warning_text = new Notification();
							m_owner.addChild(warning_text);
							warning_text.notification.text = "not enough points to unlock!";
							warning_text.scaleX = warning_text.scaleY = 0;
							warning_text.x = 400;
							warning_text.y = 250;
							TweenMax.to(warning_text, 0.25, {scaleX:1, scaleY:1});
							//trace("insufficient point");
						}
					}
				}
				else
				{
					GlobalVars.RESEARCH_POINT += unlock_point;
					GlobalVars.UNLOCKED_FEELA = false;
					Screen_Barrack.recruit_btn.visible = true;
					Screen_Barrack.disband_btn.visible = false;
					unregisterButton(Screen_Barrack.disband_btn);
					/*if (warning_text == null)
					{
						warning_text = new Notification();
						m_owner.addChild(warning_text);
						warning_text.notification.text = "you're already have this unit!";
						warning_text.scaleX = warning_text.scaleY = 0;
						warning_text.x = 400;
						warning_text.y = 250;
						TweenMax.to(warning_text, 0.25, {scaleX:1, scaleY:1});
						//trace("insufficient point");
					}*/
				}
				break;
				case 7:				
				if (!GlobalVars.UNLOCKED_ELONEE)
				{
					if (GlobalVars.RESEARCH_POINT >= unlock_point)
					{
						GlobalVars.RESEARCH_POINT -= unlock_point;
						GlobalVars.UNLOCKED_ELONEE = true;
						
						Screen_Barrack.recruit_btn.visible = false;
						Screen_Barrack.disband_btn.visible = true;
						registerButton(Screen_Barrack.disband_btn);
					}
					else
					{
						if (warning_text == null)
						{
							warning_text = new Notification();
							m_owner.addChild(warning_text);
							warning_text.notification.text = "not enough points to unlock!";
							warning_text.scaleX = warning_text.scaleY = 0;
							warning_text.x = 400;
							warning_text.y = 250;
							TweenMax.to(warning_text, 0.25, {scaleX:1, scaleY:1});
							//trace("insufficient point");
						}
					}
				}
				else
				{
					GlobalVars.RESEARCH_POINT += unlock_point;
					GlobalVars.UNLOCKED_ELONEE = false;
					Screen_Barrack.recruit_btn.visible = true;
					Screen_Barrack.disband_btn.visible = false;
					unregisterButton(Screen_Barrack.disband_btn);
					/*if (warning_text == null)
					{
						warning_text = new Notification();
						m_owner.addChild(warning_text);
						warning_text.notification.text = "you're already have this unit!";
						warning_text.scaleX = warning_text.scaleY = 0;
						warning_text.x = 400;
						warning_text.y = 250;
						TweenMax.to(warning_text, 0.25, {scaleX:1, scaleY:1});
						//trace("insufficient point");
					}*/
				}
				break;
				case 8:
				if (!GlobalVars.UNLOCKED_ENDROGEE)
				{
					if (GlobalVars.RESEARCH_POINT >= unlock_point)
					{
						GlobalVars.RESEARCH_POINT -= unlock_point;
						GlobalVars.UNLOCKED_ENDROGEE = true;
						
						Screen_Barrack.recruit_btn.visible = false;
						Screen_Barrack.disband_btn.visible = true;
						registerButton(Screen_Barrack.disband_btn);
					}
					else
					{
						if (warning_text == null)
						{
							warning_text = new Notification();
							m_owner.addChild(warning_text);
							warning_text.notification.text = "not enough points to unlock!";
							warning_text.scaleX = warning_text.scaleY = 0;
							warning_text.x = 400;
							warning_text.y = 250;
							TweenMax.to(warning_text, 0.25, {scaleX:1, scaleY:1});
							//trace("insufficient point");
						}
					}
				}
				else
				{
					GlobalVars.RESEARCH_POINT += unlock_point;
					GlobalVars.UNLOCKED_ENDROGEE = false;
					Screen_Barrack.recruit_btn.visible = true;
					Screen_Barrack.disband_btn.visible = false;
					unregisterButton(Screen_Barrack.disband_btn);
					/*if (warning_text == null)
					{
						warning_text = new Notification();
						m_owner.addChild(warning_text);
						warning_text.notification.text = "you're already have this unit!";
						warning_text.scaleX = warning_text.scaleY = 0;
						warning_text.x = 400;
						warning_text.y = 250;
						TweenMax.to(warning_text, 0.25, {scaleX:1, scaleY:1});
						//trace("insufficient point");
					}*/
				}
				break;
				case 9:
				if (!GlobalVars.UNLOCKED_UGEE)
				{
					if (GlobalVars.RESEARCH_POINT >= unlock_point)
					{
						GlobalVars.RESEARCH_POINT -= unlock_point;
						GlobalVars.UNLOCKED_UGEE = true;
						
						Screen_Barrack.recruit_btn.visible = false;
						Screen_Barrack.disband_btn.visible = true;
						registerButton(Screen_Barrack.disband_btn);
					}
					else
					{
						if (warning_text == null)
						{
							warning_text = new Notification();
							m_owner.addChild(warning_text);
							warning_text.notification.text = "not enough points to unlock!";
							warning_text.scaleX = warning_text.scaleY = 0;
							warning_text.x = 400;
							warning_text.y = 250;
							TweenMax.to(warning_text, 0.25, {scaleX:1, scaleY:1});
							//trace("insufficient point");
						}
					}
				}
				else
				{
					GlobalVars.RESEARCH_POINT += unlock_point;
					GlobalVars.UNLOCKED_UGEE = false;
					Screen_Barrack.recruit_btn.visible = true;
					Screen_Barrack.disband_btn.visible = false;
					unregisterButton(Screen_Barrack.disband_btn);
					/*if (warning_text == null)
					{
						warning_text = new Notification();
						m_owner.addChild(warning_text);
						warning_text.notification.text = "you're already have this unit!";
						warning_text.scaleX = warning_text.scaleY = 0;
						warning_text.x = 400;
						warning_text.y = 250;
						TweenMax.to(warning_text, 0.25, {scaleX:1, scaleY:1});
						//trace("insufficient point");
					}*/
				}
				break;
				case 10:
				if (!GlobalVars.UNLOCKED_BARRICADE)
				{
					if (GlobalVars.RESEARCH_POINT >= unlock_point)
					{
						GlobalVars.RESEARCH_POINT -= unlock_point;
						GlobalVars.UNLOCKED_BARRICADE = true;
						
						Screen_Barrack.recruit_btn.visible = false;
						Screen_Barrack.disband_btn.visible = true;
						registerButton(Screen_Barrack.disband_btn);
					}
					else
					{
						if (warning_text == null)
						{
							warning_text = new Notification();
							m_owner.addChild(warning_text);
							warning_text.notification.text = "not enough points to unlock!";
							warning_text.scaleX = warning_text.scaleY = 0;
							warning_text.x = 400;
							warning_text.y = 250;
							TweenMax.to(warning_text, 0.25, {scaleX:1, scaleY:1});
							//trace("insufficient point");
						}
					}
				}
				else
				{
					GlobalVars.RESEARCH_POINT += unlock_point;
					GlobalVars.UNLOCKED_BARRICADE = false;
					Screen_Barrack.recruit_btn.visible = true;
					Screen_Barrack.disband_btn.visible = false;
					unregisterButton(Screen_Barrack.disband_btn);
					/*if (warning_text == null)
					{
						warning_text = new Notification();
						m_owner.addChild(warning_text);
						warning_text.notification.text = "you're already have this unit!";
						warning_text.scaleX = warning_text.scaleY = 0;
						warning_text.x = 400;
						warning_text.y = 250;
						TweenMax.to(warning_text, 0.25, {scaleX:1, scaleY:1});
						//trace("insufficient point");
					}*/
				}
				break;
				case 11:
				if (!GlobalVars.UNLOCKED_TRAP)
				{
					if (GlobalVars.RESEARCH_POINT >= unlock_point)
					{
						GlobalVars.RESEARCH_POINT -= unlock_point;
						GlobalVars.UNLOCKED_TRAP = true;
						
						Screen_Barrack.recruit_btn.visible = false;
						Screen_Barrack.disband_btn.visible = true;
						registerButton(Screen_Barrack.disband_btn);
					}
					else
					{
						if (warning_text == null)
						{
							warning_text = new Notification();
							m_owner.addChild(warning_text);
							warning_text.notification.text = "not enough points to unlock!";
							warning_text.scaleX = warning_text.scaleY = 0;
							warning_text.x = 400;
							warning_text.y = 250;
							TweenMax.to(warning_text, 0.25, {scaleX:1, scaleY:1});
							//trace("insufficient point");
						}
					}
				}
				else
				{
					GlobalVars.RESEARCH_POINT += unlock_point;
					GlobalVars.UNLOCKED_TRAP = false;
					Screen_Barrack.recruit_btn.visible = true;
					Screen_Barrack.disband_btn.visible = false;
					unregisterButton(Screen_Barrack.disband_btn);
					/*if (warning_text == null)
					{
						warning_text = new Notification();
						m_owner.addChild(warning_text);
						warning_text.notification.text = "you're already have this unit!";
						warning_text.scaleX = warning_text.scaleY = 0;
						warning_text.x = 400;
						warning_text.y = 250;
						TweenMax.to(warning_text, 0.25, {scaleX:1, scaleY:1});
						//trace("insufficient point");
					}*/
				}
				break;
				case 12:
				if (!GlobalVars.UNLOCKED_BALLISTA)
				{
					if (GlobalVars.RESEARCH_POINT >= unlock_point)
					{
						GlobalVars.RESEARCH_POINT -= unlock_point;
						GlobalVars.UNLOCKED_BALLISTA = true;
						
						Screen_Barrack.recruit_btn.visible = false;
						Screen_Barrack.disband_btn.visible = true;
						registerButton(Screen_Barrack.disband_btn);
					}
					else
					{
						if (warning_text == null)
						{
							warning_text = new Notification();
							m_owner.addChild(warning_text);
							warning_text.notification.text = "not enough points to unlock!";
							warning_text.scaleX = warning_text.scaleY = 0;
							warning_text.x = 400;
							warning_text.y = 250;
							TweenMax.to(warning_text, 0.25, {scaleX:1, scaleY:1});
							//trace("insufficient point");
						}
					}
				}
				else
				{
					GlobalVars.RESEARCH_POINT += unlock_point;
					GlobalVars.UNLOCKED_BALLISTA = false;
					Screen_Barrack.recruit_btn.visible = true;
					Screen_Barrack.disband_btn.visible = false;
					unregisterButton(Screen_Barrack.disband_btn);
					/*if (warning_text == null)
					{
						warning_text = new Notification();
						m_owner.addChild(warning_text);
						warning_text.notification.text = "you're already have this unit!";
						warning_text.scaleX = warning_text.scaleY = 0;
						warning_text.x = 400;
						warning_text.y = 250;
						TweenMax.to(warning_text, 0.25, {scaleX:1, scaleY:1});
						//trace("insufficient point");
					}*/
				}
				break;
				default:
					if (warning_text == null)
					{
						warning_text = new Notification();
						m_owner.addChild(warning_text);
						warning_text.notification.text = "you can't sell this unit!";
						warning_text.scaleX = warning_text.scaleY = 0;
						warning_text.x = 400;
						warning_text.y = 250;
						TweenMax.to(warning_text, 0.25, {scaleX:1, scaleY:1});
						//trace("insufficient point");
					}
				break;
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
			
			SoundManager.getInstance().playSFX("SN01");
			
			switch(mc)
			{
				case Screen_Barrack.recruit_btn:
				mc.gotoAndStop(2);
				break;
				case Screen_Barrack.disband_btn:
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
			
			//mc.gotoAndStop(2);
			switch(mc)
			{
				case Screen_Barrack.recruit_btn:
				TweenMax.to(mc, 0.15, {glowFilter:{color:0x996600, alpha:1, blurX:10, blurY:10,strength:1.5, quality:3}});
				break;
				case Screen_Barrack.disband_btn:
				TweenMax.to(mc, 0.15, {glowFilter:{color:0x996600, alpha:1, blurX:10, blurY:10,strength:1.5, quality:3}});
				break;
				case Screen_Barrack.goWar_btn:
				TweenMax.to(mc, 0.15, {glowFilter:{color:0x996600, alpha:1, blurX:10, blurY:10,strength:1.5, quality:3}});
				break;
				default:
				TweenMax.to(mc, 0.5, {glowFilter:{color:0xffffff, alpha:1, blurX:10, blurY:10, strength:1.5, quality:3}});
				break;
			}
			//trace("rollover");
			SoundManager.getInstance().playSFX("SN02");
			
		}
               
		private function onMouseLeave(event:MouseEvent):void
		{
			//trace("rollout");

			var mc:MovieClip = MovieClip(event.currentTarget);
			
			//mc.gotoAndStop(1);
			
			TweenMax.to(mc, 0.25, {glowFilter:{alpha:0}});
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			var mc:MovieClip = MovieClip(event.currentTarget);
			
			switch(mc)
			{
				case Screen_Barrack.recruit_btn:
				mc.gotoAndStop(1);
				Recruit(selected_unit);
				break;
				case Screen_Barrack.disband_btn:
				mc.gotoAndStop(1);
				Recruit(selected_unit);
				break;
				case Screen_Barrack.goWar_btn:
				TweenMax.to(Screen_Barrack.goWar_btn, 0.5, { x:24, y: -150, ease:Back.easeInOut, onComplete:function():void {
					GameStateManager.getInstance().setState(State_GameLoop.getInstance());
					}});
				break;
				default:
				/*m_owner.addChild(preview);
				
				preview.x = 665;
				preview.y = 200;
				
				preview.gotoAndStop(mc.id);*/
				//Screen_Barrack.preview.preview_mc.gotoAndStop(1);
				//Screen_Barrack.play();
				//Screen_Barrack.preview.gotoAndStop(mc.id);
				/*if (Screen_Barrack.changePreview)
				{
					Screen_Barrack.preview.gotoAndStop(mc.id);
				}*/
				Screen_Barrack.changePreview = true;
				m_owner.addChild(preview_desc);
				
				preview_desc.x = 675;
				preview_desc.y = 310;
				preview_desc.unitname_txt.text		= "''" + unit_names[mc.id] + "''";
				preview_desc.unitclass_txt.text		= "- " + unit_class[mc.id] + " -";
				preview_desc.unitstory_txt.text 	= unit_story[mc.id];
				preview_desc.unitweakness_txt.text 	= unit_weakness[mc.id];
				preview_desc.unitspecial_txt.text	= unit_special_desc[mc.id];
				
				
				switch(mc.id)
				{
					case 1:
					unlock_point = 0;
					cost_unit = TREASURY_COST;
					Screen_Barrack.recruit_btn.visible = false;
					Screen_Barrack.disband_btn.visible = true;
					registerButton(Screen_Barrack.disband_btn);
					break;
					case 2:
					unlock_point = 0;
					cost_unit = 25;
					Screen_Barrack.recruit_btn.visible = false;
					Screen_Barrack.disband_btn.visible = true;
					registerButton(Screen_Barrack.disband_btn);
					break
					case 3:
					unlock_point = LEEGOS_RESPOINT_UNLOCK;
					cost_unit = LEEGOS_COST;
					if (!GlobalVars.UNLOCKED_LEEGOS)
					{
						Screen_Barrack.recruit_btn.visible = true;
						Screen_Barrack.disband_btn.visible = false;
						unregisterButton(Screen_Barrack.disband_btn);
					}
					else
					{
						Screen_Barrack.recruit_btn.visible = false;
						Screen_Barrack.disband_btn.visible = true;
						registerButton(Screen_Barrack.disband_btn);
					}
					break;
					case 4:
					unlock_point = SEELDY_RESPOINT_UNLOCK;
					cost_unit = SEELDY_COST;
					if (!GlobalVars.UNLOCKED_SEELDY)
					{
						Screen_Barrack.recruit_btn.visible = true;
						Screen_Barrack.disband_btn.visible = false;
						unregisterButton(Screen_Barrack.disband_btn);
					}
					else
					{
						Screen_Barrack.recruit_btn.visible = false;
						Screen_Barrack.disband_btn.visible = true;
						registerButton(Screen_Barrack.disband_btn);
					}
					break;
					case 5:
					unlock_point = AGEESUM_RESPOINT_UNLOCK;
					cost_unit = AGEESUM_COST;
					if (!GlobalVars.UNLOCKED_AGEESUM)
					{
						Screen_Barrack.recruit_btn.visible = true;
						Screen_Barrack.disband_btn.visible = false;
						unregisterButton(Screen_Barrack.disband_btn);
					}
					else
					{
						Screen_Barrack.recruit_btn.visible = false;
						Screen_Barrack.disband_btn.visible = true;
						registerButton(Screen_Barrack.disband_btn);
					}
					break;
					case 6:
					unlock_point = FEELA_RESPOINT_UNLOCK;
					cost_unit = FEELA_COST;
					if (!GlobalVars.UNLOCKED_FEELA)
					{
						Screen_Barrack.recruit_btn.visible = true;
						Screen_Barrack.disband_btn.visible = false;
						unregisterButton(Screen_Barrack.disband_btn);
					}
					else
					{
						Screen_Barrack.recruit_btn.visible = false;
						Screen_Barrack.disband_btn.visible = true;
						registerButton(Screen_Barrack.disband_btn);
					}
					break;
					case 7:
					unlock_point = ELONEE_RESPOINT_UNLOCK;
					cost_unit = ELONEE_COST;
					if (!GlobalVars.UNLOCKED_ELONEE)
					{
						Screen_Barrack.recruit_btn.visible = true;
						Screen_Barrack.disband_btn.visible = false;
						unregisterButton(Screen_Barrack.disband_btn);
					}
					else
					{
						Screen_Barrack.recruit_btn.visible = false;
						Screen_Barrack.disband_btn.visible = true;
						registerButton(Screen_Barrack.disband_btn);
					}
					break;
					case 8:
					unlock_point = ENDROGEE_RESPOINT_UNLOCK;
					cost_unit = ENDROGEE_COST;
					if (!GlobalVars.UNLOCKED_ENDROGEE)
					{
						Screen_Barrack.recruit_btn.visible = true;
						Screen_Barrack.disband_btn.visible = false;
						unregisterButton(Screen_Barrack.disband_btn);
					}
					else
					{
						Screen_Barrack.recruit_btn.visible = false;
						Screen_Barrack.disband_btn.visible = true;
						registerButton(Screen_Barrack.disband_btn);
					}
					break;
					case 9:
					unlock_point = UGEE_RESPOINT_UNLOCK;
					cost_unit = UGEE_COST;
					if (!GlobalVars.UNLOCKED_UGEE)
					{
						Screen_Barrack.recruit_btn.visible = true;
						Screen_Barrack.disband_btn.visible = false;
						unregisterButton(Screen_Barrack.disband_btn);
					}
					else
					{
						Screen_Barrack.recruit_btn.visible = false;
						Screen_Barrack.disband_btn.visible = true;
						registerButton(Screen_Barrack.disband_btn);
					}
					break;
					case 10:
					unlock_point = BARRICADE_RESPOINT_UNLOCK;
					cost_unit = BARRICADE_COST;
					if (!GlobalVars.UNLOCKED_BARRICADE)
					{
						Screen_Barrack.recruit_btn.visible = true;
						Screen_Barrack.disband_btn.visible = false;
						unregisterButton(Screen_Barrack.disband_btn);
					}
					else
					{
						Screen_Barrack.recruit_btn.visible = false;
						Screen_Barrack.disband_btn.visible = true;
						registerButton(Screen_Barrack.disband_btn);
					}
					break;
					case 11:
					unlock_point = TRAP_RESPOINT_UNLOCK;
					cost_unit = TRAP_COST;
					if (!GlobalVars.UNLOCKED_TRAP)
					{
						Screen_Barrack.recruit_btn.visible = true;
						Screen_Barrack.disband_btn.visible = false;
						unregisterButton(Screen_Barrack.disband_btn);
					}
					else
					{
						Screen_Barrack.recruit_btn.visible = false;
						Screen_Barrack.disband_btn.visible = true;
						registerButton(Screen_Barrack.disband_btn);
					}
					break;
					case 12:
					unlock_point = BALLISTA_RESPOINT_UNLOCK;
					cost_unit = BALLISTA_COST;
					if (!GlobalVars.UNLOCKED_BALLISTA)
					{
						Screen_Barrack.recruit_btn.visible = true;
						Screen_Barrack.disband_btn.visible = false;
						unregisterButton(Screen_Barrack.disband_btn);
					}
					else
					{
						Screen_Barrack.recruit_btn.visible = false;
						Screen_Barrack.disband_btn.visible = true;
						registerButton(Screen_Barrack.disband_btn);
					}
					break;
					
				}
				preview_desc.rp_require.text = String(unlock_point);
				preview_desc.cost_require.text = String(cost_unit);
				selected_unit = mc.id;
				break;
			}
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
		
		static public function getInstance(): State_BarrackScreen
		{
			if ( m_instance == null )
			{
				m_instance = new State_BarrackScreen( new SingletonLock() );
			}
			return m_instance;
		}
	}

}
class SingletonLock{}