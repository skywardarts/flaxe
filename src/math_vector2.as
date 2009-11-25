class math_vector2
{
	public var x_:int;
	public var y_:int;
	
	public function math_vector2(x_:int = 0, y_:int = 0)
	{
		this.x_ = x_;
		this.y_ = y_;
	}
	
	public function get x():int
	{
		return this.x_;
	}
	
	public function set x(x_:int):void
	{
		this.x_ = x_;
	}
	
	public function get y():int
	{
		return this.y_;
	}
	
	public function set y(y_:int):void
	{
		this.y_ = y_;
	}
}