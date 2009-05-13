package org.tamaki.net
{
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.IOErrorEvent;
	
	import org.tamaki.events.LoadEvent
	
	public class RegexSearcher extends EventDispatcher
	{   
		private var loader:URLLoader = new URLLoader()
		private var pattern:RegExp 
		
		public function RegexSearcher(reg:RegExp)
	    {
			this.pattern = reg
			this.configListener()
		}
		public function searchURL(url:String):void
		{
			var request:URLRequest = new URLRequest(url)
			loader.load(request);	
		}
		private function configListener():void
		{
			loader.addEventListener(Event.COMPLETE,onComplete)
			loader.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler)
		}
		private function ioErrorHandler(eve:IOError):void
        {
        	trace(eve)
        }
         private function onComplete(eve:Event):void
        {
         //  trace(loader.data)
           var find:Array = String(loader.data).match(this.pattern)
         //  trace(find[0])
          trace(find[1])
           this.dispatchEvent(new LoadEvent(LoadEvent.REGEX_COMPLETE,find))
        }

	}
}