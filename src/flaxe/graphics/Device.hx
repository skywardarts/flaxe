package flaxe.graphics;

class Device
{
	public var width(getWidth, never):Int;
	public var height(getHeight, never):Int;
	
	public var v1:flash.Vector<UInt>;
	public function new(mc:flash.display.MovieClip, display_width:Int, display_height:Int, viewport_width:Int, viewport_height:Int)
	{
		this.mc= mc;
		//this.mc = new flash.display.MovieClip();
		//this.mc.x = 0;
		//this.mc.y = 0;
		////this.mc.cacheAsBitmap = true;

		//mc.addChild(this.mc);

this.v1 = new flash.Vector<UInt>(display_width*display_height);

		this.initialize(display_width, display_height, viewport_width, viewport_height);
	}
	
	public function initialize(display_width:Int, display_height:Int, viewport_width:Int, viewport_height:Int):Void
	{
		this.resize_display(display_width, display_height, false);
		
		this.resize_viewport(viewport_width, viewport_height, true);
	}
	
	public function resize_display(width:Int, height:Int, ?rescale:Bool = true):Void
	{
		this.display = new flaxe.graphics.Display(width, height);

		this.screen = new flash.display.BitmapData(width, height, false, 0x000000);
		
		if(this.bmp != null)
			this.mc.removeChild(this.bmp);
		
		this.bmp = new flash.display.Bitmap(this.screen);
		this.bmp.smoothing = false;
		this.bmp.pixelSnapping = flash.display.PixelSnapping.ALWAYS;
		
		if(rescale)
			this.rescale();
		
		this.mc.addChild(this.bmp);
	}
	
	public function resize_viewport(width:Int, height:Int, ?rescale:Bool = true):Void
	{
		this.viewport = new flaxe.graphics.Viewport(0, 0, width, height);

		if(rescale)
			this.rescale();
	}
	
	public function rescale():Void
	{
		this.bmp.scaleX = this.viewport.width / this.display.width;
		this.bmp.scaleY = this.viewport.height / this.display.height;
	}
	
	public function getWidth():Int
	{
		return this.display.width;
	}
	
	public function getHeight():Int
	{
		return this.display.height;
	}
	
	public function draw():Void
	{
		if(this.display.memory == null)
		{
			this.display.memory = de.polygonal.ds.mem.MemoryManager.getIntMemory(this.display.width*this.display.height);
		}
		
		//this.display.screen.unlock();
this.screen.unlock();
		// draw method 1
		//this.screen.lock();
		//this.screen.setVector(this.screen.rect, this.display.screen.getVector(this.display.screen.rect));
		//this.screen.unlock();
		
		
		//var v1:flash.Vector<Int> = this.display.screen.getVector(this.display.screen.rect);
		//;
		//for(i in 0...v1.length)
		//{
		//	this.memory.set(i, v1[i]);

		//}
		
//this.screen.setVector(this.screen.rect, this.memory.toVector(this.memory.fromVector(this.display.screen.getVector(this.display.screen.rect))));

		

		


		this.screen.setVector(this.screen.rect, this.display.memory.toVector(this.v1));
		//this.screen.copyPixels(this.display.screen, this.screen.rect, this.display.screen.rect.topLeft);
this.screen.lock();
		//this.display.screen.lock();
		this.clear(0); // temp(daemn) not gonna need this when using tiles
	}
	
	public function clear(color:UInt):Void
	{
		this.display.clear();
		//this.screen.fillRect(this.screen.rect, color);
	}
	
	public var screen:flash.display.BitmapData;
	public var bmp:flash.display.Bitmap;
	public var viewport:flaxe.graphics.Viewport;
	//public var filter:IFilter;
	public var display:flaxe.graphics.Display;
	public var blank:flash.display.BitmapData;
	
	public var mc:flash.display.MovieClip;
}
