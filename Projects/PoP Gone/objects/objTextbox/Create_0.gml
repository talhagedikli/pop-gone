scale = new Vector2(image_xscale, image_yscale);
upScale = new Vector2();
downScale = new Vector2();
blend = new Vector2(image_blend, image_alpha);
image_xscale = 0;
image_yscale = 0;
image_index = 0;
image_speed = 0;

blend.set(c_dkgray, 0.6);

image_xscale	= scale.x;
image_yscale	= scale.y;
image_blend		= blend.x;
image_alpha		= blend.y;

bounceTween = new TweenV2(tweenType.BOUNCEEASEIN);

// Text
scribble_font_set_default("fntRainyHearts");
//text		= @"Hello to [wave]PoP Gone[/wave]. Your way may be long, tough and hard to find but you can do i... Well, i dont know if you can but at least give it a chance. [wave]Good luck[/wave].";
testDialog	= "Hi. Welcome our [wobble][rainbow]PuB[/wobble][/rainbow]. If you want to fuck some ass you can come here. [/c][c_red][wave](or if you want to get fucked by somebody)[/]";
text		= testDialog;
showText	= false;
width		= 0;
height		= 0;
margin		= 5;
texAlpha	= 0.8;
element		= scribble(text)
	.typewriter_in(1, 60)
	.typewriter_ease(SCRIBBLE_EASE.ELASTIC, 0, -25, 1, 1, 0, 0.1)
	//.animation_wave(3, 5, 0.2)
	//.animation_wobble(30, 0.2)
	//.animation_rainbow(1, 0.2)
element.typewriter_reset();	

findFirstWord = function(_text)
{
	var i = 0; repeat(string_length(_text))
	{
		var c = string_char_at(_text, i);
		if (c == " " || c == "." || c == ",")
		{
			var word = string_copy(_text, 1, i - 1);
			return word;
			break;
		}	
		i++;
	}
	return "";
}

// Sound
popSound	= aPop;
popPlayed	= false;

// States
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
		if (position_meeting(mouse_x, mouse_y, self))
		{ // Hovering Mouse
			showText = true;
			blend.set(c_white, 0.8);
			scale.set(upScale.x, upScale.y);
			if (!popPlayed)
			{
				var p = audio_play_sound(aPop, 2, false);
				audio_sound_pitch(p, random_range(1, 1.05));
				popPlayed = true;
			}
			if (width =! sprite_width && height =! sprite_height)
			{
				width = bbox_right - bbox_left;
				height = bbox_bottom - bbox_top;
			}
			if (InputManager.clickLeftPressed)
			{
				state.change("min")
			}

		}
		else
		{
			showText = false;
			popPlayed = false;
			element.typewriter_reset();
			blend.set(c_dkgray, 0.6);
			scale.set(downScale.x, downScale.y);
		}
	}
});

state.add("min", {
	enter: function()
	{
		element.typewriter_reset();
		showText = false;
		scale.set(0.1, 0.1);
		var p = audio_play_sound(aPop, 2, false);
		audio_sound_pitch(p, random_range(0.5, 0.55));
		popPlayed = true;
		image_index = 1;
	},
	step: function()
	{
		if (image_xscale == scale.x && image_yscale == scale.y)
		{
			var box = instance_create_layer(irandom_range(0, room_width), irandom_range(0, room_height), "Textboxes", objTextbox);
			box.scale.set(random_range(2, 4), random_range(2, 4));
			instance_destroy(self);
		}
	}
});
