import flash.errors.*;
import flash.events.*;
import flash.net.Socket;
import flash.utils.ByteArray;
import flash.utils.Endian;
	
class network_packet
{
	public var message_id:int;
	public var message_length:int;
	public var message_data:ByteArray;
	
	public function network_packet()
	{
		this.message_data = new ByteArray();
	}
	
	public function pack():void
	{
		
	}
	
	public function unpack():void
	{
		
	}
}