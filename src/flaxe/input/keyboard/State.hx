package flaxe.input.keyboard;

class State
{
	public var key_list:flash.Vector<Bool>;
	
	public function new()
	{
		//this.obj = new Object();
		this.key_list = new flash.Vector<Bool>(256, true);
		
		for(key in this.key_list)
			key = false;
	}
	
	public inline function is_key_down(key:Int):Bool
	{
		//return flash.Boolean(key in this.obj);
		return this.key_list[key];
	}
	
	public inline function is_key_up(key:Int):Bool
	{
		//return !flash.Boolean(key in this.obj);
		return !this.key_list[key];
	}
	
	public inline function clone():State
	{
		var state:State = new State();
		
		//state.obj = this.obj;
		
		for(i in 0...this.key_list.length)
			state.key_list[i] = this.key_list[i];
		
		return state;
	}
	
	public inline function clear():Void
	{
		//this.obj = new Object();
		for(key in this.key_list)
			key = false;
	}
}
