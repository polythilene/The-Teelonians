///////////////////////////////////////////////////////////
//  CTeeloLeegos.as
//  Macromedia ActionScript Implementation of the Class CTeeloLeegos
//  Generated by Enterprise Architect
//  Created on:      13-Dec-2010 1:45:47 PM
//  Original author: poof!
///////////////////////////////////////////////////////////

package com.game
{
	import com.game.CPlayerTeelos;

	/**
	 * @author poof!
	 * @version 1.0
	 * @created 13-Dec-2010 1:45:47 PM
	 */
	public class CTeeloLeegos extends CPlayerTeelos
	{
		public function CTeeloLeegos(){

		}
		
		override public function initialize():void 
		{
			super.initialize();
			
			m_attack = 2;
			m_defense = 6;
			m_maxLife = 40;
			m_unitClass = UNITCLASS.INFANTRY;
			m_counterClass = UNITCLASS.CAVALRY;
			m_counterBonus = 25;
			m_baseSpeed = 0.12;
			m_baseCooldownTime = 1100;
			m_trainCost = 220; //siput
		}
		
		override protected function createSprite():void 
		{
			super.createSprite();
			m_sprite = new mcTeelo_Leegos();
		}

	}//end CTeeloLeegos

}