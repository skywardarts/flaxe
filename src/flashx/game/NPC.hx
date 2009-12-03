package flashx.game;

class NPC extends flashx.game.Object
{
	public var changed(getChanged, setChanged):Bool;
	
	public function new()
	{
		super();
		
		this.id = 0;
		this.name = "Undefined";
	}

	public override function getChanged():Bool
	{
		if(this.model.changed)
			return true;
			
		return false;
	}
	
	public override function setChanged(changed_:Bool):Bool
	{
		this.model.changed = changed_;
		
		return changed_;
	}
	
	public var id:Int;
	public var name:String;
}
