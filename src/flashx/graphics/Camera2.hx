package flashx.graphics;

class Camera2
{
	public var x(getX, setX):Int;
	public var y(getY, setY):Int;
	
	public function new(x_:Int, y_:Int)
	{
		this.position = new flashx.math.Vector2(x_, y_);
	}
	
	public function update(time:flashx.core.Timestamp):Void
	{
		if(this.model != null)
		{
			this.position.x = this.model.position.x;
			this.position.y = this.model.position.y;
			
			//trace("cam: " + this.position.x + " / " + this.position.y);
		}
	}
	
	public inline function getX():Int
	{
		return this.position.x;
	}
	
	public inline function setX(x_:Int):Int
	{
		this.position.x = x_;
		
		return x_;
	}
	
	public inline function getY():Int
	{
		return this.position.y;
	}
	
	public inline function setY(y_:Int):Int
	{
		this.position.y = y_;
		
		return y_;
	}
	
	public var model:flashx.graphics.Model2;
	public var position:flashx.math.Vector2;
}
