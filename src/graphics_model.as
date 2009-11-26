import flash.geom.*;
import flash.display.*;
import flash.filters.*;

interface graphics_model_base
{
	function update(time:core_timestamp):void;
	function draw(device:graphics_device):void;
}

class graphics_model_2d implements graphics_model_base
{
	//public var Filter:IFilter;
		
	public var display:BitmapData;//graphics_display;
	
	public function graphics_model_2d()
	{
		this.position = math_vector2.zero;
		this.rotation = math_vector2.zero;
		
		this.display = new avatar(0, 0); //graphics_display.convert_bitmap_data(new avatar(0, 0)); 
	}

	public function update(time:core_timestamp):void
	{
		
	}
	
	public function draw(device:graphics_device):void
	{
		var rect:Rectangle = new Rectangle(this.position.x, this.position.y * -1, this.display.rect.width, this.display.rect.height);
		
		device.display.copy_bitmapdata(this.display, rect);//, new Point(this.position.x, this.position.y * -1));
	}
	
	public function get changed():Boolean
	{
		if(this.position.changed)
			return true;
		
		if(this.rotation.changed)
			return true;
		
		return false;
	}
	
	public function set changed(c:Boolean):void
	{
		this.position.changed = c;
		this.rotation.changed = c;
	}
	
	public function clone():graphics_model_base
	{
		return (new graphics_model_2d()).copy(this);
	}
	
	public function copy(model:graphics_model_2d):graphics_model_base
	{
		this.position = model.position;
		this.rotation = model.rotation;
		
		return this;
	}
	
	public var position:math_vector2;
	public var rotation:math_vector2;
}