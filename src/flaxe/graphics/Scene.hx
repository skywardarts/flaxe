package flaxe.graphics;

class Scene<T> implements haxe.rtti.Generic
{
	public function new()
	{
		this.models = new haxe.FastList<flaxe.graphics.Model2>();
		this.camera = new flaxe.graphics.Camera2(0, 0);
		
		//this.stats = new scene_statistics_component(mc, 0, 0, 200, 200);
	}
	
	public inline function add_model(model:flaxe.graphics.Model2):Void
	{
		this.models.add(model);
	}

	public inline function remove_model(model:flaxe.graphics.Model2):Void
	{
		this.models.remove(model);
	}

	public function update(time:flaxe.core.Timestamp):Void
	{
		this.camera.update(time);
	}

	public function draw(device:flaxe.graphics.Device):Void
	{
		for(model in this.models)
		{
			
			model.draw(device);
			
			//for(i in 0...1000)
			//{
			var offset:flash.geom.Point = new flash.geom.Point((model.x - this.camera.x) + (device.width / 2), (model.y - this.camera.y) * -1 + (device.height / 2));
			//trace("new play pos: " + offset.x + " / " + offset.y);
			//device.display.copy_bitmapdata(model.display, rect);
			//device.display.screen.copyPixels(model.display, model.display.rect, rect.topLeft);
			//trace(device.display);
			device.display.draw(model.display, offset);
			//}
			
			
		}
		
		this.models = new haxe.FastList<flaxe.graphics.Model2>();
	}
	
	private var models:haxe.FastList<flaxe.graphics.Model2>;
	public var camera:flaxe.graphics.Camera2;
}
