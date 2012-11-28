
module(..., package.seeall)
 local physics = require ("game.physics").instance()
local map = require "map"
local ui = require ("game.ui")
local controller = 	require "game.controller"

function update(event)
    local ball = require ("game.ball").instance()
    print ("AAAA")
    if ball.x < 240 then
        ball:applyForce(0, 0, 45, 45 )
    end
end
function new()
	local localGroup = display.newGroup()
	--> This is how we start every single file or "screen" in our folder, except for main.lua
	-- and director.lua
	--> director.lua is NEVER modified, while only one line in main.lua changes, described in that file
------------------------------------------------------------------------------
------------------------------------------------------------------------------
 physics.start()
  local mapview = map.initGame()
  
  local uiview =ui.initUI()
   controller.init()
	
    
  localGroup:insert(mapview)
  localGroup:insert(uiview)
  

	controller.startGame()
        
        Runtime:addEventListener("enterFrame",update)
        
------------------------------------------------------------------------------
------------------------------------------------------------------------------
	return localGroup
end
--> This is how we end every file except for director and main, as mentioned in my first comment


