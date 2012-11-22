require "CiderDebugger";-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
--Debug the smart way with Cider!
--start coding and press the debug button

local widget = require( "widget" )

display.setStatusBar(display.HiddenStatusBar)

local function absX(object)
    return object.x + object.parent.x
end

local function createGameview()
    --- add background
    gameview = display.newImage("gameview.png") 
    gameview:setReferencePoint(display.TopLeftReferencePoint) 
    gameview.screenWidth = gameview.width;
    gameview.x = 0
    gameview.y = -200
    
    game:insert(gameview)
end

local function createTrees()
    --- add tree
    trees_1             = display.newImage("trees.png", 0, 150)
    trees_1.screenWidth = trees_1.width
    trees_2             = display.newImage("trees.png", trees_1.width, 150)
    trees_2.screenWidth = trees_2.width

    game:insert(trees_1)
    game:insert(trees_2)
end

local function createBall()
    --- add tree
    balls               = display.newImage("gameview_ball1.png", 40, 150)
    
    game:insert(balls)
end

local function initGame()
    -- Create master display group (for global "camera" scrolling effect)
    game = display.newGroup();
    game.x = 0
    
    createGameview()
    createTrees()
    createBall()
    
end

initGame()


-- add button
local pitchButtonPressed = function( event )
    ZoomMap(1)
    
end
local pauseButtonPressed = function( event )
    ZoomMap(-1)
    
end

local pitchButton = widget.newButton{
	default = "gameview_pitch.png",
	onPress = pitchButtonPressed
}
pitchButton.x = 40;pitchButton.y = 270
local pauseButton = widget.newButton{
	default = "gameview_pause.png",
	onPress = pauseButtonPressed
}
pauseButton.x = 450; pauseButton.y = 270;

local tPrevious = system.getTimer()

local function onScreenWidth(object)
    return object.width * object.xScale
end

local function mapControl(event)
    ForwardMap(1)
end

local function ballMove(event)
	
	local tDelta = event.time - tPrevious
	tPrevious = event.time

	local xOffset = ( 0.2 * tDelta )
        
        balls.x = balls.x + xOffset
        game.x  = game.x - xOffset
        
        balls.rotate(balls, 10)
	
end  

Runtime:addEventListener("enterFrame",mapControl)
Runtime:addEventListener("enterFrame",ballMove)



--- Declare function for maps

-- scale property
gameviewScale = 0.001;
treeScale     = 0.01;

local function zoomObject(object, scale)
    object.xScale = object.xScale + scale;
    object.yScale = object.yScale + scale;
    
    object.screenWidth = object.width * object.xScale
end

function ZoomMap(ratio)
    -- Zoom object in Game
    zoomObject(gameview, gameviewScale*ratio)
    zoomObject(trees_1,  treeScale*ratio)
    zoomObject(trees_2,  treeScale*ratio)
    
    
    -- Recalc positon of parallax
    if (trees_1.x < trees_2.x) then
        trees_2.x = trees_1.x + trees_1.screenWidth
    else
        trees_1.x = trees_2.x + trees_1.screenWidth
    end
end

function ForwardMap(speed)
    -- check map in screen of device
    if (absX(trees_1) < 0 - trees_1.screenWidth /2) then
        trees_1.x = trees_2.x + trees_1.screenWidth
    end
    if (absX(trees_2) < 0 - trees_1.screenWidth /2) then
        trees_2.x = trees_1.x + trees_1.screenWidth
    end
    
end
