package flashx.graphics;

class Display
{
	//public var width(getWidth, never):Int;
	//public var height(getHeight, never):Int;
	
	//public var buffer:Int;
	
	public var width:Int;
	public var height:Int;
	//public var screen:flash.Vector<Int>;
	public var memory:de.polygonal.ds.mem.IntMemory;
	public var v1:flash.Vector<UInt>;
	
	public function new(width:Int, height:Int, ?buffer:Int = 0)
	{
		this.width = width;
		this.height = height;
		
		this.memory = null;
		
		trace("allocating" + width*height);
		
		
		var bmp:flash.display.BitmapData = new flash.display.BitmapData(width, height, false, 0x000000);
		this.v1 = bmp.getVector(bmp.rect);
		
		
		//this.data = new Array(width * height);
		
		//this.transparent = transparent;
		//this.repeat = repeat;
		
		//this.buffer = buffer;
		//this.screen = new flash.Vector<Int>(width * height, false);
		//this.screen = new flash.display.BitmapData(width + buffer, height + buffer, true, 0x00000000);
		
		//this.box = new flash.geom.Rectangle(0, 0, width, height);
		
		//this.set_background(background);
		
		//this.changed = new Array();
		
		//this.clear();
	}
	
	public inline function clear():Void
	{
		this.memory.fromVector(this.v1);
	}
	
	public inline function draw(display:Display, offset:flash.geom.Point):Void
	{
		if(offset.x >= 0 && offset.x <= (this.width - display.width) 
			&& offset.y >= 0 && offset.y <= (this.height - display.height))
		{
			var y1:Int = 0, y2 = display.height;
		
			while(y1 < y2)
			{
				var x1:Int = 0, x2 = display.width;
				
				while(x1 < x2)
				{
					var i1:Int = y1 * display.width + x1;
					
					//if(display.memory[i1] != undefined)
					//{
						var i2:Int = cast ((y1 + offset.y) * this.width + (x1 + offset.x));
						//trace("set " + i2 + " = " + i1);
						this.memory.set(i2, display.memory.get(i1));
						
						//this.changed.push(i2);
					//}
					
					++x1;
				}
				
				++y1;
			}
		}
	}
	
	public static inline function from_bitmap_data(bmp:flash.display.BitmapData):Display
	{
		trace("from bitmap " + bmp.width + "/" + bmp.height);
		var d:Display = new Display(bmp.width, bmp.height, 1);
		d.memory.fromVector(bmp.getVector(bmp.rect));
		
		return d;
	}
	
/*
	public inline function getWidth():Int
	{
		return this.screen.width;
	}
	
	public inline function getHeight():Int
	{
		return this.screen.height;
	}
	
	public function getX():Float
	{
		return this.box.x;
	}
	
	public function getY():Float
	{
		return this.box.y;
	}
	
	public function setBackground(background:Int):Int
	{
		if(background != this.background)
		{
			this.set_background(background);
		}
		
		return background;
	}
	
	function set_background(background:Int):Void
	{
		this.background = background;
		
		// create background byte array
		var bitmap:flash.display.BitmapData = new flash.display.BitmapData(this.width + this.buffer, this.height + this.buffer, this.transparent, this.background);
		
		bitmap.fillRect(bitmap.rect, this.background);
		
		trace(bitmap.rect);
		
		this.background_bytes = bitmap.getPixels(bitmap.rect);
	}
	
	public function getBackground():Int
	{
		return this.background;
	}
	
	public function set_vector_pixel(v:math_vector2, color:Int):Void
	{
		var index:Int = int(v.y * this.width + v.x);
	
		this.data[index] = color;
		
		this.changed.push(index);
	}
	
	public function set_pixel(x:Int, y:Int, color:Int):Void
	{
		if(x > (this.x + this.width)
		|| y > (this.y + this.height))
			throw new graphics_pixel_out_of_range_error();
		
		var index:Int = int(y * this.width + x);
	
		this.data[index] = color;
		
		this.changed.push(index);
	}
	
	public function get_pixel(x:Int, y:Int):Int
	{
		if(this.repeat)
		// normalize coordinates within range of repeated data
		{
			x = x % this.width;
			//while(x > this.width)
				//x -= this.width;
			y = y % this.height;
			//while(y > this.height)
				//y -= this.height;
		}
		
		var index:Int = int(y * this.width + x);
		
		return this.data[index];
	}
	
	
	public function clear():Void
	{
		//this.background_bytes.position = 0;
		
		//this.screen.fillRect(this.screen.rect, 0);
		//this.screen.setPixels(this.screen.rect, this.background_bytes);
		
		//this.data = new Array(this.width * this.height);
		//this.cache_data = new Array(this.width * this.height);
		//this.pixel_bytes = graphics_display.clone_byte_array(this.background_bytes, this.width, this.height, this.transparent);
	}
	
	public function copy(p:graphics_display):graphics_display
	{
		this.data = p.data.concat();
		this.box = new Rectangle(0, 0, p.box.width, p.box.height);
		this.background_ = p.background_;
		this.repeat = p.repeat;
		
		return this;
	}
	
	public function clone():graphics_display
	{
		return (new graphics_display(this.width, this.height, 0)).copy(this);
	}
	
	public function getBytes():ByteArray
	{
		if(this.changed.length > 0)
		{
			for (index in this.changed)
			{
				var color:Int = this.data[index];

				if(color != this.cache_data[index])
				{
					//trace(index*4+0, index*4+1, index*4+2, index*4+3);
					
					//var offset:int = this.transparent ? 1 : 0;
					
					//if(this.transparent)

					this.pixel_bytes[index*4+0] = color >> 24 & 0xFF; // extract alpha
					this.pixel_bytes[index*4+1] = color >> 16 & 0xFF; // extract red
					this.pixel_bytes[index*4+2] = color >> 8 & 0xFF; // extract green
					this.pixel_bytes[index*4+3] = color & 0xFF; // extract blue
				}
			}
			
			// reset changed array
			this.changed = new Array();
			
			// save cached data for comparison later
			this.cache_data = this.data.concat();
		}
		
		this.pixel_bytes.position = 0;
		
		return this.pixel_bytes;
	}*/
	
	//public function copy_bitmapdata(display:flash.display.BitmapData, rect:flash.geom.Rectangle):Void
	//{
		//var v:Vector.<uint> = display.getVector(rect);
		
		//var bytes:ByteArray = display.getPixels(display.rect);
		//bytes.position = 0;
		
		
		
		//this.screen.setVector(new Rectangle(this.buffer/2+rect.x, this.buffer/2+rect.y, display.rect.width, display.rect.height), display.getVector(display.rect));
	//}
	/*
	public function copy_graphics_display(display:graphics_display, offset:Point):Void
	{
		//if(offset.x >= 0 && offset.y >= 0 && offset.x <= this.width && offset.y <= this.height)
		//{
			var box:Rectangle = display.box;
			
			var y1:Int = box.y, y2:Dynamic = int(box.y + box.height);
			while (y1 < y2)
			{
				var x1:Int = box.x, x2:Dynamic = int(box.x + box.width);
				while (x1 < x2)
				{
					var i1:Int = int(y1 * box.width + x1);
					
					if(display.data[i1] != undefined)
					{
						var i2:Int = int((y1 + offset.y) * this.width + (x1 + offset.x));
						
						this.data[i2] = display.data[i1];
						
						this.changed.push(i2);
					}
					++x1;
				}
				++y1;
			}
		//}
	}
	
	public static function clone_byte_array(bytes:ByteArray, width:Int, height:Int, ?transparent:Bool = false):ByteArray
	{
		var bitmap:BitmapData = new BitmapData(width, height, transparent);
		
		bytes.position = 0;
		bitmap.setPixels(bitmap.rect, bytes);
		
		return bitmap.getPixels(bitmap.rect);
	}
	
	public static function convert_bitmap_data(bitmap_data:BitmapData):graphics_display
	{
		//var byteArray:ByteArray = bitmapData.getPixels(bitmapData.rect);
		var width:Int = bitmap_data.rect.width;
		var height:Int = bitmap_data.rect.height;
		
		var display:graphics_display = new graphics_display(width, height, 0);
		
		for(x in 0...width)
		{
			for(y in 0...height)
			{
				display.set_pixel(x, y, bitmap_data.getPixel(x, y));
			}
		}
		
		return display;
	}
	
	public function equals(p:graphics_display):Bool
	{
		if(this.repeat != p.repeat
		|| this.background != p.background)
			return false;
		
		return true;
	}
	
	public var data:Array<Dynamic>;
	var cache_data:Array<Dynamic>;
	
	var pixel_bytes:ByteArray;
	var background_bytes:ByteArray;
	
	var background:Int;
	
	//public var transparent:Bool;
	//public var repeat:Bool;
	
	//public var box:Rectangle;
	
	var changed:Array<Dynamic>;*/
	
	//public var screen:flash.display.BitmapData;
	
	//var cache:flashx.graphics.Display;
}
