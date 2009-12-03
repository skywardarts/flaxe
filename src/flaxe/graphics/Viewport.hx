package flaxe.graphics;

class Viewport
{
	public function new(?x:Int = 0, ?y:Int = 0, ?width:Int = 0, ?height:Int = 0, ?min_depth:Int = 0, ?max_depth:Int = 1)
	{
		this.x = x;
		this.y = y;
		
		this.width = width;
		this.height = height;
		
		this.min_depth = min_depth;
		this.max_depth = max_depth;
	}

	public inline function getAspect_ratio():Float
	{
		return this.height > 0 ? this.width / this.height : 0;
	}
	
	public inline function getTop():Int
	{
		return this.x;
	}
	
	public inline function getLeft():Int
	{
		return this.y;
	}
	
	public inline function getBottom():Int
	{
		return this.x + this.height;
	}
	
	public inline function getRight():Int
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
	
	public inline function to_string():String
	{
		return "[viewport " + this.x + ", " + this.y + " width: " + this.width + " height: " + this.height + "]";
	}
	
	public var x:Int;
	public var y:Int;
	
	public var width:Int;
	public var height:Int;
	
	var min_depth:Float;
	var max_depth:Float;
}
