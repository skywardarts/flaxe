package flashx.core;


class Timer
{
	var start_time_:Int;
	public var current_time:flashx.core.Timestamp;
	
	public function new()
	{
		this.start_time_ = cast Date.now().getTime();
		this.current_time = new flashx.core.Timestamp();
		
		this.update();
	}
	
	public inline function getCurrent_time():flashx.core.Timestamp
	{
		return this.current_time;
	}
	
	public inline function difference(time:flashx.core.Timestamp):flashx.core.Timestamp
	{
		return new flashx.core.Timestamp(this.current_time.total_real_time - time.total_real_time, this.current_time.elapsed_real_time - time.elapsed_real_time, this.current_time.total_flash_time - time.total_flash_time, this.current_time.elapsed_flash_time - time.elapsed_flash_time);
	}
	
	public inline function update():Void
	{
		var now:Int = cast Date.now().getTime();
		
		var total_real_time_:Int = now - this.start_time_;
		var total_flash_time_:Int = now - this.start_time_;

		var elapsed_real_time_:Int = total_real_time_ - this.current_time.total_real_time;
		var elapsed_flash_time_:Int = total_flash_time_ - this.current_time.total_flash_time;
		
		this.current_time = new flashx.core.Timestamp(total_real_time_, elapsed_real_time_, total_flash_time_, elapsed_flash_time_);
	}
/* todo(daemn) not sure
	public static function difference(t1:core_timestamp, t2:core_timestamp)
	{
		return t1.clone().difference(t2);
	}*/
}
