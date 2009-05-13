package org.tamaki.comment
{  
     import org.tamaki.util.StringUtilEX;
     public class CommentData
	{   
        private var _$txt:String;
		public var mode:uint;
		public var time:int;
		public var color:uint;
		private var _$fontSize:uint;
	//	private var _$textWidth:Number;
	//	private var _$textHeight:Number;
		public function CommentData(mode:uint,time:int,color:uint,fsize:uint,txt:String)
		{
            this.mode = mode;
			this.time = time;
			this.color = color;
			this._$fontSize = fsize;
			this._$txt = txt;
		//	this._$textWidth = StringUtil.getTextWidth(this._$txt,this.fontSize)
		//	this._$textHeight = this._$txt.split("\n") .length * this.fontSize * 1.4
		}
	/*	public function get width():Number
		{
			return this._$textWidth
		}
		public function get height():Number
		{
		   return _$textHeight
		}*/
		public function set fontSize(fs:uint):void
		{
			this._$fontSize = fs
		//	this._$textWidth = StringUtil.getTextWidth(this._$txt,this.fontSize)
	   //	this._$textHeight = this._$txt.split("\n") .length * this.fontSize * 1.2
		}
		public function get fontSize():uint
		{
			return this._$fontSize
		}
		public function set txt(txt:String):void
		{
			this._$txt = txt
		//    this._$textWidth = StringUtil.getTextWidth(this._$txt,this.fontSize)
			//this._$textHeight = this._$txt.split("\n") .length * this.fontSize * 1.2
		}
		public function get txt():String
		{
			return this._$txt
		}
	 }

}