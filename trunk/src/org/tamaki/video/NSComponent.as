package org.tamaki.video
{
	import flash.events.Event;
	import flash.media.Video;
	
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;
	
	import org.tamaki.events.*;
	
	public class NSComponent extends UIComponent
	{
		private var nss:Array //netstream
		private var ifs:Array //videoinfo
		private var ofs:Array //offset:uint
		private var bi:int //buffer index
		private var pi:int//play index
		private var _$volume:Number 
		private var _$video:Video  
		private var _$total:uint 
		private var _$state:String = NSComponent.UNLOAD
		private var _$smoothing:Boolean
		private var _$metaReader:NS
		private var _$url:String//temp url
/* 		private var _$nc:NetConnection//for read meta
		private var _$ns:NetStream
		
 */	//	private static var hasInstance:Boolean = false
	//	private static var self:NSManager//singleton
        public  static const  UNLOAD:String = "unLoad"
		public  static const  PLAY:String = "play"
		public  static const  STOP:String = "stop"
	    public  static const  PAUSE:String = "pause"
	    
	    
	    public function NSComponent()
	    {
	     super() 
 	     this._$video = new Video()
	     this.addChild(this._$video)
	     this._$video.height = this.height
	     this._$video.width = this.width
	     this.addEventListener(ResizeEvent.RESIZE,resize)
         }
	    public function initBySingleUrl(url:String):void
	    {
          this.close()
          this.resetAll()
          this._$url = url
          this._$metaReader = new NS
          this._$metaReader.addEventListener(NSEvent.META_DATA,onMetaData)
          this._$metaReader.loadV(url)
          this.addEventListener(NMEvent.META_LOADED,onMetaLoaded)
          this.addEventListener(NMEvent.COMPLETE,onComplete)
	    }
	    private function onMetaLoaded(eve:NMEvent):void
	    {
	      initOffset()
		  createBuffer()
		  play()
		  this.dispatchEvent(new NMEvent(NMEvent.URL_COMPLETE))
		}
        public function init(ifv:Array,tv:uint):void
		{   
		    this.close()
		    this.resetAll() 
		    this.ifs = ifv
		    this._$total = tv
		    initOffset()
			createBuffer()
			play()
			this.addEventListener(NMEvent.COMPLETE,onComplete)
		}
		public function resize(eve:Event):void
		{
			this._$video.width = this.width
			this._$video.height = this.height
		}
		private function initOffset():void
		{
			var co :uint = 0//current offset
			for(var i:uint = 0;i < ifs.length;i++)//sucks!!!!!!i need generics
			{
				ofs[i] = co += VideoInfo(ifs[i]).length
			}
			
		}
       private function resetAll():void
       {
       	this.bi = -1
       	this.pi = -1
       	this._$volume = 0.7
       	this.nss = new Array()
       	this.ofs = new Array()
   //    	this._$state = NSComponent.UNLOAD
       	this.removeEventListener(NMEvent.COMPLETE,onComplete)
       }

		private function createBuffer():void
		{   
			
			//trace("if:"+ifs[bi])
			if(ifs[++bi])
			{
			var ns:NS = new NS()
			var info:VideoInfo = VideoInfo(ifs[bi])
			ns.id = info.id 
		    ns.loadV(info.url)
		    trace("create ("+(bi)+"):"+ info.url)
            ns.addEventListener(NSEvent.STOP, onStop);
            ns.addEventListener(NSEvent.CHECK_FULL, onFull);
            ns.addEventListener(NSEvent.BUFFERING,onBuff);
            ns.addEventListener(NSEvent.PLAYING,onPlaying);
            ns.addEventListener(NSEvent.FILE_EMPTY,onNotFound);
            ns.volume = this._$volume
            nss.push(ns)
             //   trace("ns length" + nss.length)
            }
		}
		private function changeNS():void
		{  
		 if(pi >= 0)//is first?
		   {
		    if(!nss[pi])
			 return
		    NS(nss[pi]).stopV()
		   } 

           //trace("nss length:"+nss.length)
		 //   trace("pi"+pi)
		 if(nss[pi+1])//hasnext?
		    {
		    //trace("playing")
		    NS(nss[++pi]).playV()
		    this.attachVideo(_$video)
		    }
		     
		}

		private function onFull(eve:NSEvent):void
		{

			//trace("onfull")
			NS(nss[bi]).removeEventListener(NSEvent.BUFFERING,onBuff)
			NS(nss[bi]).removeEventListener(NSEvent.CHECK_FULL,onFull)
			createBuffer()
		}
		private function onStop(eve:NSEvent):void
		{
			//trace("onstop ifs length:" + ifs.length)
		//	trace("onstop playindex:" + pi)
			if(pi == ifs.length-1)
			{
			//	trace("dispach")
				this.dispatchEvent(new NMEvent(NMEvent.STATE_CHANGE,"stop"))
				this.dispatchEvent(new NMEvent(NMEvent.COMPLETE))
				this._$state = NSComponent.STOP
			}
			changeNS()
		}
		private function onBuff(eve:NSEvent):void
		{
			//trace("loaded current part:"+eve.info)

			if(bi == 0)
			{
			 var next:Number = ofs[bi]/_$total
			 var current:Number = Number(eve.info) * next   
			 this.dispatchEvent(new NMEvent(NMEvent.PROGRESS,current))
			}
            else
            {
			var pre:Number = ofs[bi-1]/_$total
			var next:Number = ofs[bi]/_$total
			var current:Number = pre + Number(eve.info) * (next - pre)
			//trace("pre="+pre+"next="+next+"current="+current);            	
            this.dispatchEvent(new NMEvent(NMEvent.PROGRESS,current))
            }
		}

		private function onPlaying(eve:NSEvent):void
		{
		 
		 	//trace(eve.info) 
		 	if(pi == 0)
		 	 this.dispatchEvent(new NMEvent(NMEvent.PLAY_HEAD_UPDATE,uint(eve.info)))
		    else
		 	{
		 	//	trace("of+" +ofs[pi-2])
		 		//trace(eve.info)
		 	this.dispatchEvent(new NMEvent(NMEvent.PLAY_HEAD_UPDATE,uint(ofs[pi-1]+uint(eve.info))))
             }		
		}
		private function onComplete(eve:NMEvent):void
		{
			trace("completeex")
			this._$video.clear()
			pi = -1
			// NS(this.nss[0]).bufferTime = 0
		}
        private function onNotFound(eve:NSEvent):void
		{
			this.dispatchEvent(new NMEvent(NMEvent.VIDEO_NOT_FOUND))
		}
		private function getPIByTime(time:uint):uint
		{   
		   //trace("time:"+time)
		    var i:uint = 0;
		    var pre:uint = 0;
		 	for(;i<nss.length;)
		 	{
              if( time > pre && time <=  ofs[i])
               break;
              pre =  ofs[i++]
             }
		 	 return i
		}
		private function seekInPart(time:uint,si:uint):void
		{
			trace("seek time:"+time)
			 var ptime:uint
			 if (si == 0)
			   ptime = time
			 else
			   ptime = time - ofs[si-1]
			 trace("seek ptime:"+ptime)
			 NS(nss[pi]).seekV(ptime)
			 this.play()
		}
		private function attachVideo(v:Video):void
		{   
			v.clear()
			v.attachNetStream(NS(nss[pi]).ns)
		}

	   public function onMetaData(eve:NSEvent):void
		{
			this._$total = eve.info.duration  * 1000
			this.ifs = new Array
			this.ifs.push(new VideoInfo(this._$url,eve.info.duration *1000))
			this._$metaReader.removeEventListener(NSEvent.META_DATA,onMetaData)
			this._$metaReader.closeV()
			this._$metaReader = null
			this.dispatchEvent(new NMEvent(NMEvent.META_LOADED))
		}
	
	/************************************api**************************************/
		public function seek(time:uint):Boolean
		{
			if(this._$state == NSComponent.STOP||this._$state == NSComponent.UNLOAD)
			  return false
			var si:uint = this.getPIByTime(time)
			if(si >= nss.length)
			  si = nss.length-1
			//trace("si:"+si)
			//trace("pi:"+ (pi-1))
			if(si == pi)//is current playing
			{
				
				this.seekInPart(time,si)
				//this.play()
			}
			else
			{
				trace("seek index is--------"+si)
				trace("current playing ------"+(pi))
				this.stop()
			//	this.video.clear()
			     pi = si
				this.attachVideo(this._$video)
                this.seekInPart(time,si) 
				//this._$state = NSManager.PLAY
			}
			return true	
		}
		//merge play and start
		public function play():Boolean
		{ 
		if(this._$state == NSComponent.PLAY)
			 return	false
	 	 if(pi == -1)
			changeNS()
		 else
		    NS(nss[pi]).playV()
		 this.dispatchEvent(new NMEvent(NMEvent.STATE_CHANGE,"play"))
		 this._$state = NSComponent.PLAY 
		 return true 	
		}
		
		public function pause():Boolean
		{
		if(this._$state != NSComponent.PLAY)
			 return false
			NS(nss[pi]).pauseV()	
		  this.dispatchEvent(new NMEvent(NMEvent.STATE_CHANGE,"pause")) 
		  this._$state = NSComponent.PAUSE
		  return true
		}
		public function stop():Boolean
		{
		//  	trace(nss.length)
		 if(this._$state == NSComponent.STOP||this._$state==NSComponent.UNLOAD)
			  return false
		for(var i:uint = 0;i<nss.length;)
		  	{
	            NS(nss[i++]).stopV()
	        }
		  this.dispatchEvent(new NMEvent(NMEvent.STATE_CHANGE,"stop")) 
		  this._$state = NSComponent.STOP
		  this._$video.clear()
		  pi = -1
		 // NS(this.nss[0]).bufferTime = 0
		  return true
		}
		
		public function close():Boolean
		{
		  	
		  if(this._$state==NSComponent.UNLOAD)
			  return false
			trace("close videos"+nss.length)  
		  	for(var i:uint = 0;i<nss.length;)
		  	{         
	             NS(nss[i]).removeEventListener(NSEvent.PLAYING,onPlaying)
	             NS(nss[i]).removeEventListener(NSEvent.STOP, onStop)
	             NS(nss[i]).removeEventListener(NSEvent.FILE_EMPTY,onNotFound)
	             NS(nss[i++]).closeV()
		  	}
		  this._$video.clear()
		  this.resetAll() 
		  this._$state = NSComponent.UNLOAD
           return true  
		}


		public function get video():Video
		{
			return _$video
		}
		public function get state():String
		{
			return _$state
		}
		public function get smoothing():Boolean
		{
			return this._$smoothing
		}
		public function set smoothing(smoothing:Boolean):void
		{
			this._$video.smoothing = smoothing
			this._$smoothing = smoothing
		}
		public function get volume():Number
		{
			return this._$volume
		}
		public function set volume(vol:Number):void
		{
			for(var i:uint=0;i<nss.length;)
		  	{
	            NS(nss[i++]).volume = vol
		  	}
		  	this._$volume = vol
		}
		public function get total():uint
		{
			return this._$total 
		}

	}
}