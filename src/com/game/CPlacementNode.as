package com.game 
{
	/**
	 * ...
	 * @author Wiwitt
	 */
	public class CPlacementNode extends PlacementDummy
	{
		private var m_laneId:int;
		private var m_obtained:Boolean;
		
		public function CPlacementNode() 
		{
			m_obtained = false;
		}
		
		public function set laneId(value:int):void
		{
			m_laneId = value;
		}
		
		public function get laneId():int
		{
			return m_laneId;
		}
		
		public function set obtained(value:Boolean):void
		{
			m_obtained = value;
		}
		
		public function get obtained():Boolean
		{
			return m_obtained;
		}
	}
}