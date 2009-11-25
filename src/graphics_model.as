import flash.geom.*;
import flash.display.*;
import flash.filters.*;

interface graphics_model_base
{
	function update(time:core_timestamp):void;
	function draw(device:graphics_device):void;
}

class graphics_model_2d implements graphics_model_base
{
	//public var Filter:IFilter;
	
	public function graphics_model()
	{
		/*
		this.Visible = true;
		this.Active = true;
		this.Culled = false;
		*/
		this.position = math_vector2.zero;
		this.rotation = math_vector2.zero;
		/*
		this.Direction = Quaternion3.Identity;
		
		this.World = Matrix4.Identity;

		this.Primitives = new Array();
		
		this.Filter = new DefaultFilter();
		this.Lighting = new DefaultLighting();
		this.Camera = new DefaultCamera(50, 50, 50);*/
	}

	public function update(time:core_timestamp):void
	{
		/* todo(daemn)
		this.camera.update(time);
		
		var t:Number = time.ElapsedRealTime;
		
		var keyState:KeyboardState = KeyboardDevice.GetState();
		
		if(keyState.IsKeyDown(Keys.Up) || keyState.IsKeyDown(Keys.W))
			this.Position.Y += 5 * t / 1000;
		else if(keyState.IsKeyDown(Keys.Down) || keyState.IsKeyDown(Keys.S))
			this.Position.Y -= 5 * t / 1000;
		
		if(keyState.IsKeyDown(Keys.Left) || keyState.IsKeyDown(Keys.A))
			this.Position.X -= 5 * t / 1000;
		else if(keyState.IsKeyDown(Keys.Right) || keyState.IsKeyDown(Keys.D))
			this.Position.X += 5 * t / 1000;
		
		if(keyState.IsKeyDown(Keys.Q))
			this.Rotation.X += 5 * t / 1000;
		else if(keyState.IsKeyDown(Keys.E))
			this.Rotation.X -= 5 * t / 1000;
		
		var mouseState:MouseState = MouseDevice.GetState();
		
		this.Camera.Position.Z += mouseState.Scroll * t / 1000;*/
	}
	
	public function draw(device:graphics_device):void
	{
		
		
		/*
		if(!this.Equals(this.Cache))
		{
			this.Filter.World = this.World;
			this.Filter.View = MatrixHelper.Multiply(this.Camera.View, MatrixHelper.CreateTranslation(this.Position)); //MatrixHelper.Multiply(this.Camera.View, MatrixHelper.CreateTranslation(this.Position), MatrixHelper.CreateRotation(this.Rotation));
			this.Filter.Projection = Matrix4.CreatePerspectiveFieldOfView(MathHelper.ToRadians(45), device.Viewport.AspectRatio, 1, 1000);
			//trace(this.Camera.View);
			this.Filter.Begin(device);

			this.Culled = true;
	
			for each(var primitive:IPrimitive in this.Primitives)
			{
				if(primitive.Visible)
				{
					primitive.Draw(device);
	
					if(!primitive.Culled)
						this.Culled = false;
				}
			}
			
			this.Filter.End(device);
			
			this.Cache = this.Clone();
		}*/
	}
	
	public function clone():graphics_model_base
	{
		return (new graphics_model_2d()).copy(this);
	}
	
	public function copy(model:graphics_model_2d):graphics_model_base
	{
		this.position = model.position;
		this.rotation = model.rotation;
		
		return this;
	}
	
	public var position:math_vector2;
	public var rotation:math_vector2;
}