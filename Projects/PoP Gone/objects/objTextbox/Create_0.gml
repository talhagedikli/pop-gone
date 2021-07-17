#region Create----------------------------------------------------------------------------------------
// Textbox setup
scale		= new Vector2(0, 0);
blend		= new Vector2(c_dkgray, 0.6);
upScale		= new Vector2();
downScale	= new Vector2();
// Textbox defaults
image_index		= 0;
image_speed		= 0;
image_xscale	= scale.x;
image_yscale	= scale.y;
image_blend		= blend.x;
image_alpha		= blend.y;

bounceTween = new TweenV2(tweenType.BOUNCEEASEIN);

// Textbox text
text		= [
	"Hi. Welcome our [wobble][rainbow]PuB[/wobble][/rainbow]. If you want to fuck some ass you can come here. [/c][c_red][wave](or if you want to get fucked by somebody)[/]"
];
skip		= false;
index		= 0;
showText	= false;
// Textbox apperance
width		= 0;
height		= 0;
margin		= 5;
texAlpha	= 0.8;

// Scribble element
element		= SCRIBBLE_NULL_ELEMENT;
// Sound
popSound	= aPop;
popPlayed	= false;
#endregion

#region Functions-------------------------------------------------------------------------------------
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

controlPageAndIndex = function()
{
	if (keyboard_check_pressed(vk_space))
	{
	    if (element.get_typewriter_paused())
	    {
			//If we're paused, unpause!
			element.typewriter_unpause(false);
	    }
	    else if (element.get_typewriter_state() >= 1)
	    {
			skip = false;
	        if (element.get_page() < element.get_pages() - 1)
	        {
	            //Otherwise move to the next page
				element.page(element.get_page() + 1);
				element.typewriter_reset();
	        }
	        else
	        {
	            //Increment our conversation index for the next piece of text
				index = (index + 1) mod array_length(text);
				element.page(0);
				element.typewriter_reset();
	        }
	    }
	    else
	    {
			skip = true;
	    }
	}
}

createRandomTextbox = function()
{
	// Randomly create textbox
	var mboxw, mboxh, minscl, maxscl;
	minscl = 2;
	maxscl = 4;
	mboxw = sprite_get_width(sprTextbox) * minscl;
	mboxh = sprite_get_height(sprTextbox) * maxscl;
	var box = instance_create_layer(irandom_range(0 + mboxw, room_width - mboxw), 
				irandom_range(0 + mboxh, room_height - mboxh), "Textboxes", objTextbox);
	box.scale.set(random_range(minscl, maxscl), random_range(minscl, maxscl));
}
#endregion

#region States----------------------------------------------------------------------------------------
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
			if (!showText)
			{
				showText = true;
				// Play pop sound when hovering
				var p = audio_play_sound(aPop, 2, false);
				audio_sound_pitch(p, random_range(1, 1.05));
			}
			else
			{
				// If showing text
				controlPageAndIndex();
			}
			// Reset box stuff
			blend.set(c_white, 0.8);
			scale.set(upScale.x, upScale.y);
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
			
			if (element.get_typewriter_state() > 0)		element.typewriter_reset();
			if (element.get_page() > 0)					element.page(0);
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
			// createRandomTextbox();
			instance_destroy(self);
		}
	}
});
#endregion

