
local function createBall()
    --- add ball
    local physics = require ("game.physics").instance()
    balls    = require ("game.ball").instance()  
    balls.x = 100
    balls.y = 320
    
    balls:applyForce ( 10,-130,balls.x,balls.y)    
         
    x0 = balls.x
    y0 = balls.y
    g = 10
    v0 = 1
    alpha = 45
    --game:insert(balls)
    
end


createBall()

local tPrevious = system.getTimer()
local function ballMove(event)
	
	local tDelta = event.time - tPrevious
	tPrevious = event.time

	local xOffset = ( 0.2 * tDelta )
        
        t = 1
        balls.x = x0 + v0*math.cos(alpha)*t
        balls.y = v0*math.sin(alpha)*t-g*t*t/2 + y0
        --game.x  = game.x - xOffset
        
        --gameviewGroup.x = gameviewGroup.x + xOffset*5/6
        
        balls.rotate(balls, 10)
	
end  

--Runtime:addEventListener("enterFrame",ballMove)

