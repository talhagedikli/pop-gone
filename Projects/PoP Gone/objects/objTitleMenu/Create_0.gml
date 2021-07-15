/// @description 

enum menus {
	main,
	start,
	settings,
	quit,
	length
}


menu = [
	["START", "SETTINGS", "QUIT"],		// Main
	[ ],								// Start
	["VOLUME", "RESOLUTION", "BACK"],	// Settings
	[ ]									// Quit
];
text	= ""
element = scribble(text);
element.starting_format("fntMenu", c_white);

menuLevel = menus.main;
pos = 0;










