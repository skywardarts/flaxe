import flash.display.Stage;
import flash.display.MovieClip;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.getTimer;
import flash.events.Event;

class frames_component
{
	private var parent:MovieClip;
	private var stage:Stage;
	private var frames:Number;
	private var before:Number;
	private var now:Number;
	private var delay:Number;
	private var mc:MovieClip;
	private var txt:TextField;
	public var fps:Number;
	
	public function frames_component(parent:MovieClip, x:Number, y:Number, width:Number, height:Number)
	{
		this.parent = parent;
		this.stage = parent.stage;
		this.frames = this.before = this.now = 0;

		this.delay = 1000;
		
		this.mc = new MovieClip();
		
		parent.addChild(this.mc);

		this.txt = new TextField();
		this.txt.x = x; this.txt.y = y;
		this.txt.width = width; this.txt.height = height;
		this.txt.defaultTextFormat = new TextFormat("Verdana", 35, 0xFF0000, false, false, false);
		this.txt.selectable = false;
		
		this.mc.addChild(this.txt);
	}
	
	public function update(time:core_timestamp):void
	{
		++this.frames;

		this.now = getTimer();
		
		if((this.now - this.before) > this.delay)
		{
			this.fps = this.frames;
			
			this.txt.text = String(this.frames) + " FPS";

			this.frames = 0;
			this.before = this.now;
		}
	}

	public function draw(device:graphics_device):void
	{

	}
}