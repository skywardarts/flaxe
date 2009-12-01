import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.display.Stage;
import flash.display.Sprite;
import flash.display.PixelSnapping;
import flash.display.MovieClip;
import flash.geom.Point;
import flash.events.EventDispatcher;

class graphics_device
{
	public var screen:BitmapData;
	public var bmp:Bitmap;
	public var viewport:graphics_viewport;
	//public var filter:IFilter;
	public var display:graphics_display;
	public var blank:BitmapData;
	
	private var mc:MovieClip;

	public function graphics_device(mc:MovieClip, display_width:int, display_height:int, viewport_width:int, viewport_height:int)
	{
		this.mc = mc;

		this.initialize(display_width, display_height, viewport_width, viewport_height);
	}
	
	public function initialize(display_width:int, display_height:int, viewport_width:int, viewport_height:int):void
	{
		this.resize_display(display_width, display_height, false);
		
		this.resize_viewport(viewport_width, viewport_height, true);
	}
	
	public function resize_display(width:int, height:int, rescale:Boolean = true):void
	{
		this.display = new graphics_display(width, height, 0);

		this.screen = new BitmapData(width, height, true, 0x00000000);
		
		if(this.bmp != null)
			this.mc.removeChild(this.bmp);
		
		this.bmp = new Bitmap(this.screen);
		this.bmp.smoothing = false;
		this.bmp.pixelSnapping = PixelSnapping.ALWAYS;
		
		if(rescale)
			this.rescale();
		
		this.mc.addChild(this.bmp);
	}
	
	public function resize_viewport(width:int, height:int, rescale:Boolean = true):void
	{
		this.viewport = new graphics_viewport(0, 0, width, height);

		if(rescale)
			this.rescale();
	}
	
	public function rescale():void
	{
		this.bmp.scaleX = this.viewport.width / this.display.width;
		this.bmp.scaleY = this.viewport.height / this.display.height;
	}
	
	public function get width():int
	{
		return this.display.width;
	}
	
	public function get height():int
	{
		return this.display.height;
	}
	
	public function draw():void
	{
		this.display.screen.unlock();

		// draw method 1
		//this.screen.lock();
		//this.screen.setVector(this.screen.rect, this.display.screen.getVector(this.display.screen.rect));
		//this.screen.unlock();
		
		// draw method 2
		this.screen.copyPixels(this.display.screen, this.screen.rect, this.display.screen.rect.topLeft);

		this.display.screen.lock();
		this.clear(0); // temp(daemn) not gonna need this when using tiles
	}
	
	public function clear(color:uint):void
	{
		this.display.screen.fillRect(this.display.screen.rect, color);
		
		// clear method 1
		//this.screen = new BitmapData(800, 600, false, 0xFFFFFF);
		
		// clear method 2
		//this.screen.setPixels(this.drawer.rect, this.blank.getPixels(this.blank.rect));
		
		// clear method 3
		//this.screen.copyPixels(this.blank, this.drawer.rect, new Point(0, 0));
		
		// clear method 4
		//this.screen.fillRect(this.drawer.rect, 0xFFFFFF);
		
		// clear method 5
		//this.savedBA.position = 0;

		//this.screen.setPixels(this.drawer.rect, this.savedBA);

		// clear method 6
		//for (var x : int = 0; x < 800; x++)
			//for (var y : int = 0; y < 600; y++)
				//this.drawer.setPixel(x, y, 0xFFFFFF);
				
		// clear method supreme
		//this.display.clear();
	}
}