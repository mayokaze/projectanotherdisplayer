package org.tamaki.comment
{
	public class CommentFactory
	{
		private var _$coms:Array
		private var _$size:uint
        private var _$inUse:Array
        private var _$free:Array 
        public function CommentFactory(size:uint = 30)
        {
        	
        	this._$coms = new Array()
        	this._$size = size
        	for(var i:uint = 0; i < size;i++)
        	{
        		this._$coms.push(new Comment(i))
        	}
        	
        	this._$free = new Array()
        	for(var j:uint =  0;j < size;j++)
        	{
        		this._$free.push(j)
        	}
        	this._$inUse = new Array()
        //trace("used length" + this._$inUse.length)
        }
       public function instanceCom():Comment
       {
       	 if(this.freeSize > 0)
       	 {
       	 var index:uint = this._$free.shift()
       	 this._$inUse.push(index)
     //  	 trace("now get:---"+index)
       	 return this._$coms[index]
       	 }
       	 else
       	 return new Comment
       } 
       public function dumpComment(cmt:Comment):Boolean
       {
       	 // trace("dumping:"+ cmt.managedID)
       	 var index:int = cmt.managedID
       	 if(index < 0 || index >= this._$size)
       	  return false
       	 var uin:int = this._$inUse.indexOf(index)
       //	 trace("inuse:"+ uin)
       	 if(uin < 0)
       	  return false
        this._$inUse.splice(uin,1)
       	this._$free.push(index)
       	Comment(this._$coms[index]).resetAll()
     //  	trace("dumped:"+ index)
       	 return true
       }
       public function get size():uint
       {
       	return this._$size
       }
       public function get freeSize():uint
       {
        return this._$free.length
       }
   }
   
}