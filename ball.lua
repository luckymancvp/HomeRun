
local function createBall()
    --- add ball
    balls               = display.newImage("images/gameview_ball1.png", 40, 150)
    x0 = balls.x
    y0 = balls.y
    g = 10
    v0 = 1
    alpha = 45
    game:insert(balls)
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

Runtime:addEventListener("enterFrame",ballMove)

