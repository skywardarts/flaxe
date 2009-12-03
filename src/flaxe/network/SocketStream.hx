package flaxe.network;

class SocketStream
{

	//public static const channel_list:uint = 0x0B;
	//public static const chat_event:uint = 0x0F;
	//public static const ad_info:uint = 0x15;
	//public static const ping:uint = 0x25;
	//public static const File_Time_Info:uint = 0x33;
	//public static const Logon_Response:uint = 0x3a;
	//public static const Realm_Logon_Response:uint = 0x3e;
	//public static const Query_Realms_Response:uint = 0x40;
	//public static const News_Info:uint = 0x46;
	//public static const Extra_Work_Info:uint = 0x4a;
	//public static const Required_ExtraWork_Info:uint = 0x4c;
	//public static const Connection_Response:uint = 0x50;
	//public static const Auth_Response:uint = 0x51;
	//public static const Invalid:uint = 0x83;
	
	var socket:flaxe.network.Socket;
	
	var event_handler_list:Array<Dynamic>;
	var message_handler_list:Array<Dynamic>;
	
	var data:flash.utils.ByteArray;
	
	public function new()
	{
		this.event_handler_list = new Array();
		this.message_handler_list = new Array();
		this.data = new flash.utils.ByteArray();
		
		this.add_message_handler(new flaxe.network.events.KeepAliveEvent());
		this.add_message_handler(new flaxe.network.events.LoginEvent());
		this.add_message_handler(new flaxe.network.events.CreatePlayerEvent());
		this.add_message_handler(new flaxe.network.events.RemovePlayerEvent());
		this.add_message_handler(new flaxe.network.events.UpdatePlayerPositionEvent());
		this.add_message_handler(new flaxe.network.events.UpdatePlayerRotationEvent());
	}
	
	public function connect(host:String, port:Int, successful:Dynamic, failure:Dynamic):Void
	{
		var self:SocketStream = this;
		
		this.socket = new flaxe.network.Socket(host, port);
		
		this.socket.add_event_handler(flaxe.network.Socket.receive_successful_event, function(ba:flash.utils.ByteArray):Void
		{
			var ba_length:Int = ba.length;
			
			self.data.writeBytes(ba);

			self.data.position = self.data.position - ba_length;

			var processing:Bool = true;
			
			while(processing)
			{
				
				
				if(self.data.bytesAvailable >= 8)
				{
					var message_id:Int = self.data.readInt();
					var message_length:Int = self.data.readInt();
					var message_data:flash.utils.ByteArray = new flash.utils.ByteArray();
					
					trace("Incoming event #" + message_id);
					trace("message_length: " + message_length);
					trace("bytes_avail: " + self.data.bytesAvailable);
					
					var available:Int = self.data.bytesAvailable;

					if(available > 0 && message_length > 0 && available >= message_length)
					{
						self.data.readBytes(message_data, 0, message_length);
						
						//self.message_handler_list[message_id]
						
						var event:flaxe.network.events.SocketEvent = self.message_handler_list[message_id].clone();
						
						message_data.position = 0;
						
						event.unpack(message_data);
						
						if(self.event_handler_list[message_id] != null)
						{
							trace("Firing off event #" + message_id);
							self.event_handler_list[message_id](event);
						}
					}
					else
					{
						
						//self.data.position -= 8;
						
						//self.data.writeInt(message_id);
						//self.data.writeInt(message_length);

						processing = false;
					}
				}
				else
				{
					processing = false;
				}
	
				//for each(var callback:Function in this.callbacks[packet.message_id])
					//callback(packet);
				
				//i += message_length;
			}
		});
		
		this.socket.connect(
		function():Void
		{
			successful();
		},
		function():Void
		{
			failure();
		});
	}
	
	public function send_message(message:flaxe.network.events.SocketEvent, successful:Dynamic, failure:Dynamic):Void
	{
		var ba:flash.utils.ByteArray = new flash.utils.ByteArray();
		
		var message_ba:flash.utils.ByteArray = message.pack();
		
		ba.writeInt(message.id);
		ba.writeInt(message_ba.length);
		ba.writeBytes(message_ba);
		
		this.socket.send(ba, 
		function():Void
		{
			successful();
		},
		function():Void
		{
			failure();
		});
	}
	
	public inline function add_message_handler(event:flaxe.network.events.SocketEvent):Void
	{
		this.message_handler_list[event.id] = event;
	}
	
	public inline function add_event_handler(event:flaxe.network.events.SocketEvent, handler:Dynamic):Void
	{
		this.event_handler_list[event.id] = handler;
	}
	
	public inline function remove_event_handler(event_id:Int):Void
	{
		this.event_handler_list[event_id] = null;
	}
	
	public function update():Void
	{
		//this.socket.receive();
	}
	
}

