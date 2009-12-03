package flaxe.network.events;

class KeepAliveEvent implements flaxe.network.events.SocketEvent
{
	//public static const id:int = 1;
	
	public var id:Int;
	public static var open_status:Int = 1;
	public static var close_status:Int = 2;
	
	public var status_id:Int;
	
	public function new()
	{
		this.id = 1;
	}
	
	public inline function pack():flash.utils.ByteArray
	{
		var ba:flash.utils.ByteArray = new flash.utils.ByteArray();
		
		ba.writeInt(this.status_id);
		
		return ba;
	}
	
	public inline function unpack(ba:flash.utils.ByteArray):Void
	{
		this.status_id = ba.readInt();
	}
	
	public inline function clone():flaxe.network.events.SocketEvent
	{
		return this;
	}
	
	//public function getId():Int
	//{
	//	return 1;
	//}
}
