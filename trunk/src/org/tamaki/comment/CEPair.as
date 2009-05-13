package org.tamaki.comment
{

	import mx.effects.Effect;
	
	public class CEPair
	{   
	//	private var _$parent:UIComponent
        private var _$comment:Comment
		private var _$effect:Effect
		public function CEPair(cmt:Comment,eff:Effect)
		{
		//	this._$parent = parent
			this._$comment = cmt
			this._$effect = eff
		}
		public function get comment():Comment
		{
			return this._$comment
		}
		public function get effect():Effect
		{
			return this._$effect
		}
	/*	public function realse():void
		{
			this._$comment = null
			this._$effect = null
		}
	     
	/*	public function setPos(parent:UIComponent,x:Number,y:Number):void
		{
			parent.addChild(_$comment)
			_$comment.x = x
			_$comment.y = y
        }*/
	/*	public function playM(x:Number,y:Number):void
		{
			var mv:Move = _$effect as Move 
			_$parent.addChild(_$comment)
			_$comment.setVisible(true)
			_$effect.addEventListener(EffectEvent.EFFECT_END,onEnd)
			_$effect.play(_$comment)
		}
		public function pause():void
		{
			_$effect.pause(_$comment)
		}
        private function onEnd(eve:EffectEvent):void
        {
        	_$comment.setVisible(false)
        	_$comment = null
        	_$effect = null
        	this.dispatchEvent(new CommentEvent(CommentEvent.EFFECT_COMPLETE))
        }  */
	}
}