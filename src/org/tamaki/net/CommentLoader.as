package org.tamaki.net
{   
	import flash.events.EventDispatcher;
	
	import org.tamaki.events.*;
	import org.tamaki.util.StringUtilEX;
	import org.tamaki.util.XMLParser;
	
	public class CommentLoader extends EventDispatcher
	{
		private var loader:XMLoader = new XMLoader()
 		public function CommentLoader()
		{
			
		}
		public function loadComment(vid:String):void
		{
			var url:String = "http://222.243.146.200/newflvplayer/xmldata/"+vid+"/comment_on.xml"
			//trace(url)
			loader.loadXML(url);
			loader.addEventListener(LoadEvent.XML_COMPLETE,onLoad)
		}
		private function onLoad(eve:LoadEvent):void
		{
			var cds:Array = XMLParser.createCDS(XML(eve.info))
		//	trace("loadComment + -------"+cds.length)
			this.dispatchEvent(new LoadEvent(LoadEvent.COMMENT_COMPLETE,cds))
		}

	}
}