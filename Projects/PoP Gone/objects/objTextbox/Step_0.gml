state.step();

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

texAlpha = showText ? approach(texAlpha, 1, 0.1) : approach(texAlpha, 0, 0.1);