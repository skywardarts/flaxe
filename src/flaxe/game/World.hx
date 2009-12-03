package flaxe.game;

class World
{
	public function new()
	{
		this.player_list = new List<flaxe.game.Player>();
		//this.player_id_list = new flash.Vector<Int>(0, true);
		this.object_list = new List<flaxe.game.Object>();
		this.npc_list = new List<flaxe.game.NPC>();
		
		this.scene = new flaxe.graphics.Scene<flaxe.graphics.Object>();
	}
	
	public function find_player(id:Int):flaxe.game.Player
	{
		//for(i in 0...this.player_id_list.length)
		//{
		//	if(this.player_id_list[i] == id)
		//		return this.player_list[i];
		//}
		
		
		for(player in this.player_list)
		{
			if(player.id == id)
				return player;
		}
		
		return null;
		
		//while(current.next != null)
		//{
			
		//	current = current.next;
		//}
	}
	
	public inline function get_player(id:Int):flaxe.game.Player
	{
		return this.find_player(id);
	}
	
	public inline function add_player(player:flaxe.game.Player):Void
	{
		this.player_list.add(player);
		//this.player_list[player.id] = player;
	}
	
	public inline function remove_player(player:flaxe.game.Player):Void
	{
		//this.player_list.splice(this.player_list.lastIndexOf(player), 1);
		//this.player_list[player.id] = null;
		this.player_list.remove(player);
	}

	public function update(time:flaxe.core.Timestamp):Void
	{
		//var i:Int, l:Int;
		
		//for each(var object:game_object in this.object_list)
		for(object in this.object_list)
		{
			//var object:flaxe.game.Object = this.object_list[i];
			
			object.update(time);
		}
				
		//for each(var player:game_player in this.player_list)
		for(player in this.player_list)
		{
			//var player:flaxe.game.Player = this.player_list[i];
			
			player.update(time);
		}
			
		//for each(var npc:game_npc in this.npc_list)
		for(npc in this.npc_list)
		{
			//var npc:flaxe.game.NPC = this.npc_list[i];
			
			npc.update(time);
		}
		
		this.scene.update(time);
		
/*
		this.mc = new MovieClip();
		//this.mc.x = 0; this.mc.y = 0;
		//this.mc.width = 64; this.mc.height = 64
		
		mc.addChild(this.mc);

		var txt:TextField = new TextField();
		txt.x = 0; txt.y = 0;
		txt.width = 64; txt.height = 20;
		txt.defaultTextFormat = new TextFormat("Verdana", 12, 0xFF0000, false, false, false);
		txt.selectable = false;
		txt.text = this.name;
		
		this.mc.addChild(txt);
		
		var bm:Bitmap = new Bitmap(new avatar(0, 0)); 
		bm.x = 0; bm.y = 20;
		bm.width = 34; bm.height = 34;
		
		this.mc.addChild(bm);*/
		
		
	}
	
	public function draw(device:flaxe.graphics.Device):Void
	{
		//var i:Int, l:Int;
		
		for(object in this.object_list)
		{
			//var object:flaxe.game.Object = this.object_list[i];
			
			//if(object != null)
			//{
				if(object.x + object.width >= this.scene.camera.x - device.width / 2
				   && object.y + object.height >= this.scene.camera.y - device.height / 2
				   && object.x - object.width <= this.scene.camera.x + device.width / 2
				   && object.y - object.height <= this.scene.camera.y + device.height / 2)
				{
					this.scene.add_model(object.model);
				}
			//}
		}
		
		for(player in this.player_list)
		{

			//var player:flaxe.game.Player = this.player_list[i];
			//trace(player);
			//if(player != null)
			//{
				if(player.x + player.width >= this.scene.camera.x - device.width / 2
				   && player.y + player.height >= this.scene.camera.y - device.height / 2
				   && player.x - player.width <= this.scene.camera.x + device.width / 2
				   && player.y - player.height <= this.scene.camera.y + device.height / 2)
				{
					this.scene.add_model(player.model);
				}
			//}
		}
		
		
		for(npc in this.npc_list)
		{
			//var npc:flaxe.game.NPC = this.npc_list[i];
			
			//if(npc != null)
			//{
				if(npc.x + npc.width >= this.scene.camera.x - device.width / 2
				   && npc.y + npc.height >= this.scene.camera.y - device.height / 2
				   && npc.x - npc.width <= this.scene.camera.x + device.width / 2
				   && npc.y - npc.height <= this.scene.camera.y + device.height / 2)
				{
					this.scene.add_model(npc.model);
				}
			//}
		}
		
		this.scene.draw(device);
	}
	
	public var scene:flaxe.graphics.Scene<flaxe.graphics.Object>;
	public var object_list:List<flaxe.game.Object>;
	public var player_list:List<flaxe.game.Player>;
	public var npc_list:List<flaxe.game.NPC>;
}
