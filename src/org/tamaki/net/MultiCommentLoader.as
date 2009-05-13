package org.tamaki.net
{   
	import flash.events.EventDispatcher;
	
	import org.tamaki.events.LoadEvent;
	import org.tamaki.util.ArrayUtil;
	
	public class MultiCommentLoader extends EventDispatcher
	{   
		private var cl:CommentLoader = new CommentLoader
		private var cdss:Array = new Array //duality array
		private var _$vids:Array  = new Array
		public function MultiCommentLoader()
		{
			cl.addEventListener(LoadEvent.COMMENT_COMPLETE,onLoad)
		}
		//LOAD MULTI XML FILE,YOU MUST ENSURE THAT THE VID LIST HAS BEEN SORTED ALREADY
		public function loadComments(vids:Array):void
		{
			ArrayUtil.deepCopy(vids,this._$vids)
		//	trace("in mv"+vids[0])
		 //   trace("in mv"+vids[1])
			if(this._$vids.length > 0)
			 cl.loadComment(this._$vids.shift())
		}
		public function reset():void
		{
			this.cdss = new Array
			this._$vids = new Array
		}
		private function onLoad(eve:LoadEvent):void
		{
			//trace("mc once")
			cdss.push(eve.info)
			if(this._$vids.length > 0)
			{
			// trace("next cmt")
			 cl.loadComment(this._$vids.shift())
			}
			else
			{
			// trace("mcload-------------"+ cdss.length)
			 this.dispatchEvent(new LoadEvent(LoadEvent.MULTI_COMMENT_COMPLETE,cdss))
			}
		}

	}
}