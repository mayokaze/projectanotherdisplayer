package org.tamaki.util
{
	import org.tamaki.comment.CommentData;
	import org.tamaki.video.VideoInfo;
	import org.tamaki.net.InfoData;
	
	public class XMLParser
	{
		public function XMLParser()
		{
		}
		public static function createCDS(comments:XML):Array
		{
			//trace(comments.toString())
			var cds:Array = new Array()
			var datas:XMLList = comments.descendants("data");
		 for each(var data:XML in datas) 
		 {
		  var time:int = data.playTime;
		  var fontSize:Number = data.message.@fontsize;
		  var color:Number = data.message.@color;
		  var mode:uint	= data.message.@mode;
		  var text:String = data.message;
		  text = StringUtilEX.replaceAll(text,"/n","\n")
		  var prop:CommentData 	= new CommentData(mode,time,color,fontSize,text);
		  cds.push(prop);
		 // trace(prop.txt)
		  }
		 //trace(cds.length)
		 return cds
		}
		public static function createInfoData(video:XML):InfoData
		{
		   var tl:uint = video.timelength
		   var durls:XMLList = video.descendants("durl")
		   var ifs:Array = new Array()
		 for each(var durl:XML in durls) 
		 {
          var id:uint = durl.order
          var length:uint = durl.length
          var url:String = durl.url 
          var vi:VideoInfo = new VideoInfo(url,length,id)  
		  ifs.push(vi)
		 }	
		 return new InfoData(tl,ifs);
		}


	}
} 