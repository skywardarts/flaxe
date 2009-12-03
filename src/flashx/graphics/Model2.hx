package flashx.graphics;

class Model2
{
	public var x(getX, setX):Int;
	public var y(getY, setY):Int;
	public var width(getWidth, never):Int;
	public var height(getHeight, never):Int;
	public var changed(getChanged, setChanged):Bool;
	
	public var display:flashx.graphics.Display;
	
	public function new()
	{
		this.display = new flashx.graphics.Display(14, 19);
		this.position = flashx.math.Vector2.getZero();
		this.rotation = flashx.math.Vector2.getZero();
		
		//new avatar(0, 0); //graphics_display.convert_bitmap_data(new avatar(0, 0)); 
	}

	public function update(time:flashx.core.Timestamp):Void
	{

	}
	
	public function draw(device:flashx.graphics.Device):Void
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
	

	public inline function getX():Int
	{
		return this.position.x;
	}
	
	public inline function setX(x:Int):Int
	{
		this.position.x = x;
		
		return x;
	}
	
	public inline function getY():Int
	{
		return this.position.y;
	}
	
	public inline function setY(y_:Int):Int
	{
		this.position.y = y;
		
		return y;
	}
	
	public inline function getWidth():Int
	{
		return this.display.width;
	}
	
	public inline function getHeight():Int
	{
		return this.display.height;
	}
	
	public function getChanged():Bool
	{
		if(this.position.changed)
			return true;
		
		if(this.rotation.changed)
			return true;
		
		return false;
	}
	
	public function setChanged(c:Bool):Bool
	{
		this.position.changed = c;
		this.rotation.changed = c;
		
		return c;
	}
	
	public inline function clone():Model2
	{
		return (new Model2()).copy(this);
	}
	
	public inline function copy(model:Model2):Model2
	{
		this.position = model.position;
		this.rotation = model.rotation;
		
		return this;
	}
	
	public var position:flashx.math.Vector2;
	public var rotation:flashx.math.Vector2;
}
