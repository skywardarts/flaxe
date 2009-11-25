class graphics_viewport
{
	public function graphics_viewport(x:int = 0, y:int = 0, width:int = 0, height:int = 0, min_depth:Number = 0, max_depth:Number = 1)
	{
		this.x = x;
		this.y = y;
		
		this.width = width;
		this.height = height;
		
		this.min_depth = min_depth;
		this.max_depth = max_depth;
	}

	public function get aspect_ratio():Number
	{
		return this.height ? this.width / this.height : 0;
	}
	
	public function get top():int
	{
		return this.x;
	}
	
	public function get left():int
	{
		return this.y;
	}
	
	public function get bottom():int
	{
		return this.x + this.height;
	}
	
	public function get right():int
	{
		return this.y + this.width;
	}
	/* todo(daemn) 3d projection is on todo list
	public function project(source:IVector, projection:IMatrix, view:IMatrix, world:IMatrix):IVector
	{
		var m:IMatrix = MatrixHelper.Multiply(world, view, projection);
		
		var v:IVector = VectorHelper.Transform(source, m);
		
		var n:Number = (source.X * m[1][4]) + (source.Y * m[2][4]) + (source.Z * m[3][4]) + m[4][4];
		
		if(!MathHelper.WithinEpsilon(n, 1))
			v.Divide(n);
		
		v.X = (((v.X + 1) * 0.5) * this.width) + this.X;
		v.Y = (((-v.Y + 1) * 0.5) * this.height) + this.Y;
		v.Z = (v.Z * (this.MaxDepth - this.MinDepth)) + this.MinDepth;
		//trace(v);
		return v;
	}
	
	public function unproject(source:IVector, projection:IMatrix, view:IMatrix, world:IMatrix):IVector
	{
		var m:IMatrix = math_helper.multiply(world, view, projection).Invert();
		
		var v:IVector = new vector3();

		v.X = (((source.X - this.X) / this.width) * 2) - 1;
		v.Y = -((((source.Y - this.Y) / this.height) * 2) - 1);
		v.Z = (source.Z - this.min_depth) / (this.max_depth - this.min_depth);
		
		v.Transform(m);
		
		var n:Number = (source.X * m[1][4]) + (source.Y * m[2][4]) + (source.Z * m[3][4]) + m[4][4];
		
		if(!math_helper.within_epsilon(n, 1))
			v.divide(n);
		
		return v;
	}*/
	
	public function to_string():String
	{
		return "[viewport " + this.x + ", " + this.y + " width: " + this.width + " height: " + this.height + "]";
	}
	
	private var x:int;
	private var y:int;
	
	private var width:int;
	private var height:int;
	
	private var min_depth:Number;
	private var max_depth:Number;
}