import flash.display.*;
import flash.utils.*;
import flash.geom.*;

class graphics_display
{
	public var buffer:int;
	
	public function graphics_display(width:int, height:int, buffer:int, transparent:Boolean = false, background_:int = 0, repeat:Boolean = false)
	{
		this.data = new Array(width * height);
		
		this.transparent = transparent;
		this.repeat = repeat;
		
		this.buffer = buffer;
		
		this.screen = new BitmapData(width + buffer, height + buffer, false, 0xCCCCCC);
		
		this.box = new Rectangle(0, 0, width, height);
		
		this.set_background(background_);
		
		this.changed = new Array();
		
		this.clear();
	}

	public function get width():Number
	{
		return this.box.width;
	}
	
	public function get height():Number
	{
		return this.box.height;
	}
	
	public function get x():Number
	{
		return this.box.x;
	}
	
	public function get y():Number
	{
		return this.box.y;
	}
	
	public function set background(background_:int):void
	{
		if(background_ != this.background_)
		{
			this.set_background(background_);
		}
	}
	
	private function set_background(background_:int):void
	{
		this.background_ = background_;
		
		// create background byte array
		var bitmap:BitmapData = new BitmapData(this.width + this.buffer, this.height + this.buffer, this.transparent, this.background_);
		
		bitmap.fillRect(bitmap.rect, this.background_);
		trace(bitmap.rect);
		this.background_bytes = bitmap.getPixels(bitmap.rect);
	}
	
	public function get background():int
	{
		return this.background_;
	}
	
	public function set_vector_pixel(v:math_vector2, color:int):void
	{
		var index:int = int(v.y * this.width + v.x);
	
		this.data[index] = color;
		
		this.changed.push(index);
	}
	
	public function set_pixel(x:int, y:int, color:int):void
	{
		if(x > (this.x + this.width)
		|| y > (this.y + this.height))
			throw new graphics_pixel_out_of_range_error();
		
		var index:int = int(y * this.width + x);
	
		this.data[index] = color;
		
		this.changed.push(index);
	}
	
	public function get_pixel(x:int, y:int):int
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
		
		var index:int = int(y * this.width + x);
		
		return this.data[index];
	}
	
	
	public function clear():void
	{
		this.background_bytes.position = 0;
		
		this.screen.setPixels(this.screen.rect, this.background_bytes);
		
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
	
	public function get bytes():ByteArray
	{
		if(this.changed.length > 0)
		{
			for each(var index:int in this.changed)
			{
				var color:int = this.data[index];

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
	}
	
	public function copy_bitmapdata(display:BitmapData, rect:Rectangle):void
	{
		var bytes:ByteArray = display.getPixels(display.rect);
		bytes.position = 0;
		
		this.screen.setPixels(new Rectangle(this.buffer/2+rect.x, this.buffer/2+rect.y, rect.width, rect.height), bytes);
	}
	
	public function copy_graphics_display(display:graphics_display, offset:Point):void
	{
		//if(offset.x >= 0 && offset.y >= 0 && offset.x <= this.width && offset.y <= this.height)
		//{
			var box:Rectangle = display.box;
			
			for(var y1:int = box.y, y2 = int(box.y + box.height); y1 < y2; ++y1)
			{
				for(var x1:int = box.x, x2 = int(box.x + box.width); x1 < x2; ++x1)
				{
					var i1:int = int(y1 * box.width + x1);
					
					if(display.data[i1] != undefined)
					{
						var i2:int = int((y1 + offset.y) * this.width + (x1 + offset.x));
						
						this.data[i2] = display.data[i1];
						
						this.changed.push(i2);
					}
				}
			}
		//}
	}
	/*
	public function copy_pixels(source:graphics_display, box:Rectangle, point:Point):void
	{
		var offset:int = int(point.y * this.width + point.x);

		for(var i:int = int(box.y * box.width + box.x), l = int(box.height * box.width + box.width); i < l; ++i)
		{
			this.data[int(i + offset)] = source[i];
		}
	}
	
	public function copy_pixels_graphics_display(source_pixels:graphics_display, source_box:Rectangle, dest_point:Point = null):void
	{
		var offset:int = int(dest_point.y * this.width + dest_point.x);
		
		for(var i:int = int(source_box.y * source_box.width + source_box.x), l = int(source_box.height * source_box.width + source_box.width); i < l; ++i)
		{
			var index:int = int(i + offset);
			
			this.data[index] = source_pixels[i];
			
			this.changed.push(index);
		}
	}
	
	public function draw(bitmap:BitmapData, point:Point):void
	{
		var offset:int = int(point.y * this.width + point.x);

		var box:Rectangle = bitmap.rect;
		
		var source:ByteArray = bitmap.getPixels(box);

		for(var i:int = int(box.y * box.width + box.x), l = int(box.height * box.width + box.width); i < l; ++i)
		{
			var index:int = int(i + offset);
			trace(source[i]);
			this.data[index] = source[i];
			
			this.changed.push(index);
		}
	}*/
	
	/**
	* ByteArray clone method (5x faster than loop)
	*/
	public static function clone_byte_array(bytes:ByteArray, width:int, height:int, transparent:Boolean = false):ByteArray
	{
		var bitmap:BitmapData = new BitmapData(width, height, transparent);
		
		bytes.position = 0;
		bitmap.setPixels(bitmap.rect, bytes);
		
		return bitmap.getPixels(bitmap.rect);
	}
	
	public static function convert_bitmap_data(bitmap_data:BitmapData):graphics_display
	{
		//var byteArray:ByteArray = bitmapData.getPixels(bitmapData.rect);
		var width:int = bitmap_data.rect.width;
		var height:int = bitmap_data.rect.height;
		
		var display:graphics_display = new graphics_display(width, height, 0);
		
		for(var x:int = 0; x < width; ++x)
		{
			for(var y:int = 0; y < height; ++y)
			{
				display.set_pixel(x, y, bitmap_data.getPixel(x, y));
			}
		}
		
		return display;
	}
	
	public function equals(p:graphics_display):Boolean
	{
		if(this.repeat != p.repeat
		|| this.background != p.background)
			return false;
		
		return true;
	}
	
	public var data:Array;
	private var cache_data:Array;
	
	private var pixel_bytes:ByteArray;
	private var background_bytes:ByteArray;
	
	private var background_:int;
	
	public var transparent:Boolean;
	public var repeat:Boolean;
	
	public var box:Rectangle;
	
	private var changed:Array;
	
	public var screen:BitmapData;
	
	private var cache:graphics_display;
}