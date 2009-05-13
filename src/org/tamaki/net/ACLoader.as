package org.tamaki.net
{
	import flash.events.EventDispatcher;
	
	import org.tamaki.comment.CommentData;
	import org.tamaki.events.LoadEvent;
	
	public class ACLoader extends EventDispatcher
	{   
		private var rs:RegexSearcher = new RegexSearcher(/id=(\d*)&amp/);
		private var mvl:MultiVideoLoader = new MultiVideoLoader
		private var mcl:MultiCommentLoader = new MultiCommentLoader
		private var offset:uint = 0
		private var tlength:uint = 0
		private var us:Array //urls
		private var vids:Array = new Array//vids
		private var ifds:Array //infodatas
		private var cdss:Array//comments list's list
		private var anyComplete:Boolean = false
		
		public function ACLoader()
		{   
			rs.addEventListener(LoadEvent.REGEX_COMPLETE,onSload)
			mvl.addEventListener(LoadEvent.MULTI_VIDEO_COMPLETE,onVload)
			mcl.addEventListener(LoadEvent.MULTI_COMMENT_COMPLETE,onCload)
		}
		public function reset():void
		{
			this.mvl.reset()
			this.mcl.reset()
			this.offset = 0
			this.tlength = 0
			this.us = new Array
			this.vids = new Array
			this.ifds = null
			this.cdss = null
			this.anyComplete = false
		}
		public function loadParts(url:String):void
		{
			this.us = this.getURLS(url)
			rs.searchURL(us.shift())
		}
		private function getURLS(url:String):Array
		{
		  var us:Array = new Array
		  var idx:int = url.indexOf("_")
		  if(idx > 0)
		  {
		  	var count:int = int(url.charAt(idx+1).toString())
		  	var base:String = url.substring(0,idx)
		  	var postfix:String = ".html"
		  	us.push(base + postfix)
		  	for(var i:int = 2;i <= count;i++)
		  	{
		  		us.push(base + "_" + i + postfix)
		  	}
		  }
		  else
		   us.push(url)
	//	  trace("urls"+us[1]) 
		  return us 	
		}
		private function onSload(eve:LoadEvent):void
		{    
			
			var find:Array = eve.info as Array
		//	trace(find[1])
			if(find)
		   {	
			if(find[1])
			{
			 vids.push(find[1])
			}
		   }
			if(us.length > 0)
			{
		//	 trace("search next")		
			 rs.searchURL(us.shift())
			}
			else
			{
		//	 trace("searched")	
			 mvl.loadVideos(vids)
			 mcl.loadComments(vids) 
			}
		}
	    private function onVload(eve:LoadEvent):void
	    {
	    trace("vload")
	      this.ifds = eve.info as Array	
	 //     trace("ifds length" + ifds.length)
	      if(anyComplete)
	      {
            this.dispachAll()
            this.anyComplete = false
          } 
	      else
	      {
	       this.anyComplete = true
	      }
	     }
	   private function onCload(eve:LoadEvent):void
	   {
	   	trace("cload")
	   	this.cdss = eve.info as Array
	   	 if(anyComplete)
	   	  {
	   	  this.dispachAll()
	   	  this.anyComplete = false
	   	  }
	   	 else
	   	 {
	   	 this.anyComplete = true 
	   	 }
	   }
	   private function dispachAll():void
	   {
	      var vis:Array = new Array//videoinfos
	      var cds:Array = new Array//totally commentdatas
	      for(var i:int = 0 ;i< cdss.length;i++)
		    {
                vis = vis.concat(InfoData(ifds[i]).infos)
                var tcds:Array = cdss[i] as Array
                 for each(var cd:CommentData in tcds)
                  {
                  	cd.time += this.offset 
                  	cds.push(cd)
                  }
                this.offset += InfoData(ifds[i]).total/1000
                this.tlength +=  InfoData(ifds[i]).total
		    }
		 var ifd:InfoData = new InfoData(tlength,vis)
		 var mifd:MultiInfoData = new MultiInfoData(ifd,cds) 
		 this.dispatchEvent(new LoadEvent(LoadEvent.MULTI_PART_COMPLETE,mifd))   
	   }
	  }
}