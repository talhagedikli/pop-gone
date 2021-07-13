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
		
	},
	step: function()
	{
	

	},
	leave: function() 
	{
	}
})













