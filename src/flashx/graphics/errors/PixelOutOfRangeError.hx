package flashx.graphics.errors;

class PixelOutOfRangeError extends flashx.core.BasicError
{
	public function new()
	{
		super("PixelOutOfRangeError", "Pixel coordinates are out of range in the data array.", 700);
	}
}
