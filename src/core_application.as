import flash.display.MovieClip;
import flash.display.Stage;
import flash.display.StageQuality;
import flash.net.LocalConnection;
import flash.events.*;
import flash.display.*;

class core_application
{
	private var active:Boolean;
	
	private var mc:MovieClip;

	private var components:Array;
	
	private var domain:String;
	private var url:String;

	public function core_application(mc:MovieClip)
	{
		this.mc = mc;
		this.active = true;
		
		this.components = new Array();
		
		var lc:LocalConnection = new LocalConnection();
		this.domain = lc.domain;
		
		this.url = mc.loaderInfo.url;
		
		debug.initialize(this.mc);
		
		this.initialize();
	}
	
	public function initialize():void
	{
		this.initialize_settings();
	}
	
	public function initialize_settings():void
	{
		this.mc.stage.showDefaultContextMenu = false;
		this.mc.stage.quality = StageQuality.LOW;
	}
	
	public function get_domain():String
	{
		return this.domain;
	}
	
	public function get_root():MovieClip
	{
		return this.mc;
	}
	
	public function get_stage():Stage
	{
		return this.mc.stage;
	}
}
