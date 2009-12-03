package flaxe.network.events;

class UpdatePlayerRotationEvent implements flaxe.network.events.SocketEvent
{
	public var id:Int;
	
	public var rotation:flaxe.math.Vector2;
	
	public function new()
	{
		this.id = 42;
		this.rotation = new flaxe.math.Vector2();
	}
	
	public inline function pack():flash.utils.ByteArray
	{
		var ba:flash.utils.ByteArray = new flash.utils.ByteArray();
trace("rot: " + this.rotation.x + " / " + this.rotation.y);
		ba.writeInt(this.rotation.x);
		ba.writeInt(this.rotation.y);
		//ba.writeInt(math_helper.random_int(0, 9999));
		
		return ba;
	}
	
	public inline function unpack(ba:flash.utils.ByteArray):Void
	{
		
	}
	
	public inline function clone():flaxe.network.events.SocketEvent
	{
		return this;
	}
	
	//public function getId():Int
	//{
	//	return 42;
	//}
}
