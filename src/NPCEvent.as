package  
{
	import com.game.CBaseTeelos;
	import flash.events.Event;
	import com.game.CBaseTeelos;
	
	/**
	 * ...
	 * @author Wiwit
	 */
	public class NPCEvent extends Event
	{
		public var npc:CBaseTeelos;
		public function NPCEvent(type:String, targetNPC:CBaseTeelos) 
		{
			super(type);
			npc = targetNPC;
		}
	}
}