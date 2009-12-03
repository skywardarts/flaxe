package flaxe.network.events;

class UpdatePlayerPositionEvent implements flaxe.network.events.SocketEvent
{
	public var id:Int;
	public var player_id:Int;
	public var position:flaxe.math.Vector2;
	
	public function new()
	{
		this.id = 41;
		this.position = new flaxe.math.Vector2();
	}
	
	public inline function pack():flash.utils.ByteArray
	{
		var ba:flash.utils.ByteArray = new flash.utils.ByteArray();
		
		ba.writeInt(this.player_id);
		ba.writeInt(this.position.x);
		ba.writeInt(this.position.y);
		
		return ba;
	}
	
	public inline function unpack(ba:flash.utils.ByteArray):Void
	{
		//var event:flaxe.network.SocketEvent = new UpdatePlayerPositionEvent();
		
		this.player_id = ba.readInt();
		this.position.x = ba.readInt();
		this.position.y = ba.readInt();

		//return event;
	}
	
	public inline function clone():flaxe.network.events.SocketEvent
	{
		return new UpdatePlayerPositionEvent();
	}

	//public function getId():Int
	//{
	//	return 41;
	//}
}
