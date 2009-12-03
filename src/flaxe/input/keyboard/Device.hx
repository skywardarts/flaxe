package flaxe.input.keyboard;

class Device
{
	public function new(mc:flash.display.MovieClip)
	{
		//if(keyboard_device.state == null)
		//{
			this.state = new flaxe.input.keyboard.State();
			
			this.changed = true;
			
			mc.mouseChildren = false;
			
			this.initialize();
		//}
		//else
		//{
			//throw new Error("[flaxe:keyboard_device] Incorrect singleton usage.");
		//}
	}
	
	var state:flaxe.input.keyboard.State;
	var key_codes:flash.Vector<String>;
	var changed:Bool;
	
	public function initialize():Void
	{
		this.initialize_key_codes();
	}
	
	public function initialize_key_codes():Void
	{
		this.key_codes = new flash.Vector<String>(256, true);
		
		this.key_codes[flaxe.input.keyboard.Code.none] = "none";
		this.key_codes[flaxe.input.keyboard.Code.Back] = "Back";
		this.key_codes[flaxe.input.keyboard.Code.Tab] = "Tab";
		this.key_codes[flaxe.input.keyboard.Code.Enter] = "Enter";
		this.key_codes[flaxe.input.keyboard.Code.Pause] = "Pause";
		this.key_codes[flaxe.input.keyboard.Code.CapsLock] = "Caps Lock";
		this.key_codes[flaxe.input.keyboard.Code.Escape] = "Escape";
		this.key_codes[flaxe.input.keyboard.Code.Space] = "Space";
		this.key_codes[flaxe.input.keyboard.Code.PageUp] = "Page Up";
		this.key_codes[flaxe.input.keyboard.Code.PageDown] = "Page Down";
		this.key_codes[flaxe.input.keyboard.Code.End] = "End";
		this.key_codes[flaxe.input.keyboard.Code.Home] = "Home";
		this.key_codes[flaxe.input.keyboard.Code.left] = "Left";
		this.key_codes[flaxe.input.keyboard.Code.up] = "Up";
		this.key_codes[flaxe.input.keyboard.Code.right] = "Right";
		this.key_codes[flaxe.input.keyboard.Code.down] = "Down";
		this.key_codes[flaxe.input.keyboard.Code.Select] = "Select";
		this.key_codes[flaxe.input.keyboard.Code.Print] = "Print";
		this.key_codes[flaxe.input.keyboard.Code.Execute] = "Execute";
		this.key_codes[flaxe.input.keyboard.Code.PrintScreen] = "Print Screen";
		this.key_codes[flaxe.input.keyboard.Code.Insert] = "Insert";
		this.key_codes[flaxe.input.keyboard.Code.Delete] = "Delete";
		this.key_codes[flaxe.input.keyboard.Code.Help] = "Help";
		this.key_codes[flaxe.input.keyboard.Code.D0] = "D0";
		this.key_codes[flaxe.input.keyboard.Code.D1] = "D1";
		this.key_codes[flaxe.input.keyboard.Code.D2] = "D2";
		this.key_codes[flaxe.input.keyboard.Code.D3] = "D3";
		this.key_codes[flaxe.input.keyboard.Code.D4] = "D4";
		this.key_codes[flaxe.input.keyboard.Code.D5] = "D5";
		this.key_codes[flaxe.input.keyboard.Code.D6] = "D6";
		this.key_codes[flaxe.input.keyboard.Code.D7] = "D7";
		this.key_codes[flaxe.input.keyboard.Code.D8] = "D8";
		this.key_codes[flaxe.input.keyboard.Code.D9] = "D9";
		this.key_codes[flaxe.input.keyboard.Code.a] = "a";
		this.key_codes[flaxe.input.keyboard.Code.B] = "B";
		this.key_codes[flaxe.input.keyboard.Code.C] = "C";
		this.key_codes[flaxe.input.keyboard.Code.d] = "d";
		this.key_codes[flaxe.input.keyboard.Code.E] = "E";
		this.key_codes[flaxe.input.keyboard.Code.F] = "F";
		this.key_codes[flaxe.input.keyboard.Code.G] = "G";
		this.key_codes[flaxe.input.keyboard.Code.H] = "H";
		this.key_codes[flaxe.input.keyboard.Code.I] = "I";
		this.key_codes[flaxe.input.keyboard.Code.J] = "J";
		this.key_codes[flaxe.input.keyboard.Code.K] = "K";
		this.key_codes[flaxe.input.keyboard.Code.L] = "L";
		this.key_codes[flaxe.input.keyboard.Code.M] = "M";
		this.key_codes[flaxe.input.keyboard.Code.N] = "N";
		this.key_codes[flaxe.input.keyboard.Code.O] = "O";
		this.key_codes[flaxe.input.keyboard.Code.P] = "P";
		this.key_codes[flaxe.input.keyboard.Code.Q] = "Q";
		this.key_codes[flaxe.input.keyboard.Code.R] = "R";
		this.key_codes[flaxe.input.keyboard.Code.s] = "s";
		this.key_codes[flaxe.input.keyboard.Code.T] = "T";
		this.key_codes[flaxe.input.keyboard.Code.U] = "U";
		this.key_codes[flaxe.input.keyboard.Code.V] = "V";
		this.key_codes[flaxe.input.keyboard.Code.w] = "w";
		this.key_codes[flaxe.input.keyboard.Code.X] = "X";
		this.key_codes[flaxe.input.keyboard.Code.Y] = "Y";
		this.key_codes[flaxe.input.keyboard.Code.Z] = "Z";
		this.key_codes[flaxe.input.keyboard.Code.LeftWindows] = "Left Windows";
		this.key_codes[flaxe.input.keyboard.Code.RightWindows] = "Right Windows";
		this.key_codes[flaxe.input.keyboard.Code.Apps] = "Apps";
		this.key_codes[flaxe.input.keyboard.Code.Sleep] = "Sleep";
		this.key_codes[flaxe.input.keyboard.Code.NumPad0] = "NumPad 0";
		this.key_codes[flaxe.input.keyboard.Code.NumPad1] = "NumPad 1";
		this.key_codes[flaxe.input.keyboard.Code.NumPad2] = "NumPad 2";
		this.key_codes[flaxe.input.keyboard.Code.NumPad3] = "NumPad 3";
		this.key_codes[flaxe.input.keyboard.Code.NumPad4] = "NumPad 4";
		this.key_codes[flaxe.input.keyboard.Code.NumPad5] = "NumPad 5";
		this.key_codes[flaxe.input.keyboard.Code.NumPad6] = "NumPad 6";
		this.key_codes[flaxe.input.keyboard.Code.NumPad7] = "NumPad 7";
		this.key_codes[flaxe.input.keyboard.Code.NumPad8] = "NumPad 8";
		this.key_codes[flaxe.input.keyboard.Code.NumPad9] = "NumPad 9";
		this.key_codes[flaxe.input.keyboard.Code.Multiply] = "Multiply";
		this.key_codes[flaxe.input.keyboard.Code.Add] = "Add";
		this.key_codes[flaxe.input.keyboard.Code.Separator] = "Separator";
		this.key_codes[flaxe.input.keyboard.Code.Subtract] = "Subtract";
		this.key_codes[flaxe.input.keyboard.Code.Decimal] = "Decimal";
		this.key_codes[flaxe.input.keyboard.Code.Divide] = "Divide";
		this.key_codes[flaxe.input.keyboard.Code.F1] = "F1";
		this.key_codes[flaxe.input.keyboard.Code.F2] = "F2";
		this.key_codes[flaxe.input.keyboard.Code.F3] = "F3";
		this.key_codes[flaxe.input.keyboard.Code.F4] = "F4";
		this.key_codes[flaxe.input.keyboard.Code.F5] = "F5";
		this.key_codes[flaxe.input.keyboard.Code.F6] = "F6";
		this.key_codes[flaxe.input.keyboard.Code.F7] = "F7";
		this.key_codes[flaxe.input.keyboard.Code.F8] = "F8";
		this.key_codes[flaxe.input.keyboard.Code.F9] = "F9";
		this.key_codes[flaxe.input.keyboard.Code.F10] = "F10";
		this.key_codes[flaxe.input.keyboard.Code.f11] = "F11";
		this.key_codes[flaxe.input.keyboard.Code.F12] = "F12";
		this.key_codes[flaxe.input.keyboard.Code.F13] = "F13";
		this.key_codes[flaxe.input.keyboard.Code.F14] = "F14";
		this.key_codes[flaxe.input.keyboard.Code.F15] = "F15";
		this.key_codes[flaxe.input.keyboard.Code.F16] = "F16";
		this.key_codes[flaxe.input.keyboard.Code.F17] = "F17";
		this.key_codes[flaxe.input.keyboard.Code.F18] = "F18";
		this.key_codes[flaxe.input.keyboard.Code.F19] = "F19";
		this.key_codes[flaxe.input.keyboard.Code.F20] = "F20";
		this.key_codes[flaxe.input.keyboard.Code.F21] = "F21";
		this.key_codes[flaxe.input.keyboard.Code.F22] = "F22";
		this.key_codes[flaxe.input.keyboard.Code.F23] = "F23";
		this.key_codes[flaxe.input.keyboard.Code.F24] = "F24";
		this.key_codes[flaxe.input.keyboard.Code.NumLock] = "Num Lock";
		this.key_codes[flaxe.input.keyboard.Code.Scroll] = "Scroll";
		this.key_codes[flaxe.input.keyboard.Code.LeftShift] = "Left Shift";
		this.key_codes[flaxe.input.keyboard.Code.RightShift] = "Right Shift";
		this.key_codes[flaxe.input.keyboard.Code.LeftControl] = "Left Control";
		this.key_codes[flaxe.input.keyboard.Code.RightControl] = "Right Control";
		this.key_codes[flaxe.input.keyboard.Code.LeftAlt] = "Left Alt";
		this.key_codes[flaxe.input.keyboard.Code.RightAlt] = "Right Alt";
		this.key_codes[flaxe.input.keyboard.Code.BrowserBack] = "Browser Back";
		this.key_codes[flaxe.input.keyboard.Code.BrowserForward] = "Browser Forward";
		this.key_codes[flaxe.input.keyboard.Code.BrowserRefresh] = "Browser Refresh";
		this.key_codes[flaxe.input.keyboard.Code.BrowserStop] = "Browser Stop";
		this.key_codes[flaxe.input.keyboard.Code.BrowserSearch] = "Browser Search";
		this.key_codes[flaxe.input.keyboard.Code.BrowserFavorites] = "Browser Favorites";
		this.key_codes[flaxe.input.keyboard.Code.BrowserHome] = "Browser Home";
		this.key_codes[flaxe.input.keyboard.Code.VolumeMute] = "Volume Mute";
		this.key_codes[flaxe.input.keyboard.Code.VolumeDown] = "Volume Down";
		this.key_codes[flaxe.input.keyboard.Code.VolumeUp] = "Volume Up";
		this.key_codes[flaxe.input.keyboard.Code.MediaNextTrack] = "Media Next Track";
		this.key_codes[flaxe.input.keyboard.Code.MediaPreviousTrack] = "Media Previous Track";
		this.key_codes[flaxe.input.keyboard.Code.MediaStop] = "Media Stop";
		this.key_codes[flaxe.input.keyboard.Code.MediaPlayPause] = "Media Play/Pause";
		this.key_codes[flaxe.input.keyboard.Code.LaunchMail] = "Launch Mail";
		this.key_codes[flaxe.input.keyboard.Code.SelectMedia] = "Select Media";
		this.key_codes[flaxe.input.keyboard.Code.LaunchApplication1] = "Launch Application 1";
		this.key_codes[flaxe.input.keyboard.Code.LaunchApplication2] = "Launch Application 2";
		this.key_codes[flaxe.input.keyboard.Code.OemSemicolon] = "Semicolon";
		this.key_codes[flaxe.input.keyboard.Code.OemPlus] = "Plus";
		this.key_codes[flaxe.input.keyboard.Code.OemComma] = "Comma";
		this.key_codes[flaxe.input.keyboard.Code.OemMinus] = "Minus";
		this.key_codes[flaxe.input.keyboard.Code.OemPeriod] = "Period";
		this.key_codes[flaxe.input.keyboard.Code.OemQuestion] = "Question";
		this.key_codes[flaxe.input.keyboard.Code.OemTilde] = "Tilde";
		this.key_codes[flaxe.input.keyboard.Code.ChatPadGreen] = "Chat Pad Green";
		this.key_codes[flaxe.input.keyboard.Code.ChatPadOrange] = "Chat Pad Orange";
		this.key_codes[flaxe.input.keyboard.Code.OemOpenBrackets] = "Open Brackets";
		this.key_codes[flaxe.input.keyboard.Code.OemPipe] = "Pipe";
		this.key_codes[flaxe.input.keyboard.Code.OemCloseBrackets] = "Close Brackets";
		this.key_codes[flaxe.input.keyboard.Code.OemQuotes] = "Quotes";
		this.key_codes[flaxe.input.keyboard.Code.Oem8] = "8";
		this.key_codes[flaxe.input.keyboard.Code.OemBackslash] = "Backslash";
		this.key_codes[flaxe.input.keyboard.Code.ProcessKey] = "Process Key";
		this.key_codes[flaxe.input.keyboard.Code.Attn] = "Attn";
		this.key_codes[flaxe.input.keyboard.Code.Crsel] = "Crsel";
		this.key_codes[flaxe.input.keyboard.Code.Exsel] = "Exsel";
		this.key_codes[flaxe.input.keyboard.Code.EraseEof] = "EraseEof";
		this.key_codes[flaxe.input.keyboard.Code.Play] = "Play";
		this.key_codes[flaxe.input.keyboard.Code.Zoom] = "Zoom";
		this.key_codes[flaxe.input.keyboard.Code.Pa1] = "Pa1";
		this.key_codes[flaxe.input.keyboard.Code.OemClear] = "Clear";
	}
	
	public inline function key_down(code:Int):Void
	{
		this.state.key_list[code] = true;
		
		this.changed = true;
	}

	public inline function key_up(code:Int):Void
	{
		this.state.key_list[code] = false;
		
		this.changed = true;
	}

	public inline function clear_keys():Void
	{
		this.state.clear();
	}
	
	public inline function get_state():flaxe.input.keyboard.State
	{
		this.changed = false;
		
		return this.state; // todo(daemn) need to allow multiple states to co-exist
	}
	
	public inline function key_to_string(key:Int):String
	{
		return this.key_codes[key];
	}
	
	public inline function is_changed():Bool
	{
		return this.changed;
	}
}
