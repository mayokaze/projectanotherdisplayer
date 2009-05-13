package org.tamaki.net
{
	import flash.events.EventDispatcher
	
	import org.tamaki.events.LoadEvent
	//import org.tamaki.video.VideoInfo
	import org.tamaki.util.XMLParser
	
	public class VideoLoader extends EventDispatcher
	{   
		private var loader:XMLoader = new XMLoader()
		public function VideoLoader()
		{
			
		}
		//load videoinfodata
		public function loadVideo(vid:String):void
		{
			var url:String = "http://v.iask.com/v_play.php?vid="+vid
			loader.loadXML(url);
			loader.addEventListener(LoadEvent.XML_COMPLETE,onLoad)
		}
		private function onLoad(eve:LoadEvent):void
		{
			
			var ifd:InfoData = XMLParser.createInfoData(XML(eve.info))
		//	trace("loadVideoLenght--------"+ifd.total)
			this.dispatchEvent(new LoadEvent(LoadEvent.VIDEO_COMPLETE,ifd));
		}
		

	}
}