package org.tamaki.net
{
	import flash.events.EventDispatcher;
	
	import org.tamaki.events.LoadEvent;
	import org.tamaki.util.ArrayUtil;
	
	public class MultiVideoLoader extends EventDispatcher
	{
		//private var pcount:uint //part count
		private var _$vids:Array  = new Array//vids
		private var ifds:Array  = new Array//infodatas
		private var vl:VideoLoader = new VideoLoader
		private var vis:Array = new Array // video infomations
		private var tLength:uint = 0//total length
		public function MultiVideoLoader()
		{
			vl.addEventListener(LoadEvent.VIDEO_COMPLETE,onLoad)
		}
	//LOAD MULTI XML FILE,YOU MUST ENSURE THAT THE VID LIST HAS BEEN SORTED ALREADY
		public function loadVideos(vids:Array):void
		{  
		    ArrayUtil.deepCopy(vids,this._$vids)
		//    trace("in mv"+vids[0])
		 //   trace("in mv"+vids[1])
		    if(this._$vids.length > 0)
		    {
		    	vl.loadVideo(this._$vids.shift())
		    }
			//this.pcount = vids.length
		}
		public function reset():void
		{
			this._$vids = new Array
			this.ifds = new Array
			this.vis = new Array
			this.tLength = 0
		}
		private function onLoad(eve:LoadEvent):void
		{
		//	trace("mv once")
			this.ifds.push(eve.info)
            if(this._$vids.length > 0)
		    {
		  //  	trace("next video")
		    	vl.loadVideo(this._$vids.shift())
		    }
		    else
		    {
/* 		       for each(var ifd:InfoData in ifds)
		    	{
		    		vis.concat( ifd.infos)
		    		tLength += ifd.total
		    	} */
		    //	var tifd:InfoData = new InfoData(tLength,vis)
		 //    trace("mvload----" + ifds.length)
		    	this.dispatchEvent(new LoadEvent(LoadEvent.MULTI_VIDEO_COMPLETE,ifds));
		    }
		}

	}
}