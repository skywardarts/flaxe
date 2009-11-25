import flash.display.MovieClip;
import flash.display.Stage;
import flash.display.StageQuality;
import flash.net.LocalConnection;
import flash.events.*;
import flash.display.*;

class core_application
{
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
		debug.initialize(this.mc);
		
		this.initialize_settings();
		
		this.mc.addEventListener(Event.ENTER_FRAME, this.main);
	}
	
	public function initialize_settings():void
	{
		this.mc.stage.showDefaultContextMenu = false;
		this.mc.stage.quality = StageQuality.LOW;
		
		var lc:LocalConnection = new LocalConnection();
		this.domain = lc.domain;
		
		this.url = mc.loaderInfo.url;
	}
	
	public function main(e:Event):void
	{
		var time:core_timestamp = this.timer.current_time;
		
		var i, l;
		
		for(i = 0, l = this.components.length; i < l; ++i)
			this.components[i].update(time);
		
		this.graphics.clear(0x000000);
		
		for(i = 0, l = this.components.length; i < l; ++i)
			this.components[i].draw(this.graphics);
		
		this.graphics.draw();
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
