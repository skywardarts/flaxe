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

		this.initialize();
		
		this.mc.stage.addEventListener(Event.RESIZE, this.resize);
	}
	
	public function initialize()
	{
		this.blank = new BitmapData(this.width, this.height, true, 0xFFFFFFFF);

		this.initialize_screen();
		 
		this.viewport = new graphics_viewport(0, 0, this.width, this.height);
		 
		this.display = new graphics_display(this.width, this.height, 0);
	}
	
	public function resize(e:Event):void
	{
		this.mc.removeChild(this.bmp);
		
		this.initialize();
	}
	
	public function get width():int
	{
		return this.mc.stage.stageWidth;
	}
	
	public function get height():int
	{
		return this.mc.stage.stageHeight;
	}
	
	public function initialize_screen():void
	{
		this.screen = new BitmapData(this.width, this.height, true, 0x00000000);

		this.bmp = new Bitmap(this.screen);
		this.bmp.smoothing = false;
		this.bmp.pixelSnapping = PixelSnapping.AUTO;
		//this.bmp.y = 0;
		//this.bmp.x = 0;
		//this.bmp.width = this.width;
		//this.bmp.height = this.height;
		
		this.mc.addChild(this.bmp);
	}

	public function draw():void
	{
		//var rect:Rectangle = new Rectangle(0, 0, this.width, this.height);
		
		//var bytes:ByteArray = this.display.screen.getPixels(this.display.screen.rect);
		//bytes.position = 0;
		
		//var v:Vector.<uint> = this.display.screen.getVector(this.display.screen.rect);
		this.display.screen.unlock();
		//trace(v.length);
		//this.screen.lock();
		//this.screen.setVector(this.display.screen.rect, this.display.screen.getVector(this.display.screen.rect));
		//this.display.clear();
		//this.screen.unlock();
		this.screen.copyPixels(this.display.screen, this.display.screen.rect, this.display.screen.rect.topLeft);
		//this.screen.setPixels(this.screen.rect, bytes);
		
		this.display.screen.lock();
		this.display.screen.fillRect(this.display.screen.rect, 0);
		
		
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
		//this.display.clear();
	}
}