package utils 
{
	/**
	 * ...
	 * @author Wiwit
	 */
	public class Utility
	{
		
		static public function copyArray( source:Array ):Array
		{
			var buff:Array;
			if ( source && source.length > 0 )
			{
				buff = [];
				for( var i:int = 0; i < source.length; i++ )
				{
					buff[i] = source[i];
				}
			}
			return buff;
		}
	}

}