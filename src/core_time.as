class core_timestamp
{
	private var total_real_time_:int;
	private var elapsed_real_time_:int;
	
	private var total_flash_time_:int;
	private var elapsed_flash_time_:int;

	public function core_timestamp(total_real_time_:int = 0, elapsed_real_time_:int = 0, total_flash_time_:int = 0, elapsed_flash_time_:int = 0)
	{
		this.total_real_time_ = total_real_time_;
		this.elapsed_real_time_ = elapsed_real_time_;
		this.total_flash_time_ = total_flash_time_;
		this.elapsed_flash_time_ = elapsed_flash_time_;
	}

	public function get total_real_time():int
	{
		return this.total_real_time_;
	}
	
	public function get elapsed_real_time():int
	{
		return this.elapsed_real_time_;
	}
	
	public function get total_flash_time():int
	{
		return this.total_flash_time_;
	}
	
	public function get elapsed_flash_time():int
	{
		return this.elapsed_flash_time_;
	}

	public function get is_running_slowly():Boolean
	{
		return false;
	}
	
	public function clone():core_timestamp
	{
		return new core_timestamp(this.total_real_time_, this.elapsed_real_time_, this.total_flash_time_, this.elapsed_flash_time_);
	}
}

class core_timer
{
	private var start_time_:Number;
	private var current_time_:core_timestamp;
	
	public function core_timer()
	{
		this.start_time_ = (new Date()).milliseconds;
		this.current_time_ = new core_timestamp();
		
		this.update();
	}
	
	public function get current_time():core_timestamp
	{
		return this.current_time_;
	}
	
	public function difference(time:core_timestamp):core_timestamp
	{
		return new core_timestamp(this.current_time_.total_real_time - time.total_real_time, this.current_time_.elapsed_real_time - time.elapsed_real_time, this.current_time_.total_flash_time - time.total_flash_time, this.current_time_.elapsed_flash_time - time.elapsed_flash_time);
	}
	
	public function update():void
	{
		var now:Number = (new Date()).time;
		
		var total_real_time_:int = now - this.start_time_;
		var total_flash_time_:int = now - this.start_time_;

		var elapsed_real_time_:int = total_real_time_ - this.current_time_.total_real_time;
		var elapsed_flash_time_:int = total_flash_time_ - this.current_time_.total_flash_time;
		
		this.current_time_ = new core_timestamp(total_real_time_, elapsed_real_time_, total_flash_time_, elapsed_flash_time_);
	}
/* todo(daemn) not sure
	public static function difference(t1:core_timestamp, t2:core_timestamp)
	{
		return t1.clone().difference(t2);
	}*/
}