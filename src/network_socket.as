import flash.errors.*;
import flash.events.*;
import flash.net.Socket;
import flash.utils.ByteArray;
import flash.utils.Endian;
import flash.utils.Dictionary;

class network_socket// extends abstract
{
	public static const connect_successful_event:int = 0;
	public static const connect_failure_event:int = 1;
	public static const receive_successful_event:int = 2;
	public static const receive_failure_event:int = 3;
	
	private var host:String;
	private var port:int;
	
	private var socket:Socket;
	
	private var event_handler_list:Array;
	private var authentication:Array;
	
	private var data:ByteArray;
	
	public function network_socket(host:String, port:int)
	{
		this.host = host;
		this.port = port;
		
		this.socket = new Socket();
		//this.socket.endian = Endian.LITTLE_ENDIAN;
		
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
	
	public function initialize():void
	{
		this.initialize_handler_list();
	}

	private function initialize_handler_list():void
	{
		this.socket.addEventListener(Event.CLOSE, this.on_close);
		this.socket.addEventListener(IOErrorEvent.IO_ERROR, this.on_error);
		this.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.on_error);
		this.socket.addEventListener(ProgressEvent.SOCKET_DATA, this.on_receive);
	}
	
	public function on_close(event:Event):void
	{
		debug.log("[flashx:network:on_close] Socket disconnected.");
	}
	
	public function on_error(event:Event):void
	{
		debug.log("[flashx:network:on_error] " + event);
	}
	
	public function on_receive(event:Event):void
	{
		this.receive();
	}
	
	public function connect(successful:Function, failure:Function):void
	{
		var self:network_socket = this;
		
		var connect_successful_handler:Function = function()
		{
			self.socket.removeEventListener(Event.CONNECT, connect_successful_handler);
			self.socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, connect_successful_handler);
			self.socket.removeEventListener(IOErrorEvent.IO_ERROR, connect_successful_handler);
			
			successful();
		};
		
		var connect_failure_handler:Function = function()
		{
			self.socket.removeEventListener(Event.CONNECT, connect_successful_handler);
			self.socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, connect_failure_handler);
			self.socket.removeEventListener(IOErrorEvent.IO_ERROR, connect_failure_handler);
			
			failure();
		};
		
		this.socket.addEventListener(Event.CONNECT, connect_successful_handler);
		this.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, connect_failure_handler);
		this.socket.addEventListener(IOErrorEvent.IO_ERROR, connect_failure_handler);

		this.socket.connect(this.host, this.port);
	}
	
	public function send(ba:ByteArray, successful:Function, failure:Function):void
	{
		var self:network_socket = this;
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
	
	public function receive():void
	{
		if(this.socket.bytesAvailable)
		{
			var successful:Function = this.event_handler_list[receive_successful_event];
			
			var ba:ByteArray = new ByteArray(); 

			this.socket.readBytes(ba);
			
			if(successful != null)
				successful(ba);
		}
		else
		{
			var failure:Function = this.event_handler_list[receive_failure_event];
			
			if(failure != null)
				failure(ba);
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
		debug.log("[BNCS] Connected.");
		
		this.socket.writeByte(0x01);
		
		this.socket.flush();
		
		for each(var byte:int in this.authentication)
			this.socket.writeByte(byte);
		
		this.socket.flush();
	}*/

	
	public function add_event_handler(event_id:int, handler:Function):void
	{
		this.event_handler_list[event_id] = handler;
	}
	
	public function remove_event_handler(event_id:int):void
	{
		this.event_handler_list[event_id] = null;
	}
}