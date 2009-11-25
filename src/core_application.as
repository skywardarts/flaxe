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
	//private var stage:Stage;
	
	//private var timer:TimeHandler;
	
	//public var scene:IScene;
	private var components:Array;
	private var drawable_components:Array;
	
	private var domain:String;
	private var url:String;
	
	//public var keyboard:KeyboardDevice;
	//public var mouse:MouseDevice;
	//public var network:NetworkDevice;
	//public var graphics:GraphicsDevice;
	
	public function core_application(mc:MovieClip)
	{
		this.mc = mc;
		this.active = true;
		
		this.components = new Array();
		this.drawable_components = new Array();
		
		var lc:LocalConnection = new LocalConnection();
		this.domain = lc.domain;
		
		this.url = mc.loaderInfo.url;
		
		debug.initialize(this.mc);
		
		//this.timer = new TimeHandler();
		
		//this.keyboard = new KeyboardDevice(this.mc);
		//this.graphics = new GraphicsDevice(this.mc);
		//this.mouse = new MouseDevice(this.mc);
		//this.network = new NetworkDevice(this.mc);
		
		//this.mc.addChild(mouse);
		
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





//package FlashX
//{
	//import FlashX.Core.*;
	//import FlashX.Core.Components.*;
	//import FlashX.Content.*;
	//import FlashX.Graphics.*;
	//import FlashX.Input.*;
	//import FlashX.Network.*;
	
		
		//public function get_root():MovieClip
		//{
			//return this.root;
		//}
		
		/*
		public function Initialize():void
		{
			this.InitializeSettings();
			
			this.InitializeGraphics();
			this.InitializeComponents();
			this.InitializeCamera();
			this.InitializeKeyboard();
			this.InitializeMouse();
			
			trace("FlashX started.");
			
			this.mc.addEventListener(Event.ENTER_FRAME, this.Main);
		}
		
		public function InitializeSettings():void
		{
			this.mc.stage.showDefaultContextMenu = false;
			this.mc.stage.quality = StageQuality.LOW;
		}
		
		public function InitializeComponents():void
		{
			var fps:FramesComponent = new FramesComponent(this.mc, this.mc.stage.stageWidth - 185, 25, 200, 100);
			
			fps.Initialize();
			
			this.drawableComponents.push(fps);
			
			var ram:IDrawableComponent = new MemoryComponent(this.mc, this.mc.stage.stageWidth - 185, 85, 200, 100);
			
			ram.Initialize();
			
			this.drawableComponents.push(ram);
			
			var quality:IComponent = new QualityComponent(this.mc, fps);
			
			quality.Initialize();
			
			this.components.push(quality);
			
			
			
		}
		
		public function InitializeGraphics():void
		{
			
			
			
		}
		
		public function InitializeKeyboard():void
		{

		}
		
		public function InitializeMouse():void
		{
			this.mouse.DisableRightClick();
		}
		
		public function InitializeCamera():void
		{
			//var camera:ICamera = new FreeCamera();
			
			//camera.Initialize();
			
			//this.components.push(camera);
		}
		
		public var elaspedTime:Number = 0;
		
		public function Main(e:Event):void
		{
			if(this.active)
			{
				//while(elaspedTime >= 10) //update until time to render
				//{
					for each(var c1:IComponent in this.components)
						c1.Update(this.timer.CurrentTime);
					
					for each(var c2:IComponent in this.drawableComponents)
						c2.Update(this.timer.CurrentTime);
					
					this.scene.Update(this.timer.CurrentTime);
					
					MouseDevice.Clear();
					
					this.elaspedTime -= 15;
				//}
				
				
				
				if(this.elaspedTime >= 15)
					return;
				
				
				this.timer.Update();
				
				
				this.graphics.Clear(0x000000);
				
				for each(var c3:IDrawableComponent in this.drawableComponents)
					c3.Draw(this.graphics);
				
				this.scene.Draw(this.graphics);
				//for(var i:uint = 100, l = 200; i < l; ++i)
					//this.graphics.Display.SetPixel(int(i), int(i), 0xFF0000);
				//trace("..", this.graphics.Display.GetPixel(int(150), int(150)));
				//trace("..", this.graphics.Display.GetPixel(int(300), int(300)));
				//trace("..", this.graphics.Display.GetPixel(int(0 + 355), int(81 + 259)));
				//trace("..", this.graphics.Display.GetPixel(int(69 + 355), int(86 + 259)));
				this.graphics.Draw();
				
				this.elaspedTime = timer.CurrentTime.ElapsedFlashTime;
			}
		}
		*/

