dynamic class keyboard_state
{
	public function keyboard_state()
	{
		for(var i = 0, l = 255; i < l; ++i)
			this[i] = false;
	}
	
	public function is_key_down(key:int)
	{
		return this[key];
	}
	
	public function is_key_up(key:int)
	{
		return !this[key];
	}
	
	public function clone()
	{
		var state:keyboard_state = new keyboard_state();
		
		for(var i = 0, l = 255; i < l; ++i)
			state[i] = this[i];
		
		return state;
	}
	
	public function clear()
	{
		for(var i = 0, l = 255; i < l; ++i)
			this[i] = false;
	}
}