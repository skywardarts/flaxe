class network_client
{
	private var socket:network_socket;
	
	public function network_client(socket:network_socket)
	{
		this.socket = socket;
	}
	
	public function connect(host:String = null, port:uint = 0):void
	{
		
	}
	
	public function get_socket():network_socket
	{
		return this.socket;
	}
}