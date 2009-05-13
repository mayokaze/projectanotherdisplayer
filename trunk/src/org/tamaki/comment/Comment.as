package org.tamaki.comment
{
	import mx.controls.Text;
	
	import org.tamaki.util.StringUtilEX;
	

	public class Comment extends Text
	{

		//private var _$commentData:CommentData;
		private var _$ManagedID:int
        private var _$time:int
		private var _$mode:uint
		private var _$fsize:Number
	    
	    public function Comment(mid:int = -1)
		{  
	 	  super()	
	 	  this._$ManagedID = mid
        }

        public function setComment(commentData:CommentData):void
        {
  		  this.setStyle("color",commentData.color);
		  this.setStyle("fontSize",commentData.fontSize);
	      this.setStyle("fontWeight","bold");
	      this._$time = commentData.time;
          this._$mode = commentData.mode;
          this._$fsize = commentData.fontSize
          this.setTextEX(commentData.txt)
	     
	   //   trace("height"+this.height)
	    //  trace("txt"+this.text)
	       //this.height = this.textHeight
	      // this.width = this.textWidth
		/* var fmt:TextFormat = new TextFormat();
		  fmt.color = commentData.color
          fmt.font = "黑体"
          fmt.f*/
	   //   this.setVisible(true)     	
        }
        public function resetAll():void
        {
        	this.text = ""
            this.setStyle("color",16777215);
            this.setStyle("fontSize",25);
            this._$fsize = 0
            this.height = 0
            this.width = 0
        	this._$time = -1
        	this._$mode = 0
        //	this.setVisible(false)
        }   
         public function get managedID():int
        {
        	return this._$ManagedID
        }
     /*   public function get swidth():Number
        {
        	return this._$swidth
        }     
        public function get sheight():Number
        {
        	return this._$sheight
        }*/
        public function setTextEX(txt:String):void
        {
          this.text = txt
	      this.height = StringUtilEX.getTextHeight(this.text,this._$fsize)
	      this.width = StringUtilEX.getTextWidth(this.text,this._$fsize)
        	
        }

        public function get time():int
        {
        	return this._$time
        }
        public function get mode():uint
        {
        	return this._$mode
        }
   }
}