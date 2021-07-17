// Init fonts
scribble_font_add_all();

#region Functions and constructors
function Textbox(_x, _y, _xscl = 1, _yscl = 1, _text = [""]) constructor
{
	textBox			= instance_create_layer(_x, _y, "Textboxes", objTextbox);
	textBox.scale.x = _xscl;
	textBox.scale.y = _yscl;
	textBox.text	= _text;
	
	static reCreate		= function(_x, _y, _xscl = 1, _yscl = 1, _text = [""])
	{
		destroy();
		textBox			= instance_create_layer(_x, _y, "Textboxes", objTextbox);
		textBox.scale.x = _xscl;
		textBox.scale.y = _yscl;
		textBox.text	= _text;
		return self;
	}
	static setPosition = function(_x, _y)
	{
		textBox.x = _x;
		textBox.y = _y;
		return self;
	}
	static setScale		= function(_xscl, _yscl)
	{
		textBox.scale.x = _xscl;
		textBox.scale.y = _yscl;
		return self;
	}
	static setText		= function(_text)
	{
		textBox.text = _text;
		return self;
	}
	static get			= function()
	{
		return textBox;
	}
	static destroy		= function()
	{
		textBox.state.change("fadeout");
		return self;
	}
}
#endregion