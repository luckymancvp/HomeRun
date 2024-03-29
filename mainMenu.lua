

module(..., package.seeall)


local widget = require( "widget" )
function new()
	local localGroup = display.newGroup()
	--> This is how we start every single file or "screen" in our folder, except for main.lua
	-- and director.lua
	--> director.lua is NEVER modified, while only one line in main.lua changes, described in that file
------------------------------------------------------------------------------
------------------------------------------------------------------------------
local background = display.newImage ("images/logoView.png")
localGroup:insert(background)
--> This sets the background

local backbutton = display.newImage ("images/title_start_game.png")
backbutton.x = 380
backbutton.y = 200
localGroup:insert(backbutton)
--> This places our "back" button

local function startButtonPressed(event)
		director:changeScene ("profileview")
		return true
	end
	
	local start = widget.newButton{
		default = "images/title_start_game.png",
		over = "images/title_start_game_down.png",
		label = "User Profile", 
		onPress = startButtonPressed
	}
	start.x = 380; start.y = 250;
	localGroup:insert(start)

	local function pressBack (event)
		if event.phase == "ended" then
			director:changeScene ("gameview")
		end
	end

	backbutton:addEventListener ("touch", pressBack)
--> This adds the function and listener to the "back" button

------------------------------------------------------------------------------
------------------------------------------------------------------------------
	return localGroup
end