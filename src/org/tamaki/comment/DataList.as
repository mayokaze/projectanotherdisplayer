package org.tamaki.comment
{
	public class DataList
	{
		private var ci:uint //current index
		private var datas:Array //datas
		public function DataList(ds:Array)
		{
			init(ds)
		}
		public function init(ds:Array):void
		{
			datas = ds
			ci = 0
			datas.sortOn("time",16);
		//trace(datas.length)
		}
		//need binarysearch...plz don's say you were lazy
		public function  resetIndex(time:int):void
		{
         for(var i:uint = 0;i < datas.length;i++)
          {
          	if(CommentData(datas[i]).time == time)
          	 {
          	 	trace("time" + CommentData(datas[i]).time)
          	 	this.ci = i
          	 	break;
          	 }
          } 
			
        }
        public function get size():uint
        {
        	return this.datas.length
        }
	    public function nextComment(time:int):CommentData
	    {
	     	return CommentData(datas[ci++])
	    }
	    
	    public function hasNext(time:int):Boolean
	    {
	    //  trace("------"+time)
	     // trace(CommentData(datas[ci]).time+"---------")
	      if(ci >= datas.length)
	       return false
	      if(CommentData(datas[ci]).time < time)
	       this.resetIndex(time) 
	      if(CommentData(datas[ci]).time == time)
	    	 return true
	    	else
	    	return false 
	    }
		

	}
}