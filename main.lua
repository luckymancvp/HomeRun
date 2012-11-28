require "CiderDebugger";-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
--Debug the smart way with Cider!
--start coding and press the debug button
local director = require ("director")
--> Imports director


 local physics = require ("game.physics").instance()
 physics.start()



local mainGroup = display.newGroup()
--> Creates a main group

local function main()
--> Adds main function

	
	mainGroup:insert(director.directorView)
	--> Adds the group from director
	
	director:changeScene("gameview")
	--> Change the scene, no effects
	
	return true
end

main()
--> Starts our app

	
