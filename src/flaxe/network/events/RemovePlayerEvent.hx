package flaxe.network.events;

class RemovePlayerEvent implements flaxe.network.events.SocketEvent
{
	public var id:Int;
	public var player:flaxe.game.Player;
	public var data:flash.utils.ByteArray;
	
	public function new()
	{
		this.id = 5;
		this.player = new flaxe.game.Player();
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
	
	public inline function clone():flaxe.network.events.SocketEvent
	{
		return this;
	}
	
	//public function getId():Int
	//{
	//	return 5;
	//}
}
