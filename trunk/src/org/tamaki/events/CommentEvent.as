/*invalid*/
/*package org.tamaki.events
{
	import flash.events.Event;
	
	public class CommentEvent extends Event
	{
		private var _$info:Object;
        private var _$type:String;
		public static const EFFECT_COMPLETE:String = "effectComplete"

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
 }*/
}