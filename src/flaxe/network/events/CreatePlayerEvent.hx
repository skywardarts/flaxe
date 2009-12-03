package flaxe.network.events;

class CreatePlayerEvent implements flaxe.network.events.SocketEvent
{
	public var id:Int;
	public var player:flaxe.game.Player;
	public var control:Bool;
	
	public function new()
	{
		this.id = 3;
		this.player = new flaxe.game.Player();
	}
	
	public inline function pack():flash.utils.ByteArray
	{
		var ba:flash.utils.ByteArray = new flash.utils.ByteArray();
		
		ba.writeInt(this.player.id);
		ba.writeInt(this.player.name.length);
		ba.writeUTFBytes(this.player.name);
		ba.writeInt(this.player.position.x);
		ba.writeInt(this.player.position.y);
		ba.writeInt(this.player.rotation.x);
		ba.writeInt(this.player.rotation.y);
		ba.writeBoolean(this.control);
		
		return ba;
	}
	
	public inline function unpack(ba:flash.utils.ByteArray):Void
	{
		//var event:flaxe.network.SocketEvent = new UpdatePlayerPositionEvent();
trace("unpacking create player event");

		this.player.id = ba.readInt();
		trace(this.player.id);
		var player_name_length:Int = ba.readInt();
		trace(player_name_length);
		this.player.name = ba.readUTFBytes(player_name_length);
		trace(this.player.name);
		this.player.position.x = ba.readInt();
		trace(this.player.position.x);
		this.player.position.y = ba.readInt();
		trace(this.player.position.y);
		this.player.rotation.x = ba.readInt();
		trace(this.player.rotation.x);
		this.player.rotation.y = ba.readInt();
		trace(this.player.rotation.y);
		this.control = ba.readBoolean();
		
		//return event;
	}
	
	public inline function clone():flaxe.network.events.SocketEvent
	{
		return new CreatePlayerEvent();
	}

	//public function getId():Int
	//{
	//	return 3;
	//}
}
