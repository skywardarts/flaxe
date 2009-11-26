interface math_vector_base
{
	
}

class math_vector2 implements math_vector_base
{
	public function math_vector2(x_:int = 0, y_:int = 0)
	{
		this.x_ = x_;
		this.y_ = y_;
		this.changed = false;
	}

	public static function get blank():math_vector2 { return new math_vector2(); }
	
	public static function get up():math_vector2 { return new math_vector2(0, 1); }
	public static function get down():math_vector2 { return new math_vector2(0, -1); }
	
	public static function get left():math_vector2 { return new math_vector2(-1, 0); }
	public static function get right():math_vector2 { return new math_vector2(1, 0); }
	
	public static function get unit_x():math_vector2 { return new math_vector2(1, 0); }
	public static function get unit_y():math_vector2 { return new math_vector2(0, 1); }
	
	public static function get zero():math_vector2 { return new math_vector2(0, 0); }
	public static function get one():math_vector2 { return new math_vector2(1, 1); }
	
	public function get x():int
	{
		return this.x_;
	}
	
	public function set x(x_:int):void
	{
		if(this.x_ != x_)
		{
			this.x_ = x_;
			
			this.changed = true;
		}
	}
	
	public function get y():int
	{
		return this.y_;
	}
	
	public function set y(y_:int):void
	{
		if(this.y_ != y_)
		{
			this.y_ = y_;
			
			this.changed = true;
		}
	}
	
	public function clone():math_vector2
	{
		return new math_vector2(this.x_, this.y_);
	}
	
	private var x_:int;
	private var y_:int;
	public var changed:Boolean;
}

class math_vector3 implements math_vector_base
{
	
}