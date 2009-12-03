package flashx;

class Application
{
	public var fullscreen(getFullscreen, setFullscreen):Bool;
	
	public function new()
	{
		
	}
public var inn:Bool;
	public function initialize(mc:flash.display.MovieClip):Void
	{
		this.inn = false;
		//mc.cacheAsBitmap = true;
		
		this.mc = new flash.display.MovieClip();
		this.mc.x = 0;
		this.mc.y = 0;
		//this.mc.cacheAsBitmap = true;

		mc.addChild(this.mc);
		
		//this.mc = mc;
		this.active = true;
		
		this.components = new Array();
		
		this.timer = new flashx.core.Timer();
		



		this.initialize_settings();

		
		
		var max_width:Int = this.mc.stage.stageWidth;
		var max_height:Int = this.mc.stage.stageHeight;
		
		var min_width:Int = cast 160 * (this.mc.stage.stageWidth/this.mc.stage.stageHeight);
		var min_height:Int = 160;
		
		this.graphics = new flashx.graphics.Device(this.mc, min_width, min_height, max_width, max_height);
		
		this.initialize_components();
		
		this.keyboard = new flashx.input.keyboard.Device(this.mc);
		
		this.mc.stage.addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.on_mouse_wheel);
		this.mc.stage.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.on_key_down);
		this.mc.stage.addEventListener(flash.events.KeyboardEvent.KEY_UP, this.on_key_up);
		this.mc.stage.addEventListener(flash.events.Event.RESIZE, this.on_resize);
		this.mc.stage.addEventListener(flash.events.Event.DEACTIVATE, this.on_deactivate);
		this.mc.stage.addEventListener(flash.events.Event.ACTIVATE, this.on_activate);
		//this.mc.stage.addEventListener(FullScreenEvent.FULL_SCREEN, this.resize);
		this.mc.addEventListener(flash.events.Event.ENTER_FRAME, this.main);
	}
	
	public function on_mouse_wheel(e:flash.events.MouseEvent):Void
	{
		var width_step:Int = cast -e.delta * (240/160)*30;
		var height_step:Int = cast width_step * (this.mc.stage.stageHeight/this.mc.stage.stageWidth);
		
		var width:Int = this.graphics.width + width_step;
		var height:Int = this.graphics.height + height_step;
		
		var max_width:Int = this.mc.stage.stageWidth;
		var max_height:Int = this.mc.stage.stageHeight;
		
		var min_width:Int = cast 160 * (this.mc.stage.stageWidth/this.mc.stage.stageHeight);
		var min_height:Int = 160;
		
		trace("stage: " + this.mc.stage.stageWidth + "/" + this.mc.stage.stageHeight + " min: " + min_width + "/" + min_height + " max: " + max_width + "/" + max_height + " norm: " + width + "/" + height);
		
		if(width > max_width)
			width = max_width;
		else if(width < min_width)
			width = min_width;
		
		if(height > max_height)
			height = max_height;
		else if(height < min_height)
			height = min_height;
		
		this.graphics.resize_display(width, height);
	}
	
	public function on_key_down(e:flash.events.KeyboardEvent):Void
	{
		this.keyboard.key_down(e.keyCode);
	}

	public function on_key_up(e:flash.events.KeyboardEvent):Void
	{
		if(e.keyCode == flashx.input.keyboard.Code.f11)
		{
			if(this.fullscreen)
				this.fullscreen = false;
			else
				this.fullscreen = true;
		}
		else
			this.keyboard.key_up(e.keyCode);
	}
	
	public function on_resize(e:flash.events.Event):Void
	{
		trace("[flashx:core_application] Resizing.");
		
		this.active = true;
		
		this.graphics.resize_viewport(this.mc.stage.stageWidth, this.mc.stage.stageHeight);
	}
	
	public function on_activate(e:flash.events.Event):Void
	{
		trace("[flashx:core_application] Activating.");
		
		this.active = true;
		

	}
	
	public function on_deactivate(e:flash.events.Event):Void
	{
		trace("[flashx:core_application] Deactivating.");
		
		this.active = false;
		
		this.keyboard.clear_keys();
	}
	
	public function initialize_settings():Void
	{
		
		
		haxe.Log.setColor(0xFFFFFF);
		
		this.mc.stage.showDefaultContextMenu = false;
		this.mc.stage.quality = flash.display.StageQuality.HIGH;
		this.mc.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;//SHOW_ALL;//EXACT_FIT;
		this.mc.stage.align = flash.display.StageAlign.TOP_LEFT;
		this.mc.stage.frameRate = 100;

		this.domain = (new flash.net.LocalConnection()).domain;
		
		this.url = mc.loaderInfo.url;
	}
	
	public function initialize_components():Void
	{
		//Debug.initialize(this.mc);
		
		var info:flashx.InformationComponent = new flashx.InformationComponent(this.mc, this.mc.stage.stageWidth - 185, 25, 200, 100);

		this.components.push(info);
		
		this.info = info;
	}
	
	public function getFullscreen():Bool
	{
		return this.mc.stage.displayState == flash.display.StageDisplayState.FULL_SCREEN;
	}
	
	public function setFullscreen(value:Bool):Bool
	{
		if(value && !this.fullscreen)
		{
			trace("[flashx:core_application] Fullscreen enabled.");
			
			this.mc.stage.displayState = flash.display.StageDisplayState.FULL_SCREEN;
		}
		else if(!value && this.fullscreen)
		{
			trace("[flashx:core_application] Fullscreen disabled.");
			
			this.mc.stage.displayState = flash.display.StageDisplayState.NORMAL;
		}
		return value;
	}
	
	public function main(e:flash.events.Event):Void
	{
		this.timer.update();
		
		if(this.active)
		{
			if(this.inn == false)
			{
				de.polygonal.ds.mem.MemoryManager.allocate(1024 * 50, 1024 * 50);
				
				this.inn = true;
			}
				
			var time:flashx.core.Timestamp = this.timer.current_time;
			
			this.info.start(time);
			
			var component:Dynamic;
			
			for(component in this.components)
				component.update(time);

			this.timer.update();
			
			this.info.stop(this.timer.current_time);
			
			for(component in this.components)
				component.draw(this.graphics);
			
			if(this.graphics != null)
				this.graphics.draw();
		}
	}
	
	public function initialize_input():Void
	{
		
	}
	
	public inline function add_component(component:Dynamic):Void
	{
		this.components.push(component);
	}
	
	public static inline function get_domain():String
	{
		return instance.domain;
	}
	
	public static inline function get_root():flash.display.MovieClip
	{
		return instance.mc;
	}
	
	public static inline function get_stage():flash.display.Stage
	{
		return instance.mc.stage;
	}
	
	public static inline function get_graphics():flashx.graphics.Device
	{
		return instance.graphics;
	}
	
	public static inline function get_keyboard():flashx.input.keyboard.Device
	{
		return instance.keyboard;
	}
	
	public static inline function get_instance():Application
	{
		if(instance == null)
			instance = new Application();
		
		return instance;
	}
	
	var active:Bool;
	
	var mc:flash.display.MovieClip;

	var components:Array<Dynamic>;
	
	var domain:String;
	var url:String;
	
	public var keyboard:flashx.input.keyboard.Device;
	public var graphics:flashx.graphics.Device;
	
	var timer:flashx.core.Timer;
	var info:flashx.InformationComponent;
	
	static var instance:Application;
}
