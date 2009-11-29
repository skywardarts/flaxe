dynamic class keyboard_state
{
	public var obj:Object;
	
	public function keyboard_state()
	{
		this.obj = new Object();
		//for(var i = 0, l = 255; i < l; ++i)
			//this[i] = false;
	}
	
	public function is_key_down(key:int):Boolean
	{
		return Boolean(key in this.obj);
		//return this[key];
	}
	
	public function is_key_up(key:int):Boolean
	{
		return !Boolean(key in this.obj);
		//return !this[key];
	}
	
	public function clone():keyboard_state
	{
		var state:keyboard_state = new keyboard_state();
		
		state.obj = this.obj;
		
		//for(var i = 0, l = 255; i < l; ++i)
			//state[i] = this[i];
		
		return state;
	}
	
	public function clear():void
	{
		this.obj = new Object();
		//for(var i = 0, l = 255; i < l; ++i)
			//this[i] = false;
	}
}