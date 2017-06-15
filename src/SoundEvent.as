package
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Kurniawan Fitriadi
	 */
	public class SoundEvent extends Event
	{
		public var volume:Number=1;
				
		public function SoundEvent(type:String) 
		{
			super(type);
		}
	}
}