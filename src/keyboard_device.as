import flash.display.Stage;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.KeyboardEvent;

class keyboard_device
{
	private var state:keyboard_state;
	private var key_codes:Array;
	private var changed:Boolean;
	
	public function keyboard_device(mc:MovieClip)
	{
		//if(keyboard_device.state == null)
		//{
			this.state = new keyboard_state();
			
			this.changed = true;
			
			mc.mouseChildren = false;
			
			this.initialize();
		//}
		//else
		//{
			//throw new Error("[flashx:keyboard_device] Incorrect singleton usage.");
		//}
	}
	
	public function initialize():void
	{
		this.initialize_key_codes();
	}
	
	public function initialize_key_codes():void
	{
		this.key_codes = new Array(255);
		
		this.key_codes[key_code.none] = "none";
		this.key_codes[key_code.Back] = "Back";
		this.key_codes[key_code.Tab] = "Tab";
		this.key_codes[key_code.Enter] = "Enter";
		this.key_codes[key_code.Pause] = "Pause";
		this.key_codes[key_code.CapsLock] = "Caps Lock";
		this.key_codes[key_code.Escape] = "Escape";
		this.key_codes[key_code.Space] = "Space";
		this.key_codes[key_code.PageUp] = "Page Up";
		this.key_codes[key_code.PageDown] = "Page Down";
		this.key_codes[key_code.End] = "End";
		this.key_codes[key_code.Home] = "Home";
		this.key_codes[key_code.Left] = "Left";
		this.key_codes[key_code.Up] = "Up";
		this.key_codes[key_code.Right] = "Right";
		this.key_codes[key_code.Down] = "Down";
		this.key_codes[key_code.Select] = "Select";
		this.key_codes[key_code.Print] = "Print";
		this.key_codes[key_code.Execute] = "Execute";
		this.key_codes[key_code.PrintScreen] = "Print Screen";
		this.key_codes[key_code.Insert] = "Insert";
		this.key_codes[key_code.Delete] = "Delete";
		this.key_codes[key_code.Help] = "Help";
		this.key_codes[key_code.D0] = "D0";
		this.key_codes[key_code.D1] = "D1";
		this.key_codes[key_code.D2] = "D2";
		this.key_codes[key_code.D3] = "D3";
		this.key_codes[key_code.D4] = "D4";
		this.key_codes[key_code.D5] = "D5";
		this.key_codes[key_code.D6] = "D6";
		this.key_codes[key_code.D7] = "D7";
		this.key_codes[key_code.D8] = "D8";
		this.key_codes[key_code.D9] = "D9";
		this.key_codes[key_code.a] = "a";
		this.key_codes[key_code.B] = "B";
		this.key_codes[key_code.C] = "C";
		this.key_codes[key_code.d] = "d";
		this.key_codes[key_code.E] = "E";
		this.key_codes[key_code.F] = "F";
		this.key_codes[key_code.G] = "G";
		this.key_codes[key_code.H] = "H";
		this.key_codes[key_code.I] = "I";
		this.key_codes[key_code.J] = "J";
		this.key_codes[key_code.K] = "K";
		this.key_codes[key_code.L] = "L";
		this.key_codes[key_code.M] = "M";
		this.key_codes[key_code.N] = "N";
		this.key_codes[key_code.O] = "O";
		this.key_codes[key_code.P] = "P";
		this.key_codes[key_code.Q] = "Q";
		this.key_codes[key_code.R] = "R";
		this.key_codes[key_code.s] = "s";
		this.key_codes[key_code.T] = "T";
		this.key_codes[key_code.U] = "U";
		this.key_codes[key_code.V] = "V";
		this.key_codes[key_code.w] = "w";
		this.key_codes[key_code.X] = "X";
		this.key_codes[key_code.Y] = "Y";
		this.key_codes[key_code.Z] = "Z";
		this.key_codes[key_code.LeftWindows] = "Left Windows";
		this.key_codes[key_code.RightWindows] = "Right Windows";
		this.key_codes[key_code.Apps] = "Apps";
		this.key_codes[key_code.Sleep] = "Sleep";
		this.key_codes[key_code.NumPad0] = "NumPad 0";
		this.key_codes[key_code.NumPad1] = "NumPad 1";
		this.key_codes[key_code.NumPad2] = "NumPad 2";
		this.key_codes[key_code.NumPad3] = "NumPad 3";
		this.key_codes[key_code.NumPad4] = "NumPad 4";
		this.key_codes[key_code.NumPad5] = "NumPad 5";
		this.key_codes[key_code.NumPad6] = "NumPad 6";
		this.key_codes[key_code.NumPad7] = "NumPad 7";
		this.key_codes[key_code.NumPad8] = "NumPad 8";
		this.key_codes[key_code.NumPad9] = "NumPad 9";
		this.key_codes[key_code.Multiply] = "Multiply";
		this.key_codes[key_code.Add] = "Add";
		this.key_codes[key_code.Separator] = "Separator";
		this.key_codes[key_code.Subtract] = "Subtract";
		this.key_codes[key_code.Decimal] = "Decimal";
		this.key_codes[key_code.Divide] = "Divide";
		this.key_codes[key_code.F1] = "F1";
		this.key_codes[key_code.F2] = "F2";
		this.key_codes[key_code.F3] = "F3";
		this.key_codes[key_code.F4] = "F4";
		this.key_codes[key_code.F5] = "F5";
		this.key_codes[key_code.F6] = "F6";
		this.key_codes[key_code.F7] = "F7";
		this.key_codes[key_code.F8] = "F8";
		this.key_codes[key_code.F9] = "F9";
		this.key_codes[key_code.F10] = "F10";
		this.key_codes[key_code.f11] = "F11";
		this.key_codes[key_code.F12] = "F12";
		this.key_codes[key_code.F13] = "F13";
		this.key_codes[key_code.F14] = "F14";
		this.key_codes[key_code.F15] = "F15";
		this.key_codes[key_code.F16] = "F16";
		this.key_codes[key_code.F17] = "F17";
		this.key_codes[key_code.F18] = "F18";
		this.key_codes[key_code.F19] = "F19";
		this.key_codes[key_code.F20] = "F20";
		this.key_codes[key_code.F21] = "F21";
		this.key_codes[key_code.F22] = "F22";
		this.key_codes[key_code.F23] = "F23";
		this.key_codes[key_code.F24] = "F24";
		this.key_codes[key_code.NumLock] = "Num Lock";
		this.key_codes[key_code.Scroll] = "Scroll";
		this.key_codes[key_code.LeftShift] = "Left Shift";
		this.key_codes[key_code.RightShift] = "Right Shift";
		this.key_codes[key_code.LeftControl] = "Left Control";
		this.key_codes[key_code.RightControl] = "Right Control";
		this.key_codes[key_code.LeftAlt] = "Left Alt";
		this.key_codes[key_code.RightAlt] = "Right Alt";
		this.key_codes[key_code.BrowserBack] = "Browser Back";
		this.key_codes[key_code.BrowserForward] = "Browser Forward";
		this.key_codes[key_code.BrowserRefresh] = "Browser Refresh";
		this.key_codes[key_code.BrowserStop] = "Browser Stop";
		this.key_codes[key_code.BrowserSearch] = "Browser Search";
		this.key_codes[key_code.BrowserFavorites] = "Browser Favorites";
		this.key_codes[key_code.BrowserHome] = "Browser Home";
		this.key_codes[key_code.VolumeMute] = "Volume Mute";
		this.key_codes[key_code.VolumeDown] = "Volume Down";
		this.key_codes[key_code.VolumeUp] = "Volume Up";
		this.key_codes[key_code.MediaNextTrack] = "Media Next Track";
		this.key_codes[key_code.MediaPreviousTrack] = "Media Previous Track";
		this.key_codes[key_code.MediaStop] = "Media Stop";
		this.key_codes[key_code.MediaPlayPause] = "Media Play/Pause";
		this.key_codes[key_code.LaunchMail] = "Launch Mail";
		this.key_codes[key_code.SelectMedia] = "Select Media";
		this.key_codes[key_code.LaunchApplication1] = "Launch Application 1";
		this.key_codes[key_code.LaunchApplication2] = "Launch Application 2";
		this.key_codes[key_code.OemSemicolon] = "Semicolon";
		this.key_codes[key_code.OemPlus] = "Plus";
		this.key_codes[key_code.OemComma] = "Comma";
		this.key_codes[key_code.OemMinus] = "Minus";
		this.key_codes[key_code.OemPeriod] = "Period";
		this.key_codes[key_code.OemQuestion] = "Question";
		this.key_codes[key_code.OemTilde] = "Tilde";
		this.key_codes[key_code.ChatPadGreen] = "Chat Pad Green";
		this.key_codes[key_code.ChatPadOrange] = "Chat Pad Orange";
		this.key_codes[key_code.OemOpenBrackets] = "Open Brackets";
		this.key_codes[key_code.OemPipe] = "Pipe";
		this.key_codes[key_code.OemCloseBrackets] = "Close Brackets";
		this.key_codes[key_code.OemQuotes] = "Quotes";
		this.key_codes[key_code.Oem8] = "8";
		this.key_codes[key_code.OemBackslash] = "Backslash";
		this.key_codes[key_code.ProcessKey] = "Process Key";
		this.key_codes[key_code.Attn] = "Attn";
		this.key_codes[key_code.Crsel] = "Crsel";
		this.key_codes[key_code.Exsel] = "Exsel";
		this.key_codes[key_code.EraseEof] = "EraseEof";
		this.key_codes[key_code.Play] = "Play";
		this.key_codes[key_code.Zoom] = "Zoom";
		this.key_codes[key_code.Pa1] = "Pa1";
		this.key_codes[key_code.OemClear] = "Clear";
	}
	
	public function key_down(code:int):void
	{
		this.state.obj[code] = true;
		
		this.changed = true;
	}

	public function key_up(code:int):void
	{
		delete this.state.obj[code];
		
		this.changed = true;
	}

	public function clear_keys():void
	{
		this.state.clear();
	}
	
	public function get_state():keyboard_state
	{
		this.changed = false;
		
		return this.state; // todo(daemn) need to allow multiple states to co-exist
	}
	
	public function key_to_string(key:uint):String
	{
		return this.key_codes[key];
	}
	
	public function is_changed():Boolean
	{
		return this.changed;
	}
}