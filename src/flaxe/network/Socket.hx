package flaxe.network;

class Socket
{
	public static var connect_successful_event:Int = 0;
	public static var connect_failure_event:Int = 1;
	public static var receive_successful_event:Int = 2;
	public static var receive_failure_event:Int = 3;
	
	var host:String;
	var port:Int;
	
	var socket:flash.net.Socket;
	
	var event_handler_list:Array<Dynamic>;
	var authentication:Array<Dynamic>;
	
	var data:flash.utils.ByteArray;
	
	public function new(host:String, port:Int)
	{
		this.host = host;
		this.port = port;
		
		this.socket = new flash.net.Socket();
		//this.socket.endian = flash.utils.Endian.LITTLE_ENDIAN;
		
		this.event_handler_list = new Array();
		
		this.authentication = 
		[
			0xff, 0x50, 0x3a, 0x00, 0x00, 0x00, 0x00, 0x00, 
			0x36, 0x38, 0x58, 0x49, 0x50, 0x58, 0x32, 0x44, 
			0x0c, 0x00, 0x00, 0x00, 0x53, 0x55, 0x6e, 0x65, 
			0x55, 0xb4, 0x47, 0x40, 0x88, 0xff, 0xff, 0xff, 
			0x09, 0x04, 0x00, 0x00, 0x09, 0x04, 0x00, 0x00, 
			0x55, 0x53, 0x41, 0x00, 0x55, 0x6e, 0x69, 0x74, 
			0x65, 0x64, 0x20, 0x53, 0x74, 0x61, 0x74, 0x65, 
			0x73, 0x00
		];
		
		this.initialize();
	}
	
	public function initialize():Void
	{
		this.initialize_handler_list();
	}

	function initialize_handler_list():Void
	{
		this.socket.addEventListener(flash.events.Event.CLOSE, this.on_close);
		this.socket.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.on_error);
		this.socket.addEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, this.on_error);
		this.socket.addEventListener(flash.events.ProgressEvent.SOCKET_DATA, this.on_receive);
	}
	
	public function on_close(event:flash.events.Event):Void
	{
		trace("[flaxe:network:on_close] Socket disconnected.");
	}
	
	public function on_error(event:flash.events.Event):Void
	{
		trace("[flaxe:network:on_error] " + event);
	}
	
	public function on_receive(event:flash.events.Event):Void
	{
		this.receive();
	}
	
	public function connect(successful:Dynamic, failure:Dynamic):Void
	{
		var self:Socket = this;
		
		var connect_successful_handler:Dynamic = null;
		var connect_failure_handler:Dynamic = null;
		
		connect_successful_handler = function():Void
		{
			self.socket.removeEventListener(flash.events.Event.CONNECT, connect_successful_handler);
			self.socket.removeEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, connect_successful_handler);
			self.socket.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, connect_successful_handler);
			
			successful();
		};
		
		
		
		connect_failure_handler = function():Void
		{
			self.socket.removeEventListener(flash.events.Event.CONNECT, connect_successful_handler);
			self.socket.removeEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, connect_failure_handler);
			self.socket.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, connect_failure_handler);
			
			failure();
		};
		
		this.socket.addEventListener(flash.events.Event.CONNECT, connect_successful_handler);
		this.socket.addEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, connect_failure_handler);
		this.socket.addEventListener(flash.events.IOErrorEvent.IO_ERROR, connect_failure_handler);

		this.socket.connect(this.host, this.port);
	}
	
	public function send(ba:flash.utils.ByteArray, successful:Dynamic, failure:Dynamic):Void
	{
		var self:Socket = this;
		// todo(daemn) check if connected
		
		/*
		var send_successful_handler:Function = function()
		{
			self.socket.removeEventListener(ProgressEvent.SOCKET_DATA, send_successful_handler);
			self.socket.removeEventListener(IOErrorEvent.IO_ERROR, send_failure_handler);
			
			successful();
		};
		
		var send_failure_handler:Function = function()
		{
			self.socket.removeEventListener(ProgressEvent.SOCKET_DATA, send_successful_handler);
			self.socket.removeEventListener(IOErrorEvent.IO_ERROR, send_failure_handler);
			
			failure();
		};
		
		this.socket.addEventListener(ProgressEvent.SOCKET_DATA, send_successful_handler);
		this.socket.addEventListener(IOErrorEvent.IO_ERROR, send_failure_handler);*/
		
		//ba.writeMultiByte(data, "us-ascii");
		
		this.socket.writeBytes(ba);
		this.socket.flush();
		
		successful();
	}
	
	public function receive():Void
	{
		if(this.socket.bytesAvailable > 0)
		{
			var successful:Dynamic = this.event_handler_list[receive_successful_event];
			
			var ba:flash.utils.ByteArray = new flash.utils.ByteArray(); 

			this.socket.readBytes(ba);
			
			if(successful != null)
				successful(ba);
		}
		else
		{
			var failure:Dynamic = this.event_handler_list[receive_failure_event];
			
			if(failure != null)
				failure();
		}
	}

	/*
	public function add_message_callback(message_id:int, callback:Function):void
	{
		if(!(message_id in this.callbacks))
			this.callbacks[message_id] = new Array();
		
		this.callbacks[message_id].push(callback);
	}*/

/*
	private function connect_handler(event:Event):void
	{
		trace("[BNCS] Connected.");
		
		this.socket.writeByte(0x01);
		
		this.socket.flush();
		
		for each(var byte:int in this.authentication)
			this.socket.writeByte(byte);
		
		this.socket.flush();
	}*/

	
	public inline function add_event_handler(event_id:Int, handler:Dynamic):Void
	{
		this.event_handler_list[event_id] = handler;
	}
	
	public inline function remove_event_handler(event_id:Int):Void
	{
		this.event_handler_list[event_id] = null;
	}
}
