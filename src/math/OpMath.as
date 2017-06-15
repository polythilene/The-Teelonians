/*
	Package : Optimized Math Functions
	Author	: Kurniawan Fitriadi
	Note	: This package contains optimized trigonometry functions using lookup table,
			  important!!! call Initialize() method before using these functions.
*/


package math
{
	public final class OpMath {
		
		public static function randomNumber(max:Number):Number {
			return Math.random() * max;
		}
		
		public static function randomRange(minNum:Number, maxNum:Number):Number  {
			return ( Math.random() * (maxNum - minNum + 1) + minNum );
		}
		
		public static function distance2(x1:int, y1:int, x2:int, y2:int): Number 
		{
			return ( Math.sqrt( ((x2-x1)*(x2-x1)) + ((y2-y1)*(y2-y1)) ) );
		}
	}
}