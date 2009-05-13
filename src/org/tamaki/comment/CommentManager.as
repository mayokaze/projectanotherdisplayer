package org.tamaki.comment
{
	import mx.core.UIComponent;
	import mx.effects.Fade;
	import mx.effects.Glow;
	import mx.effects.Move;
	import mx.events.EffectEvent;
	
	
	public class CommentManager
	{   
		//-----------------------------------inject by config file
	    private  var _$sduration:uint ;//scroll duration
		private  var _$fduration:uint ;//fade duration
	  //private  var _$gdruation:uint;//glow duration 
		//private  var _$capacity:uint;//max comments size
		//---------------------------------------------------------
		private  var  _$parent:UIComponent;//parent container dimesion
        private  var  _$isFullScreen:Boolean 
     //   private  var  _$width:Number
      //  private  var  _$height:Number
		private  var  upss:Array //current in use positon list for scroll 
		private  var  upts:Array //current in use positon list for top fade
        private  var  upbs:Array//current in use positon list for bottom fade
        private  var  ces:Array //cepairs 
        private  var  dl:DataList;
        private  var  cf:CommentFactory;
        private  var  geff:Glow ;
        private  var  ct:uint;//currentTime
		public function CommentManager(parent:UIComponent,sd:uint = 5000,fd:uint = 4000)
		{   
			 this.cf = new CommentFactory
			 this.geff = new Glow
			 this._$parent = parent
			// this._$width = parent.width
			 //this._$height = parent.height
			// this._$parent.addEventListener(ResizeEvent.RESIZE,onResize)
			 this._$sduration = sd
			 this._$fduration = fd
			// this._$capacity = cap
		     var gdruation:uint = sd  > fd ? sd+1000 :fd+1000
             this.geff.duration = gdruation 
		     this.geff.color = 0
		   //  this.geff.alphaFrom = 1
		    // this.geff.alphaTo = 1
		     this.geff.strength = 5
		}
		public function init(cds:Array):void
		{
			this.clearAll()
			this.dl = new DataList(cds)
			this.ces = new Array()
			this.upss = new Array()
			this.upts = new Array()
			this.upbs = new Array()
			this.cf = new CommentFactory
		//	trace(cds.length)
			// for each(var cd:CommentData in cds)
		   //   trace(cd.time)
			//trace(this._$height)
			//trace(this._$width)
	    }
		
		public function displayComments(time:uint):void
		{
			if(time == ct)
			 return
		//	trace(time) 
		     ct = time
			while(dl.hasNext(time))
			{
			 var tempCD:CommentData =  dl.nextComment(time)
			// trace(tempCD.txt)
			 this.display(tempCD)
			}
			
		}
        public function pause():void
        {
        //	trace("pause" + ces.length)
        	for each(var cp:CEPair in ces)
        	{
        		cp.effect.pause()
        	}
        	geff.pause()
        } 
        public function resume():void
        {
        //	trace("resume" + ces.length)
        	for each(var cp:CEPair in ces)
        	{   
        		cp.effect.resume()
        	}
        	geff.resume()
        }
       
        public function resetTime(time:int):void
        {
         this.clearAll()
         this.dl.resetIndex(time)
        // this.ct = time	
        }
         public function  set fullScreen(fs:Boolean):void
        {
        	/* if(!fs)
        	{
        		//this._$height = this._$parent.height
        		//this._$width = this._$parent.width
        	}
        	else
        	{
        		//this._$height = this._$parent.stage.height
        		//this._$width = this._$parent.stage.width
        	} */
        	this._$isFullScreen = fs
        } 
        public function get fullScreen():Boolean
        {
        	return this._$isFullScreen
        } 
        
        public function get parent():UIComponent
		{
			return this._$parent
		}
   /*     private function onResize(re:ResizeEvent):void
        {
        	this._$height = this._$parent.height
        	this._$width = this._$parent.width
        }*/
        private function display(cd:CommentData):void
		{
		//	trace(cd.txt)
         var cmt:Comment = this.cf.instanceCom()//comment this line and uncomment next line to use gc mode
     //    var cmt:Comment = new Comment()
         cmt.setComment(cd)
           if(cd.mode < 4)
           displayScroll(cmt)
          else if(this._$isFullScreen)
           return
          else if(cd.mode == 4)
            displayBFade(cmt)
          else if(cd.mode == 5)
            displayTFade(cmt) 
		}
		private function displayScroll(cmt:Comment):void
		{
			var tmv:Move = new Move
			tmv.duration = this._$sduration
			
			var tce:CEPair = new CEPair(cmt,tmv)
			this.setTrace(tce)
		//	trace("mdr"+tmv.duration)
		//	trace("mxt"+tmv.xTo)
		//	trace("mxf"+tmv.xFrom)
		//	trace("myf"+tmv.yFrom)
		//	trace("myt"+tmv.yTo)
			this._$parent.addChild(cmt)
			//trace(cmt.swidth)
			//trace(cmt.sheight)
		 	cmt.setVisible(true)
         //   cmt.validateSize()
		//	trace("playing" + cmt.text)
		//	trace("width"+cmt.width)
			geff.play([cmt])
			tmv.play([cmt])
			this.ces.push(tce)
			tmv.addEventListener(EffectEvent.EFFECT_END,eventUp(release,tce))
		}
		private function displayTFade(cmt:Comment):void
		{
			var tfd:Fade = new Fade
			tfd.duration = this._$fduration
			tfd.alphaFrom = 1
			tfd.alphaTo = 0
			var tce:CEPair = new CEPair(cmt,tfd)
			this.ces.push(tce)
			this.setTPosition(cmt)
			tfd.addEventListener(EffectEvent.EFFECT_END,eventUp(release,tce))
			parent.addChild(cmt)
			cmt.setVisible(true)
			geff.play([cmt])
			tfd.play([cmt])
	 }
		private function displayBFade(cmt:Comment):void
		{
			var tfd:Fade = new Fade
			tfd.duration = this._$fduration
			tfd.alphaFrom = 1
			tfd.alphaTo = 0
			var tce:CEPair = new CEPair(cmt,tfd)
			this.ces.push(tce)
			this.setBPosition(cmt)
		    tfd.addEventListener(EffectEvent.EFFECT_END,eventUp(release,tce))
			parent.addChild(cmt)
			cmt.setVisible(true)
			geff.play([cmt])
			tfd.play([cmt])
		}
		private function setTrace(cp:CEPair):void
		{
		//	trace("com height="+cmt.height)
			var y:Number =  this.getY(upss,cp.comment.height)
			//trace("now y = " + y)
			Move(cp.effect) .xFrom = parent.width
			Move(cp.effect).xTo = 0 - cp.comment.width
			Move(cp.effect).yFrom = y
			Move(cp.effect).yTo = y
		 //trace("parentwidth" + parent.width)
			var cpos :UsedPos = new UsedPos(y,y + cp.comment.height,cp.comment.width,ct,cp.comment.mode)
			upss.push(cpos)
		}
		private function setTPosition(cmt:Comment):void
		{
		 	var y:Number = this.getY(upts,cmt.height)
		 	var x:Number = this.getX(cmt.width)
		 	cmt.x = x
		 	cmt.y = y
		 	var cpos :UsedPos = new UsedPos(y,y + cmt.height,cmt.width,ct,cmt.mode)
		 	upts.push(cpos)
		}
		private function setBPosition(cmt:Comment):void
		{
			var y:Number = this.getRY(upbs,cmt.height)
			var x:Number = this.getX(cmt.width)
			cmt.x = x
			cmt.y = y
			var cpos :UsedPos = new UsedPos(y,y + cmt.height,cmt.width,ct,cmt.mode)
			upbs.push(cpos)
		}

	

         //closure...
		private  function eventUp(f:Function,ce:CEPair):Function
        {  return function(e:EffectEvent):void{f.call(null,ce);}}
       
	    private function release(ce:CEPair):void
        {
          //	trace("release------"+ce.comment.text)
          if(ce.comment.parent == this._$parent)
          	this._$parent.removeChild(ce.comment)
          //	ce.comment.setVisible(false)
               var index:int = ces.indexOf(ce)
               ces.splice(index,1)
               ce.effect.stop()
              this.cf.dumpComment(ce.comment)
           // this.cf.dumpComment(ce.comment)
         //   trace(ce)
            // if(ces.length > this._$capacity)
          	// ces.shift(0,this._$capacity * 0.8)
       }
        private function clearAll():void
        {
        //	trace("clear" + ces.length)
        	//var tcs:Array = ces
        	for each(var cp:CEPair in ces)
        	{   
        		//cp.effect.removeEventListener(EffectEvent.EFFECT_END,eventUp)
        		cp.comment.setVisible(false)
        //		if(cp.comment.parent == this._$parent)
        	//	 this._$parent.removeChild(cp.comment)
        	//	cp.effect.stop()
        		//cf.dumpCommentEX(cp.comment)
            }
        	//geff.stop()
        	upss = new Array
        	upts = new Array
        	upbs = new Array
        	ces = new Array
        }
       //O(n+n*logn)
       private function getY(poses:Array,height:int):Number
       {
      
       	this.filterInvalid(poses)
       	var rs:Number = 10; 
         if(poses.length == 0)
	     return rs
	     poses.sortOn("top",16); 
	     if( UsedPos(poses[0]).top - 10 >= height)
	     return rs;
	     if(poses.length == 1)
     	 {
     //	 trace("y1:"+UsedPos(poses[0]).bottom)
              if(UsedPos(poses[0]).top < parent.height/2)
  	           return  UsedPos(poses[0]).bottom  
  	          else
  	           return  UsedPos(poses[0]).top - height;
          
  	    // return UsedPos(poses[0]).bottom;
  	     }

	    for(var j:int = 0;j < poses.length-1;j++)
           { 
           var current:UsedPos =  poses[j];
           var next:UsedPos = poses[j+1];
             if(next.top - current.bottom >= height)
             {
             	rs = current.bottom;
             	break;
             }
            if(j == poses.length-2)
            {
              if(parent.height - next.bottom >= height)	
              {
                rs = next.bottom;
             //   trace("y"+rs)
              } 
              else
              {
              	var rtop:Number = Math.random() * (parent.height - height)
         //       trace("randry"+rtop)	
                rs = rtop
              }  
            } 
       	 }      // trace("endy"+rs)
	     	     return rs
        }
        
        private function getRY(poses:Array,height:int):Number
        {
        	this.filterInvalid(poses)
        	var bottom:Number = parent.height - 10 
        	if(poses.length == 0)
        	 return bottom - height 
        	 poses.sortOn("bottom",16|2); 
        	if( bottom - UsedPos(poses[0]).bottom >= height)
  	        {
  	       // 	trace("ryfree :"+(bottom - height))
	         
	         return bottom - height; 
  	        }
            if(poses.length == 1)
            {
           //  trace("ry1 :"+(UsedPos(poses[0]).top - height))
              if(UsedPos(poses[0]).bottom > parent.height/2)
  	           return UsedPos(poses[0]).top - height;
  	          else
  	           return  UsedPos(poses[0]).bottom
  	        }
  	 
  	      for(var j:int = 0;j < poses.length-1;j++)
           {  
            var current:UsedPos =  poses[j];
            var next:UsedPos = poses[j+1];
             if(current.top - next.bottom >= height)
             {
             	bottom = current.top;
             	break;
             }
            if(j == poses.length-2)
            {
              if(next.top - height >= 0)
              {
              //	trace("ry-2 :"+ (next.top))	
                bottom = next.top;
              } 
               else
               {
         //      	 trace("ht"+height)	
              var top:Number = Math.random() * (parent.height - height)
                return top
      /*	trace("yrrd")
               	var top:Number
               while(true)
               	{
               		top = Math.abs(Math.random()* (parent.height - height))
               		trace(top < (parent.height - height))
               		if(top < (parent.height - height))
               		break
               	}
               	return top */
               }
            } 
       	 } 
       	// trace("ry = "+ (bottom - height))
            return bottom - height
        }
       private function getX(width:Number):Number
       {
       	return  parent.width - width >= 0 ? (parent.width - width)/2 : 0;
       }
        //O(n)
       private function filterInvalid(poses:Array):void
       {
      //  trace("before used pos length" + poses.length)
       	for(var i:int = 0; i<poses.length;i++)
	    { 
	     var tp:UsedPos = poses[i];	
	     if(!this.isUsedPosValid(tp))
	     {
	  	  var index:int = poses.indexOf(tp);
	  	  //trace(poses.length + " "+ time);
	       poses.splice(index,1);
	      // trace(poses.length);
	     }
	    }
  	 //   trace("used pos length" + poses.length)
       }
       private function isUsedPosValid(up:UsedPos):Boolean
       {
       	var sd:uint = this._$sduration/1000
       	var fd:uint = this._$fduration/1000
       	var pw:Number = this.parent.width/sd //part width
        
  /*       trace("jointime:---"+up.joinTime)
      	trace("pw"+pw)
       	trace("width"+up.width)
       	trace("currenttime"+ct)
       	trace("type"+up.type) */
       //	trace("fd"+fd)
       	//trace("sd"+sd)  
         if(up.type > 3)
       	{
       	 if(up.joinTime + fd -1 > ct)
       	 {
        //	 trace("true----------------------------------")
       	  return true
       	 }
        }
       	else 
       	{  
       	  for(var i:int=0;i< sd;i++)
       	  {
       	  	if(ct == up.joinTime + i)
       	  	{
       	  		if(up.width > pw * i)
       	  		{
       	  //	 	trace("true----------------------------------")
       	  		 return true
       	  		}
       	  	}
       	  }
        }
     //   trace("false----------------------------------")
       	return false
       }
   }
}