package  
{
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	/**
	 * ...
	 * @author Kurniawan Fitriadi
	 */
	public class CGameState 
	{
		protected var m_owner:DisplayObjectContainer;
				
		public function CGameState() 
		{
		}
		
		public function get owner():DisplayObjectContainer
		{
			return m_owner;
		}
		
		public function get stage(): Stage
		{
			return m_owner.stage;
		}
		
		public function addChild(child:DisplayObject): DisplayObject
		{
			return m_owner.addChild(child);
		}
		
		public function addChildAt(child:DisplayObject, index:int): DisplayObject
		{
			return m_owner.addChildAt(child, index);
		}
		
		public function removeChild(child:DisplayObject): DisplayObject
		{
			return m_owner.removeChild(child);
		}
		
		
		/// DITURUNIN SMUA
		
		public function initialize(owner:DisplayObjectContainer): void
		{
			m_owner = owner;
		}
		
		public function enter(): void
		{
			/* ABSTRACT METHOD */
		}
		
		public function exit(): void
		{
			/* ABSTRACT METHOD */
		}
		
		public function update(elapsedTime:int): void
		{
			/* ABSTRACT METHOD */
		}
		
	}

}