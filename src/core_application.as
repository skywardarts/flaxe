import flash.display.MovieClip;
import flash.display.Stage;
import flash.display.StageQuality;
import flash.net.LocalConnection;
import flash.events.*;
import flash.display.*;

class core_application
{
	public var info:info_component;
	
	public function core_application()
	{

	}
	
	public function initialize(mc:MovieClip):void
	{
		//mc.cacheAsBitmap = true;
		
		this.mc = new MovieClip();
		this.mc.x = 0;
		this.mc.y = 0;
		//this.mc.cacheAsBitmap = true;

		mc.addChild(this.mc);
		
		//this.mc = mc;
		this.active = true;
		
		this.components = new Array();
		
		this.timer = new core_timer();
		

		this.initialize_settings();

		this.initialize_components();
		
		this.mc.stage.addEventListener(MouseEvent.MOUSE_WHEEL, this.on_mouse_wheel);
		this.mc.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.on_key_down);
		this.mc.stage.addEventListener(KeyboardEvent.KEY_UP, this.on_key_up);
		this.mc.stage.addEventListener(Event.RESIZE, this.on_resize);
		this.mc.stage.addEventListener(Event.DEACTIVATE, this.on_deactivate);
		this.mc.stage.addEventListener(Event.ACTIVATE, this.on_activate);
		//this.mc.stage.addEventListener(FullScreenEvent.FULL_SCREEN, this.resize);
		this.mc.addEventListener(Event.ENTER_FRAME, this.main);
		
	}
	
	public function on_mouse_wheel(e:MouseEvent):void
	{
		var width_step:int = -e.delta * (240/160)*30;
		var height_step:int = width_step * (this.mc.stage.stageHeight/this.mc.stage.stageWidth);
		
		var width:int = this.graphics.display.width + width_step;
		var height:int = this.graphics.display.height + height_step;
		
		var max_width:int = this.mc.stage.stageWidth;
		var max_height:int = this.mc.stage.stageHeight;
		
		var min_width:int = 160 * (this.mc.stage.stageWidth/this.mc.stage.stageHeight);
		var min_height:int = 160;
		
		debug.log("stage: " + this.mc.stage.stageWidth + "/" + this.mc.stage.stageHeight + " min: " + min_width + "/" + min_height + " max: " + max_width + "/" + max_height + " norm: " + width + "/" + height);
		
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
	
	public function on_key_down(e:KeyboardEvent):void
	{
		this.keyboard.key_down(e.keyCode);
	}

	public function on_key_up(e:KeyboardEvent):void
	{
		if(e.keyCode == key_code.f11)
		{
			if(this.fullscreen)
				this.fullscreen = false;
			else
				this.fullscreen = true;
		}
		else
			this.keyboard.key_up(e.keyCode);
	}
	
	public function on_resize(e:Event):void
	{
		debug.log("[flashx:core_application] Resizing.");
		
		this.active = true;
		
		this.graphics.resize_viewport(this.mc.stage.stageWidth, this.mc.stage.stageHeight);
	}
	
	public function on_activate(e:Event):void
	{
		debug.log("[flashx:core_application] Activating.");
		
		this.active = true;
		
		if(this.keyboard == null)
			this.keyboard = new keyboard_device(this.mc);
		
		if(this.graphics == null)
		{
			var max_width:int = this.mc.stage.stageWidth;
			var max_height:int = this.mc.stage.stageHeight;
			
			var min_width:int = 160 * (this.mc.stage.stageWidth/this.mc.stage.stageHeight);
			var min_height:int = 160;
			
			this.graphics = new graphics_device(this.mc, min_width, min_height, max_width, max_height);
		}
	}
	
	public function on_deactivate(e:Event):void
	{
		debug.log("[flashx:core_application] Deactivating.");
		
		this.active = false;
		
		this.keyboard.clear_keys();
	}
	
	public function initialize_settings():void
	{
		this.mc.stage.showDefaultContextMenu = false;
		this.mc.stage.quality = StageQuality.HIGH;
		this.mc.stage.scaleMode = StageScaleMode.NO_SCALE;//SHOW_ALL;//EXACT_FIT;
		this.mc.stage.align = StageAlign.TOP_LEFT;
		this.mc.stage.frameRate = 120;//32;

		this.domain = (new LocalConnection()).domain;
		
		this.url = mc.loaderInfo.url;
	}
	
	public function initialize_components():void
	{
		debug.initialize(this.mc);
		
		var info:info_component = new info_component(this.mc, this.mc.stage.stageWidth - 185, 25, 200, 100);

		this.components.push(info);
		
		this.info = info;
	}
	
	public function get fullscreen():Boolean
	{
		return this.mc.stage.displayState == StageDisplayState.FULL_SCREEN;
	}
	
	public function set fullscreen(value:Boolean):void
	{
		if(value && !this.fullscreen)
		{
			debug.log("[flashx:core_application] Fullscreen enabled.");
			
			this.mc.stage.displayState = StageDisplayState.FULL_SCREEN;
		}
		else if(!value && this.fullscreen)
		{
			debug.log("[flashx:core_application] Fullscreen disabled.");
			
			this.mc.stage.displayState = StageDisplayState.NORMAL;
		}
	}
	
	public function main(e:Event):void
	{
		this.timer.update();
		
		if(this.active)
		{
			var time:core_timestamp = this.timer.current_time;
			
			this.info.start(time);
			
			var component:*;
			
			for each(component in this.components)
				component.update(time);

			this.timer.update();
			
			this.info.stop(this.timer.current_time);
			
			for each(component in this.components)
				component.draw(this.graphics);
			
			this.graphics.draw();
		}
	}
	
	public function initialize_input():void
	{
		
	}
	
	public function add_component(component:*):void
	{
		this.components.push(component);
	}
	
	public static function get_domain():String
	{
		return instance.domain;
	}
	
	public static function get_root():MovieClip
	{
		return instance.mc;
	}
	
	public static function get_stage():Stage
	{
		return instance.mc.stage;
	}
	
	public static function get_graphics():graphics_device
	{
		return instance.graphics;
	}
	
	public static function get_keyboard():keyboard_device
	{
		return instance.keyboard;
	}
	
	public static function get_instance():core_application
	{
		if(instance == null)
			instance = new core_application();
		
		return instance;
	}
	
	private var active:Boolean;
	
	private var mc:MovieClip;

	private var components:Array;
	
	private var domain:String;
	private var url:String;
	
	public var keyboard:keyboard_device;
	public var graphics:graphics_device;
	
	private var timer:core_timer;
	
	private static var instance:core_application = null;
}
