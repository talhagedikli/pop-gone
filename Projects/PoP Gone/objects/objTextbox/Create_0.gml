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
text		= [
	"Hi. Welcome our [wobble][rainbow]PuB[/wobble][/rainbow]. If you want to fuck some ass you can come here. [/c][c_red][wave](or if you want to get fucked by somebody)[/]",
	"Hi. Welcome our [shake][rainbow]PuB[/shake][/rainbow]. If you want to fuck some ass you can come here. [/c][c_white][jitter](or if you want to get fucked by somebody)[/]"
];
index		= 0;
showText	= false;
width		= 0;
height		= 0;
margin		= 5;
texAlpha	= 0.8;
skip		= false;

element		= scribble(text);
element
.typewriter_in(1, 60)
.typewriter_ease(SCRIBBLE_EASE.ELASTIC, 0, -25, 1, 1, 0, 0.1)
	//.animation_wave(3, 5, 0.2)
	//.animation_wobble(30, 0.2)
	//.animation_rainbow(1, 0.2)
element.typewriter_reset();
element.page(0);

element.starting_format("fntText", c_black);

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
state = new SnowState("fadein");

state.add("fadein", {
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
		// Extra scale when hovering or not
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
			// Reset box stuff
			blend.set(c_white, 0.8);
			scale.set(upScale.x, upScale.y);
			// Play pop fadein sound once
			if (!popPlayed)
			{
				var p = audio_play_sound(aPop, 2, false);
				audio_sound_pitch(p, random_range(1, 1.05));
				popPlayed = true;
			}
			// Calculate wrap width and height
			if (width =! sprite_width && height =! sprite_height)
			{
				width = bbox_right - bbox_left;
				height = bbox_bottom - bbox_top;
			}
			if (InputManager.clickLeftPressed)
			{
				state.change("fadeout")
			}

		}
		else
		{
			// Play pop sound once
			popPlayed = false;
			// Reset the typewriter then close the scribble drawing
			
			if (element.get_typewriter_state() =! 0)	element.typewriter_reset();
			if (element.get_page() =! 0)				element.page(0);
			showText = false;
			// Reset box stuff
			blend.set(c_dkgray, 0.6);
			scale.set(downScale.x, downScale.y);
		}
	}
});

state.add("fadeout", {
	enter: function()
	{
		// Reset the scribble then close the scribble drawing
		element.typewriter_reset();
		element.page(0);
		index = 0;
		showText = false;
		// Reset box stuff
		scale.set(0.1, 0.1);
		// Play fadeout audio once
		var p = audio_play_sound(aPop, 2, false);
		audio_sound_pitch(p, random_range(0.5, 0.55));
		popPlayed = true;
		// Go to smaller sprite index
		image_index = 1;
	},
	step: function()
	{
		// When fade out create new textbox and destroy itself
		if (image_xscale == scale.x && image_yscale == scale.y)
		{
			var mboxw, mboxh, minscl, maxscl;
			minscl = 2;
			maxscl = 4;
			mboxw = sprite_get_width(sprTextbox) * minscl;
			mboxh = sprite_get_height(sprTextbox) * maxscl;
			//var box = instance_create_layer(irandom_range(0 + mboxw, room_width - mboxw), 
			//			irandom_range(0 + mboxh, room_height - mboxh), "Textboxes", objTextbox);
			//box.scale.set(random_range(minscl, maxscl), random_range(minscl, maxscl));
			instance_destroy(self);
		}
	}
});
