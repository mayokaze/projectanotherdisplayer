
package org.tamaki.util
{
	
	
	public class StringUtilEX 
	{
		public function StringUtilEX()
		{
			
		}
		public static function replaceAll(_str0:String,_pattern:String,_repl:String):String{
                        if(_str0.indexOf(_pattern)==-1){
                                return _str0;
                        }
                        return replaceAll(_str0.replace(_pattern,_repl),_pattern,_repl);
                }
        //it's not always right。。but。。。        
        public static function getTextWidth(src:String,fsize:Number):Number{
                var length:Number =0 ;
               if(src.indexOf("\n") >= 0)
                {
                 var lines:Array = src.split("\n");
                  src = lines[0];
                   for(var j:int = 0; j<lines.length;j++)
                 {
    	            // trace(lines[j]) 
                     if(String(lines[j]).length > src.length)    
                 {
                       src = lines[j] ;
                 }
                 }
               }
               
                   for(var i:int = 0; i< src.length; i++)
                {
                     var code:Number  = src.charCodeAt(i);
                      //trace(code);
                   if( code >=  0x2e80 && code <= 0x9fff)
                   {
     	               length += 1.0
   
                    }
                    else if(code >= 65 && code <= 90)
                    {
                    	length += 0.7
                    }
                   else
                    {
                       length += 0.6
     
                    }
               }
 
                  return length * fsize + src.length * 4;
               }
          public static function getTextHeight(src:String,fsize:Number):Number
          {
          	 var lines:Array = src.split("\n");
             return fsize * 1.35 * lines.length
          }
        
         }
} 