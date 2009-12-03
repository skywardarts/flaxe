package flaxe.network.events;

class LoginEvent implements flaxe.network.events.SocketEvent
{
	//public var id(getId, never):Int;
	
	public var id:Int;
	public var username:String;
	public var password:String;
	
	public function new()
	{
		this.id = 2;
	}
	
	public inline function pack():flash.utils.ByteArray
	{
		var ba:flash.utils.ByteArray = new flash.utils.ByteArray();
		
		ba.writeInt(this.username.length);
		ba.writeUTFBytes(this.username);
		ba.writeInt(this.password.length);
		ba.writeUTFBytes(this.password);
		
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
	//	return 2;
	//}
}
