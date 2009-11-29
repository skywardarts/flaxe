import flash.display.Stage;
import flash.display.MovieClip;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.getTimer;
import flash.events.Event;
import flash.filters.GlowFilter;

class info_component
{
	//private var stage:Stage;
	private var frames_elasped:Number;
	private var ms_elasped:int;
	private var ms_threshold:int;
	private var start_real_time:int;
	private var mc:MovieClip;
	private var fps_title:TextField;
	private var ms_title:TextField;
	private var memory_title:TextField;
	public var fps:int;
	public var ms:int;
	
	public function info_component(mc:MovieClip, x:Number, y:Number, width:Number, height:Number)
	{
		//this.stage = mc.stage;
		
		this.frames_elasped = this.ms_elasped = 0;

		this.ms_threshold = 1000;
		
		this.mc = new MovieClip();
		
		mc.addChild(this.mc);
		
		var text_glow:GlowFilter = new GlowFilter(0x333333, 1, 2, 2, 3, 2, false, false);

		this.fps_title = new TextField();
		this.fps_title.x = x; this.fps_title.y = y;
		//this.fps_title.width = width; this.fps_title.height = height;
		this.fps_title.defaultTextFormat = new TextFormat("_sans", 18, 0xFFFFFF, true, false, false);
		this.fps_title.filters = [text_glow];
		this.fps_title.selectable = false;
		//this.fps_title.antiAliasType = AntiAliasType.ADVANCED;
		//this.fps_title.gridFitType = GridFitType.NONE;
		
		this.mc.addChild(this.fps_title);
		
		this.ms_title = new TextField();
		this.ms_title.x = x; this.ms_title.y = y + 30;
		//this.ms_title.width = width; this.ms_title.height = height;
		this.ms_title.defaultTextFormat = new TextFormat("_sans", 18, 0xFFFFFF, true, false, false);
		this.ms_title.filters = [text_glow];
		this.ms_title.selectable = false;
		//this.ms_title.antiAliasType = AntiAliasType.ADVANCED;
		//this.ms_title.gridFitType = GridFitType.NONE;
		
		this.mc.addChild(this.ms_title);
		
		this.memory_title = new TextField();
		this.memory_title.x = x; this.memory_title.y = y + 60;
		//this.memory_title.width = width; this.memory_title.height = height;
		this.memory_title.defaultTextFormat = new TextFormat("_sans", 18, 0xFFFFFF, true, false, false);
		this.memory_title.filters = [text_glow];
		this.memory_title.selectable = false;
		//this.memory_title.antiAliasType = AntiAliasType.ADVANCED;
		//this.memory_title.gridFitType = GridFitType.NONE;
		
		this.mc.addChild(this.memory_title);
	}
	
	public function start(time:core_timestamp):void
	{
		this.start_real_time = time.total_real_time;
	}
	
	public function stop(time:core_timestamp):void
	{
		this.ms = time.total_real_time - this.start_real_time;
		
		this.ms_title.text = String(ms) + " MS";
	}
	
	public function update(time:core_timestamp):void
	{
		++this.frames_elasped;

		this.ms_elasped += time.elapsed_real_time;

		if(this.ms_elasped >= this.ms_threshold)
		{
			this.fps = this.frames_elasped;
			
			this.fps_title.text = String(this.fps) + " FPS";

			this.frames_elasped = 0;
			this.ms_elasped = 0;
		}
		
		this.memory_title.text = Number(System.totalMemory / 1024 / 1024).toFixed(2) + " MB";
		
		/*
		++this.frames;

		this.now = getTimer();
		
		if((this.now - this.before) > this.delay)
		{
			this.fps = this.frames;
			
			this.txt.text = String(this.frames) + " FPS";

			this.frames = 0;
			this.before = this.now;
		}*/
	}

	public function draw(device:graphics_device):void
	{

	}
}