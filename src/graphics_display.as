import flash.display.*;
import flash.utils.*;
import flash.geom.*;

class graphics_display
{
	public function graphics_display(width:int, height:int, transparent:Boolean = false, background_:int = 0, repeat:Boolean = false)
	{
		this.data = new Array(width * height);
		
		this.transparent = transparent;
		this.repeat = repeat;
		
		this.box = new Rectangle(0, 0, width, height);
		
		this.background_ = background_;
		
		this.changed = new Array();
		
		var bitmap:BitmapData = new BitmapData(width, height, transparent, background_);
		
		bitmap.fillRect(bitmap.rect, background_);
		
		this.background_bytes = bitmap.getPixels(bitmap.rect);
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
			this.background_ = background_;
			
			// create background byte array
			var bitmap:BitmapData = new BitmapData(this.width, this.height, this.transparent, this.background_);
			
			bitmap.fillRect(bitmap.rect, this.background_);
			trace(bitmap.rect);
			this.background_bytes = bitmap.getPixels(bitmap.rect);
		}
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
		this.data = new Array(this.width * this.height);
		this.cache_data = new Array(this.width * this.height);
		this.pixel_bytes = graphics_display.clone_byte_array(this.background_bytes, this.width, this.height, this.transparent);
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
		return (new graphics_display(this.width, this.height)).copy(this);
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
	/*
	public function copy_primitive_pixels(p:IPrimitive)
	{
		var display:graphics_display = p.display;
		
		var offset:int = int(p.Offset.Y * this.width + p.Offset.X);
		
		var box:Rectangle = display.Box;
		
		//trace("offset: ", offset);
		//trace(int(box.y * box.width + box.x));
		//trace(int(box.height * box.width));
		//trace(this.data.length);
		//trace(display.data.length);
		//trace(display.data[0]);
		//trace(display.Background);

		for(var y:int = box.y, yl = int(box.y + box.height); y < yl; ++y)
		{
			for(var x:int = box.x, xl = int(box.x + box.width); x < xl; ++x)
			{
				var i:int = int(y * box.width + x);
				
				if(display.data[i] != undefined)
				{
					var index:int = int((y + p.offset.Y) * this.width + (x + p.offset.X));//int(offset + this.Box.width * y + x);
					
					this.data[index] = display.data[i];
					
					this.changed.push(index);
				}
			}
		}
		*/
		/*
		for(var i:int = int(box.y * box.width + box.x), l = int(box.height * box.width - offset); i < l; ++i)
		{
			if(display.data[i] != undefined)
			{
				var index:int = int((i / box.width) * (this.Box.width - box.width) * );
				
				this.data[index] = display.data[i];
				
				this.changed.push(index);
			}
		}
		*/
		/*
		for(var i:int = int(box.y * box.width + box.x), l = int(box.height * box.width - offset); i < l; ++i)
		{
			if(display.data[i] != undefined)
			//if(display.data[i] != display.Background)
			{
				var index:int = int((i / box.width) * (this.Box.width - box.width) * );
				//trace("i", i, display.data.length);
				//trace("int(i + offset)", index, this.data.length);
				this.data[index] = display.data[i];
				//trace(display.data[i]);
				//trace(0xFF0000);
				
				this.changed.push(index);
			}
		}
		*/
	//}
	
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
			this.data[int(i + offset)] = source_pixels[i];
		}
	}
	
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
	
	/* bug(daemn) wont allow graphics_display for some reason - probably problem with includes
	public static function convert_bitmap_data(bitmap_data:BitmapData):graphics_display
	{
		//var byteArray:ByteArray = bitmapData.getPixels(bitmapData.rect);
		var width:int = bitmap_data.rect.width;
		var height:int = bitmap_data.rect.height;
		
		var graphics_display:graphics_display = new graphics_display(width, height);
		
		for(var x:int = 0; x < width; ++x)
		{
			for(var y:int = 0; y < height; ++y)
			{
				graphics_display.set_pixel(x, y, bitmap_data.getPixel(x, y));
			}
		}
		
		return graphics_display;
	}*/
	
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
	
	private var cache:graphics_display;
}