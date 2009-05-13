package org.tamaki.util
{
	public class ArrayUtil
	{
		public function ArrayUtil()
		{
		}
		public static function deepCopy(src:Array,des:Array):void
		{
		
		  for each(var element:* in src)
		  {
		  	des.push(element)
		  }	
		}
   }
} 