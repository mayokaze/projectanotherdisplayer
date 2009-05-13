package org.tamaki.net
{
	public class MultiInfoData
	{   
		private var _$ifd:InfoData
		private var _$cds:Array 
		public function MultiInfoData(ifd:InfoData,cds:Array)
		{
			this._$ifd = ifd
			this._$cds = cds
		}
		public function get ifd():InfoData
		{
			return this._$ifd
		}
		public function get cds():Array
		{
			return this._$cds
		}

	}
}