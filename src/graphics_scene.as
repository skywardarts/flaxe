import flash.display.MovieClip;

class graphics_scene
{
	public function graphics_scene()
	{
		this.models = new Array();
		//this.camera = new graphics_default_camera(0, 0, -200);
		
		//this.stats = new scene_statistics_component(mc, 0, 0, 200, 200);
	}
	
	public function add_model(model:graphics_model_base):void
	{
		this.models.push(model);
	}

	public function update(time:core_timestamp):void
	{
		//this.camera.update(time);
		//this.stats.update(time);
		
		//for each(var model:graphics_model_base in this.models)
			//model.update(time);
	}

	public function draw(device:graphics_device):void
	{
		for each(var model:graphics_model_base in this.models)
			model.draw(device);
		
		/* todo(daemn) 3d planned
		this.stats.reset();
		
		
		

		var primitives:Array = new Array();
		var primitive:IPrimitive;

		for each(var model:IModel in this.Models)
		{
			if(model.Visible)
			{
				model.Draw(device);

				if(!model.Culled)
				{
					this.stats.VisibleModels += 1;

					for each(primitive in model.Primitives)
					{
						if(primitive.Visible)
						{
							if(!primitive.Culled)
							{
								primitives.push(primitive);
								
								this.stats.VisiblePrimitives += 1;
								//this.stats.VisibleVertices += primitive.Vertices.length;
							}
							else
							{
								this.stats.CulledPrimitives += 1;
								//this.stats.CulledVertices += primitive.Vertices.length;
							}
						}
						else
						{
							this.stats.InvisiblePrimitives += 1;
							//this.stats.InvisibleVertices += primitive.Vertices.length;
						}
					}
				}
				else
				{
					this.stats.CulledModels += 1;
				}				
			}
			else
			{
				this.stats.InvisibleModels += 1;
			}
		}

		this.stats.TotalModels = this.Models.length;
		this.stats.TotalPrimitives = this.stats.VisiblePrimitives + this.stats.InvisiblePrimitives + this.stats.CulledPrimitives;
		//this.stats.TotalVertices = this.stats.VisibleVertices + this.stats.InvisibleVertices + this.stats.CulledVertices;

		// sort using selection algorithm
		
		var pos:int;
		
		for(var i:int = 0, l:int = primitives.length - 1; i < l; ++i)
		{
			pos = i;
			
			for(var j:int = i + 1; j < l + 1; ++j)
				if(primitives[j].Index > primitives[pos].Index)
					pos = j;
		
			if(pos != i)
			{
				var temp:int = primitives[i];
				primitives[i] = primitives[pos];
				primitives[pos] = temp;
			}
		}
		
		// render

		for each(primitive in primitives)
			device.Display.CopyPrimitivePixels(primitive);
			// break primitive into multiple polygons


			//device.Display.CopyPolygonPixels(primitive.Display, new Triangle(
			
			
			//device.Display.CopyPixels(primitive.Display, primitive.Display.Box, new Point(primitive.2D.X, primitive.2D.Y));
			//device.bitmapData.copyPixels(polygon.bitmapData, polygon.bitmapData.rect, new Point(polygon.2D.X, polygon.2D.Y));
			
			*/
			
		
	}
	
	private var models:Array;
	//private var camera:graphics_camera_base;
	//private var stats:scene_statistics_component;
}