package org.tamaki.events
{
	import flash.events.Event;
	
	public class LoadEvent extends Event
	{
		private var _$info:Object;
        private var _$type:String;
		public static const XML_COMPLETE:String = "loadComplete"// load xml
		public static const VIDEO_COMPLETE:String = "videoComplete"//load video
		public static const COMMENT_COMPLETE:String = "commentComplete"//load comment
		public static const REGEX_COMPLETE:String = "regexComplete"//search by regex and url
		public static const MULTI_VIDEO_COMPLETE:String = "multiVideoComplete"//load multi part video 
        public static const MULTI_COMMENT_COMPLETE:String = "multiCommentComplete"//load multi part comment
        public static const MULTI_PART_COMPLETE:String = "multiPartComplete"//load multi part
        public static const LOACL_LOAD_COMPLETE:String = "loaclLoadComplete"//load local file
        
        public function LoadEvent(param1:String, param2:Object = 0)
        {
            super(param1);
            _$type = param1;
            _$info = param2;
            return;
        }// end function

		override public function clone() : Event
        {
            return new NSEvent(_$type, _$info);
        }// end function

        public function get info():Object
        {
            return _$info;

	    }
 }
}