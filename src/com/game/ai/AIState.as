package com.game.ai
{
	import flash.geom.*;
	import flash.utils.*;
	import com.game.CBaseTeelos;
	
	public class AIState
	{	
		protected var m_enableTimeOut:Boolean = false;
		protected var m_timeOutInterval:int = 10000;
	
		protected var m_stateName:String = "-Undefined-";
		
		public function enter(npc:CBaseTeelos):void 
		{
			// to be inherited
		}
		
		public function update(npc:CBaseTeelos, elapsedTime:int):void 
		{
			// to be inherited
		}
		
		public function exit(npc:CBaseTeelos):void 
		{
			// to be inherited
		}
		
		public function getStateName() : String 
		{
			return m_stateName;
		}
		
		public function isTimeoutEnable() : Boolean 
		{
			return m_enableTimeOut;
		}
		
		public function getTimeoutInterval() : int 
		{
			return m_timeOutInterval;
		}
		
		protected function isPositionInsideBound(xpos:int):Boolean 
		{
			return false;	// FIXME: boundary check
		}
	}
}