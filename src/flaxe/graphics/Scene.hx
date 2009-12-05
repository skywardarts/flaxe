package flaxe.graphics;

class Scene<CameraType> implements haxe.rtti.Generic
{
	public function new()
	{
		this.object_list = new haxe.FastList<flaxe.graphics.ObjectBase>();
		this.camera = new CameraType(0, 0);
	}
	
	public inline function add_object(model:flaxe.graphics.ObjectBase):Void
	{
		this.object_list.add(model);
	}

	public inline function remove_object(model:flaxe.graphics.ObjectBase):Void
	{
		this.object_list.remove(model);
	}

	public function update(time:flaxe.core.Timestamp):Void
	{
		this.camera.update(time);
	}

	public function draw(device:flaxe.graphics.Device):Void
	{
		for(object in this.object_list)
		{
			var offset = new flash.geom.Point((object.x - this.camera.x) + (device.width / 2), (object.y - this.camera.y) * -1 + (device.height / 2));

			device.display.draw(object, offset);
		}
		
		this.object_list = new haxe.FastList<flaxe.graphics.ObjectBase>();
	}
	
	private var object_list:haxe.FastList<flaxe.graphics.ObjectBase>;
	public var camera:CameraType;
}
