///////////////////////////////////////////////////////////
//  CTeeloUdizark.as
//  Macromedia ActionScript Implementation of the Class CTeeloUdizark
//  Generated by Enterprise Architect
//  Created on:      20-Des-2010 0:11:06
//  Original author: poof!
///////////////////////////////////////////////////////////

package com.game
{
	import com.game.CEnemyTeelos;

	/**
	 * @author poof!
	 * @version 1.0
	 * @created 20-Des-2010 0:11:06
	 */
	public class CTeeloRammer extends CEnemyTeelos
	{
		public function CTeeloRammer(){

		}
		
		override public function initialize():void 
		{
			super.initialize();
			
			m_attack = 3;
			m_defense = 8;
			m_maxLife = 100;
			m_unitClass = UNITCLASS.SIEGE;
			m_counterClass = UNITCLASS.BUILDING;
			m_counterBonus = 120; //siom, 23jan011 12:09
			m_baseSpeed = 0.018; //siom, 23jan011 12:09
			m_dropMin = 5;
			m_dropMax = 5;
			m_baseCooldownTime = 4000;
		}
		
		override protected function createSprite():void 
		{
			super.createSprite();
			m_sprite = new mcTeelo_Rammer();
		}
		
		override public function animationHit():void 
		{
			// no animation
		}

	}//end CTeeloUdizark

}