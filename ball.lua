
local function createBall()
    --- add ball
    local physics = require ("game.physics").instance()
    balls    = require ("game.ball").instance()  
    balls.x = 200
    balls.y = 0
    print(balls.x)
    balls:applyForce ( 0,0,balls.x,balls.y)    
         
    x0 = balls.x
    y0 = balls.y
    g = 10
    v0 = 1
    alpha = 45
    game:insert(balls)
    
end


markedY = 70   -- Start zoom effect
minY    = 25   -- keep ball be not smaller when its y axis < minY

bgY     = 30   -- distance offset of background

previousX = 0

createBall()
local function mapControl(event)
    
    
    balls:rotate(40)
 
    -- Parse 1
    if (balls.y < 320) and (balls.y >= markedY) then
        -- Let ball move itself
    end
    
    -- Parse 2
    if (balls.y < markedY) and (balls.y >= minY) then
        -- start move background and scale ball
        
        game.x = game.x + (previousX - balls.x)
        gameviewGroup.x = gameviewGroup.x + (previousX - balls.x)*3

        gameviewGroup.y = (markedY - balls.y) / (markedY - minY) * bgY - game.y
        
        -- Zoom effect
        scaleRatio = (balls.y - markedY) / (minY - markedY) * 0.5
        balls.xScale = 1 - scaleRatio
        balls.yScale = 1 - scaleRatio
    end
    
    -- Parse 3
    if (balls.y < minY) then 
        -- keep balls in screen
        
        game.x = game.x + (previousX - balls.x)
        game.y = minY - balls.y    -- keep balls in screen
        
        gameviewGroup.x = gameviewGroup.x + (previousX - balls.x)*3
        gameviewGroup.y = bgY - game.y
    end
    
    -- Update previous position of balls
    previousX = balls.x
end

Runtime:addEventListener("enterFrame",mapControl)


local function mapControlQuan(event)
    game.x = 120 - balls.x
    game.y = 120 - balls.y
    
    gameviewGroup.x = 0 - game.x
    gameviewGroup.y = 0 - game.y
    
    x0 = balls.x
    y0 = balls.y
end
--Runtime:addEventListener("enterFrame",mapControlQuan)
