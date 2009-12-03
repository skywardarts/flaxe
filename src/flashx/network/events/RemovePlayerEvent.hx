package flashx.network.events;

class RemovePlayerEvent implements flashx.network.events.SocketEvent
{
	public var id:Int;
	public var player:flashx.game.Player;
	public var data:flash.utils.ByteArray;
	
	public function new()
	{
		this.id = 5;
		this.player = new flashx.game.Player();
	}
	
	public inline function pack():flash.utils.ByteArray
	{
		var ba:flash.utils.ByteArray = new flash.utils.ByteArray();
		
		ba.writeInt(this.player.id);
		
		return ba;
	}
	
	public inline function unpack(ba:flash.utils.ByteArray):Void
	{
		this.player.id = ba.readInt();
	}
	
	public inline function clone():flashx.network.events.SocketEvent
	{
		return this;
	}
	
	//public function getId():Int
	//{
	//	return 5;
	//}
}
