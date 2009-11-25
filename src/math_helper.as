class math_helper
{
	public static const e:Number = 2.718282;
	public static const log10e:Number = 0.434295;
	public static const log2e:Number = 1.442695;
	
	/** const: Pi
	 * Curvature of a circle.
	 */
	public static const pi:Number = 3.141593;
	public static const pi_over_2:Number = 1.570796;
	public static const pi_over_4:Number = 0.785398;
	public static const two_pi:Number = 6.283185;
	
	/** const: Epsilon
	 * Small amount of error often used when comparing distances.
	 */
	public static const epsilon:Number = 0.000001;

	public static function to_degrees(radians:Number):Number
	{
		return radians * 57.29578; // (180 / Math.PI)
	}
	
	public static function to_radians(degrees:Number):Number
	{
		return degrees * 0.0174533; // (Math.PI / 180)
	}
	
	public static function within_epsilon(n1:Number, n2:Number):Boolean
	{
		var n3:Number = n1 - n2;
		
		return ((n3 >= -math_helper.epsilon) && (n3 <= math_helper.epsilon));
	}
	
	public static function random_int(n1:int, n2:int):int
	{
		return int(Math.floor(Math.random() * (n2 -  n1)) + n1);
	}
	/*
	public static function point_inside_triangle(v1:IVector, v2:IVector, v3:IVector, p:IVector):Boolean
	{
		if(VectorHelper.Cross(v3.Subtract(v1), p.Subtract(v1)) <= 0
		&& VectorHelper.Cross(v2.Subtract(v3), p.Subtract(v3)) <= 0
		&& VectorHelper.Cross(v1.Subtract(v2), p.Subtract(v2)) <= 0)
			return true;
		
		return false;
	}*/
	
	public static function get random_angle():Number
	{
		return Math.random() * math_helper.two_pi;
	}
}