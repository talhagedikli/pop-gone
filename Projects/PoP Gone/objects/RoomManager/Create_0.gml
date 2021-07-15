/// @description 
switched = false;
currentRoom = rTitle;

#macro GRID_W 32
#macro GRID_H 32

checkRoom = function()
{
	if (currentRoom != room) {
		currentRoom = room;
		return true;
	}
	return false;
};

grid = [
	[ [] ],
	[ [] ]
];


createGrid = function()
{
	var i = 0; repeat(room_width div 32)
	{
		array_push(grid[0], i);
		i++
	}

	var i = 0; repeat(room_height div 32)
	{
		array_push(grid[1], i);
		i++
	}
}

state = new SnowState(room_get_name(rTitle));
state
	.history_enable()
	.set_history_max_size(15)
	
	.add(room_get_name(rTitle), {	// ----------TITLE
	enter: function() 
	{
	},
	step: function()
	{
	},
	leave: function() 
	{
	}
})
	
	.add(room_get_name(rWorld), {	// ----------WORLD
	enter: function() 
	{
		var text0 = [
			"text0 text0 text0 text0 text0 text0 text0 text0 text0 text0 ",
			"tex0 tex0 tex0 tex0 tex0 tex0 tex0 tex0 tex0 tex0 tex0 tex0 ",
			"te0 te0 te0 te0 te0 te0 te0 te0 te0 te0 te0 te0 te0 te0 te0 "
		];
		var text1 = [
			"[wave]text1 text1 text1 text1 text1 text1 text1 text1 text1 text1[/] ",
			"[wave]tex1 tex1 tex1 tex1 tex1 tex1 tex1 tex1 tex1 tex1 tex1 tex1[/] ",
			"[wave]te1 te1 te1 te1 te1 te1 te1 te1 te1 te1 te1 te1 te1 te1 te1[/] "
		];
		var text2 = [
			"[wave][rainbow]text2 text2 text2[/page] text2 text2 [/page]text2 text2 text2 text2 text2[/] ",
			"[wave][rainbow]tex2 tex2 tex2 tex2 tex2 tex2 tex2 tex2 tex2 tex2 tex2 tex2[/] ",
			"[wave][rainbow]te2 te2 te2 te2 te2 te2 te2 te2 te2 te2 te2 te2 te2 te2 te2[/] "
		];
		
		var tb0	= new Textbox(120, 120, 4, 2, text0);
		var tb1	= new Textbox(450, 340, 3, 2, text1);
		var tb2	= new Textbox(300, 220, 2, 5, text2);
	},
	step: function()
	{	

	},
	leave: function() 
	{
	}
})













