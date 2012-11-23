module(...,package.seeall)

local ball = nil
local state = require("game.ballState")
--local controller = require ("game.controller").instance()

function  instance()
	print ("ball instance")
	if ball == nil then
		ball = createBall()
	end
	return ball
end

local function onTouch(event)
	print (event.phase)
	local physics = require("game.physics").instance()
	local ball = event.target
	--if event.phase == "began" then
		ball:applyForce( 5, 2, ball.x, ball.y )
	--end
	
	return true
end


local function onLocalCollision(  event )
	    local target = event.target
	    local objname = event.other.name
        if ( event.phase == "began" ) then
 
                print( target.name .. ": collision began with " .. event.other.name )
                if objname == "flyBall" then
                	
                elseif objname == "round" then
                
                end
                
                 
                	
 
        elseif ( event.phase == "ended" ) then
 
                print( target.name .. ": collision ended with " .. event.other.name )
 
        end
end
 


function createBall()
	print ("create ball")
  local physics = require("game.physics").instance()
  local ball = display.newImageRect("images/gameview_ball1.png", 30 , 30)
  ball.name = "ball"
  ball.state = state.none

   
  borderCollisionFilter = { categoryBits = 2, maskBits = 15 } -- collides with (8 & 4 & 2 & 1) only
  borderBodyElement = {  density=0.3,friction=0.1,bounce = 1, radius=15.0, filter=borderCollisionFilter }
  
  physics.addBody( ball, "dynamic", borderBodyElement )
  ball:addEventListener("touch",onTouch)
  ball:addEventListener( "collision", onLocalCollision )
  return ball

end