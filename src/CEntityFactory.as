package  
{
	import com.combatant.CBaseCombatant;
	import de.polygonal.core.ObjectPoolFactory;
	
	/**
	 * ...
	 * @author Wiwit
	 */
	
	public class CEntityFactory implements ObjectPoolFactory
	{
		private var m_entityType:Class;
		
		public function CEntityFactory(classType:Class) 
		{
			m_entityType = classType;
		}
		
		public function create():*
		{
			return new m_entityType(m_layerID); 
		}
	}
}