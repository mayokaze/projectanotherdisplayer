//invalid
package org.tamaki.util
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class HttpClient
	{
		private var loader:URLLoader = new URLLoader()
		
		
		public function HttpClient()
		{
			
		}
		public function loadURL(url:string):void
		{
			var request:URLRequest = new URLRequest(url)
		   try {
              loader.load(request);
            } catch (error:Error) {
                trace("Unable to load requested document.");
            }
            loader.addEventListener(Event.COMPLETE,onComplete);
            loader.addEventListener(IOErrorEvent.IO_ERROR,onError);
		}
		private function onError(eve:IOErrorEvent):void
		{
			trace(eve)
		}

	}
} 