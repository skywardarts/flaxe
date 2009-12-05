package flaxe.graphics;

class Object extends flaxe.Object
{
	public var x(get_x, set_x):Int;
	public var y(get_y, set_y):Int;
	public var width(get_width, never):Int;
	public var height(get_height, never):Int;
	public var changed(get_changed, set_changed):Bool;
	
	public var display:flaxe.graphics.Display;
	
	public function new()
	{
		this.display = new flaxe.graphics.Display(14, 19);
		this.position = flaxe.math.Vector2.getZero();
		this.rotation = flaxe.math.Vector2.getZero();
	}

	public function update(time:flaxe.core.Timestamp):Void
	{

	}
	
	public function draw(device:flaxe.graphics.Device):Void
	{
		if(this.display.memory == null)
		{
			var bmp:flash.display.BitmapData = new flash.display.BitmapData(14, 19, false, 0xFFFFFF);
			    trace("USED: " + de.polygonal.ds.mem.MemoryManager.getUsedBytes());
    trace("FREE: " + de.polygonal.ds.mem.MemoryManager.getFreeBytes());
try {
			this.display.memory = de.polygonal.ds.mem.MemoryManager.getIntMemory(this.display.width*this.display.height);
} catch(unknown:Dynamic) {
    trace("USED: " + de.polygonal.ds.mem.MemoryManager.getUsedBytes());
    trace("FREE: " + de.polygonal.ds.mem.MemoryManager.getFreeBytes());
     //de.polygonal.ds.mem.MemoryManager.forceDefragment();
	
    trace("Unknown exception : "+Std.string(unknown));

}
try{
	trace(bmp);
	trace(bmp.rect);
	var v:flash.Vector<UInt> = bmp.getVector(bmp.rect);
			this.display.memory.fromVector(v);
			trace("Z");
} catch(unknown:Dynamic) {
    trace("Unknown exception2 : "+Std.string(unknown));
}

			    trace("USED: " + de.polygonal.ds.mem.MemoryManager.getUsedBytes());
    trace("FREE: " + de.polygonal.ds.mem.MemoryManager.getFreeBytes());
		}
	}
	

	public inline function get_x():Int
	{
		return this.position.x;
	}
	
	public inline function set_x(x:Int):Int
	{
		this.position.x = x;
		
		return x;
	}
	
	public inline function get_y():Int
	{
		return this.position.y;
	}
	
	public inline function set_y(y_:Int):Int
	{
		this.position.y = y;
		
		return y;
	}
	
	public inline function get_width():Int
	{
		return this.display.width;
	}
	
	public inline function get_height():Int
	{
		return this.display.height;
	}
	
	public inline function get_changed():Bool
	{
		if(this.position.changed)
			return true;
		
		if(this.rotation.changed)
			return true;
		
		return false;
	}
	
	public inline function set_changed(c:Bool):Bool
	{
		this.position.changed = c;
		this.rotation.changed = c;
		
		return c;
	}
	
	public inline function clone():Model2
	{
		return new Object.copy(this);
	}
	
	public inline function copy(model:Model2):Model2
	{
		this.position = model.position;
		this.rotation = model.rotation;
		
		return this;
	}
	
	public var position:flaxe.math.Vector2;
	public var rotation:flaxe.math.Vector2;
}
