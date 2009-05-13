package org.tamaki.net
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.tamaki.events.LoadEvent;
	public class XMLoader extends EventDispatcher
    {
        private var loader:URLLoader = new URLLoader()
        private var xml:XML
		public function XMLoader()
		{
			this.configListener()
		}
		private function configListener():void
		{
			loader.addEventListener(Event.COMPLETE,onComplete)
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler)
		}
		 
		public  function loadXML(url:String):void
		{
			var request:URLRequest = new URLRequest(url)
			loader.load(request);	
		}
        private function ioErrorHandler(eve:IOErrorEvent):void
        {
        	trace(eve)
        }
        private function onComplete(eve:Event):void
        {
        	try {
                    xml = new XML(loader.data);
                    this.dispatchEvent(new LoadEvent(LoadEvent.XML_COMPLETE,xml))   
                } catch (e:TypeError) {
                    trace("Could not parse the XML file.");
                }
        }
        

	}
}