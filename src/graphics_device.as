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

	public function graphics_device(mc:MovieClip)
	{
		this.mc = mc;

		this.blank = new BitmapData(800, 600, false, 0xFFFFFF);
		//this.blank.smoothing = false;
		//this.blank.pixelSnapping = PixelSnapping.AUTO;
		
		this.initialize_screen();
		 
		this.viewport = new graphics_viewport(0, 0, 800, 600);
		 
		this.display = new graphics_display(800, 600);
	}
	
	public function initialize_screen():void
	{
		this.screen = new BitmapData(800, 600, false, 0xCCCCCC);

		this.bmp = new Bitmap(this.screen);
		this.bmp.smoothing = false;
		this.bmp.pixelSnapping = PixelSnapping.AUTO;
		
		this.mc.addChild(this.bmp);
	}

	public function draw():void
	{
		//this.graphics.beginBitmapFill(this.drawer);
		//this.graphics.drawRect(0, 0, 800, 600);
		//this.graphics.endFill();
		this.screen.setPixels(this.screen.rect, this.display.bytes);
	}
	
	public function clear(colour:uint):void
	{
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
		this.display.clear();
	}
}