package flaxe.network.events;

interface SocketEvent
{
	function pack():flash.utils.ByteArray;
	function unpack(ba:flash.utils.ByteArray):Void;
	function clone():SocketEvent;
	
	public var id:Int;
}
