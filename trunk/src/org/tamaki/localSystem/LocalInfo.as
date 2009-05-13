package org.tamaki.localSystem
{
	public class LocalInfo
	{
		private var _$url:String
		private var _$cds:Array
		public function LocalInfo(url:String,cds:Array)
		{
			this._$url = url
			this._$cds = cds
		}
		public function get url():String
		{
			return this._$url
		}
		public function get cds():Array
		{
			return this._$cds
		}

	}
}