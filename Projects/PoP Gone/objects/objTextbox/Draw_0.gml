/// @description Insert description here
// You can write your code in this editor
draw_self();

if (showText)
{
	//Get the text element for our current line of text
	//Note that we're setting "textbox_element" here
	element = scribble(text[index])
	.starting_format("fntText", c_black)
	.typewriter_in(skip ? 9999 : 1, 0, 60)
	.typewriter_ease(SCRIBBLE_EASE.ELASTIC, 0, -25, 1, 1, 0, 0.1)
	.wrap(width, height)
	.align(fa_left, fa_top);

	//Draw main text body
	element.draw(bbox_left + margin, bbox_top + margin);
	
}