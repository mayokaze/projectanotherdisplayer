package org.tamaki.comment
{
	public class UsedPos
	{
		private var _$top:int;
		private var _$bottom:int;
		private var _$width:int;
		private var _$joinTime:int;
		private var _$type:uint;
		
		public function UsedPos(top:int,bottom:int,width:int,joinTime:int,type:uint)
		{
			//trace("jointime init" + joinTime)
			this._$top = top;
			this._$bottom = bottom;
			this._$width = width;
			this._$joinTime = joinTime;
			this._$type = type;
	    }
	    
	    public function get top():int
	    {
	    	return this._$top
	    }
	    public function get bottom():int
	    {
	    	return this._$bottom
	    }
	    public function get width():int
	    {
	    	return this._$width
	    }
	    public function get joinTime():int
	    {
	    	return this._$joinTime
	    }
	    public function get type():uint
	    {
	       return this._$type
	    }
	 /*   public function isValid(time:int,type:int):Boolean
	    {
	    if(type <= 3)
	     {
	     if(this.joinTime == time)
	      {
	      return true
	      }
	      else if(this.joinTime + 1 == time)
	       {
	        if(width >= 97)
	         return true;
	       }
	      else if(this.joinTime + 2 == time)
	      {
	        if(width >= 194)
	         return true;
	      } 
	      else if(this.joinTime + 3 == time)
	       {
	       if(width >= 291)
	        return true;
	       }
	       else if(this.joinTime + 4 == time)
	       {
	       if(width >= 388)
	        return true;
	       }
	     /*  else if(this.joinTime + 5 == time)
	       {
	       if(width >= 480)
	        return true;
	       }*/
	  /*     else
	       {
	     return false;
	       }
	     }
	     else
	     {
	     //	trace("inner: " + time);
	      if(this.joinTime + 3 < time)
	       return false;
	      else
	       return true; 
	     }
	    return false; 
	    }*/

	}
}