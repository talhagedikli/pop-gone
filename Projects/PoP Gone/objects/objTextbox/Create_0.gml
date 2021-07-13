scale = new Vector2(image_xscale, image_yscale);
upScale = new Vector2();
downScale = new Vector2();
blend = new Vector2(image_blend, image_alpha);
image_xscale = 0;
image_yscale = 0;

blend.set(c_dkgray, 0.6);

image_xscale	= scale.x;
image_yscale	= scale.y;
image_blend		= blend.x;
image_alpha		= blend.y;

bounceTween = new TweenV2(tweenType.BOUNCEEASEIN);

state = new SnowState("max");

state.add("max", {
	enter: function()
	{
		
	},
	step: function()
	{
		if (image_xscale == scale.x && image_yscale == scale.y)
		{
			state.change("idle");
		}
	}
});

state.add("idle", {
	enter: function()
	{
		static up = 0.6;
		static down = 0.0;
		upScale.set(scale.x + up, scale.y + up);
		downScale.set(scale.x - down, scale.y - down);
	},
	step: function()
	{
		static uscl = 0.8;
		static lscl = 0.4;
		//static hscl = new Vector2(scale.x, scale.y);
		//static nhscl = new Vector2(scale.x, scale.y);
		if (position_meeting(mouse_x, mouse_y, self))
		{
			blend.set(c_white, 0.8);
			scale.set(upScale.x, upScale.y);
			if (InputManager.clickLeftPressed)
			{
				state.change("min");
			}
		}
		else
		{
			blend.set(c_dkgray, 0.6);
			scale.set(downScale.x, downScale.y);
		}
	}
});

state.add("min", {
	enter: function()
	{
		scale.set(0, 0);
	},
	step: function()
	{
		if (image_xscale == scale.x && image_yscale == scale.y)
		{
			var box = instance_create_layer(irandom_range(0, room_width), irandom_range(0, room_height), "Textboxes", objTextbox);
			box.scale.set(random_range(1, 3), random_range(1, 3));
			instance_destroy(self);
		}
	}
});
