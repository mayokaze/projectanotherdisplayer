package org.tamaki.localSystem
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;
	import flash.net.FileFilter;
	
	import org.tamaki.util.XMLParser;
	import org.tamaki.events.LoadEvent
	
	public class LocalLoader extends EventDispatcher
	{
		public function LocalLoader()
		{
		}
		public function openFile():void
		{
			var openFileFilter:FileFilter = new FileFilter("flv-application/octet-stream","*.flv");
		    var file:File = File.desktopDirectory
		    file.browseForOpen("open",[openFileFilter]);
		    file.addEventListener(Event.SELECT,onOpen); 
		}
		private function onOpen(eve:Event):void
		{
		 var cds:Array
	     var flvUrl:String = eve.target.nativePath;
  	     var xmlUrl:String = flvUrl.substring(0,flvUrl.length - 3) + "xml";
  	     var file:File = new File(xmlUrl);
		  if(file.exists)
		  {
           var fileStream:FileStream = new FileStream();
		   fileStream.open(file,FileMode.READ); 
		   var xmlData:XML = XML(fileStream.readUTFBytes(fileStream.bytesAvailable));
		   cds = XMLParser.createCDS(xmlData)
		   fileStream.close();
		  }
		  else
		   cds = new Array
		 var lfo:LocalInfo = new LocalInfo(flvUrl,cds)
		 this.dispatchEvent(new LoadEvent(LoadEvent.LOACL_LOAD_COMPLETE,lfo))   
		}

	}
}