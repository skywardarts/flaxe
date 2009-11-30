interface graphics_camera_base
{
	
}

class graphics_camera_2d implements graphics_camera_base
{
	public function graphics_camera_2d(x:int, y:int)
	{
		this.model = null;
		this.position = new math_vector2(x, y);
	}
	
	public function update(time:core_timestamp):void
	{
		if(this.model != null)
		{
			this.position.x = this.model.position.x;
			this.position.y = this.model.position.y;
			
			trace("cam: " + this.position.x + " / " + this.position.y);
		}
	}
	
	public var model:graphics_model_2d;
	public var position:math_vector2;
}