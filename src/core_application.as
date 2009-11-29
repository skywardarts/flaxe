import flash.display.MovieClip;
import flash.display.Stage;
import flash.display.StageQuality;
import flash.net.LocalConnection;
import flash.events.*;
import flash.display.*;

class core_application
{
	public var info:info_component;
	
	public function core_application(mc:MovieClip)
	{
		this.mc = mc;
		this.active = true;
		
		this.components = new Array();
		
		this.timer = new core_timer();
		
		this.keyboard = new keyboard_device(this.mc);
		this.graphics = new graphics_device(this.mc);

		this.initialize();
	}
	
	public static function initialize(mc:MovieClip):void
	{
		if(instance == null)
			instance = new core_application(mc);
	}
	
	public function initialize():void
	{
		this.initialize_settings();

		this.initialize_components();
		
		this.mc.stage.addEventListener(Event.RESIZE, this.resize);
		this.mc.stage.addEventListener(Event.DEACTIVATE, this.deactivate);
		this.mc.stage.addEventListener(Event.ACTIVATE, this.activate);
		this.mc.addEventListener(Event.ENTER_FRAME, this.main);
	}
	
	public function activate(e:Event):void
	{
		this.active = true;
	}
	
	public function deactivate(e:Event):void
	{
		this.active = false;
	}
	
	public function resize(e:Event):void
	{
		
	}
	
	public function initialize_settings():void
	{
		this.mc.stage.showDefaultContextMenu = false;
		this.mc.stage.quality = StageQuality.HIGH;
		this.mc.stage.scaleMode = StageScaleMode.SHOW_ALL;//EXACT_FIT;
		this.mc.stage.align = StageAlign.TOP_LEFT;
		this.mc.stage.frameRate = 30;//32;

		this.domain = (new LocalConnection()).domain;
		
		this.url = mc.loaderInfo.url;
	}
	
	public function initialize_components():void
	{
		debug.initialize(this.mc);
		
		var info:info_component = new info_component(this.mc, this.mc.stage.stageWidth - 185, 25, 200, 100);

		this.components.push(info);
		
		this.info = info;
		/*
		var ram:memory_component = new memory_component(this.mc, this.mc.stage.stageWidth - 185, 85, 200, 100);
		
		this.components.push(ram);*/
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
		return instance;
	}
	
	private var active:Boolean;
	
	private var mc:MovieClip;

	private var components:Array;
	
	private var domain:String;
	private var url:String;
	
	private var keyboard:keyboard_device;
	private var graphics:graphics_device;
	
	private var timer:core_timer;
	
	private static var instance:core_application = null;
}
