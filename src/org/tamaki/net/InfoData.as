package org.tamaki.net
{
	public class InfoData
	{
		private var _$total:uint
		private var _$infos:Array
		public function InfoData(tl:uint,ifs:Array)
		{
		 this._$infos = ifs
		 this._$total = tl	
		}
		public function get total():uint
		{
			return this._$total
		}
		public function get infos():Array
		{
			return this._$infos
		}

	}
}