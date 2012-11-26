module (...,package.seeall)

local widget = require( "widget" )

display.setStatusBar(display.HiddenStatusBar)

local function absX(object)
    return object.x + object.parent.x
end

local function createGameview()
    --- add background
    gameviewGroup = display.newGroup()
    for i = 0, 1, 1 do
        local gameview = display.newImage("images/gameview.png", i*512, -190)
        gameviewGroup:insert(gameview)
    end
    
    game:insert(gameviewGroup)
    local ground = require ("game.ground").createGround()
    game:insert(ground)
end

local function createTrees()
    --- add tree
    treesGroup = display.newGroup()
    for i = 0, 5, 1 do
         local tree = display.newImage("images/trees.png", 512 * i, 150)
         treesGroup:insert(tree)
    end
    
    game:insert(treesGroup)
end

local function createItem()
    bar = display.newImage("images/bar.png", 20, 80)
    
    game:insert(bar)
end

local function initGame()
    -- Create master display group (for global "camera" scrolling effect)
    game = display.newGroup();
    
    createGameview()
    --createTrees()
    --createItem()
    
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
	default = "images/gameview_pitch.png",
	onPress = pitchButtonPressed
}
pitchButton.x = 40;pitchButton.y = 280
local pauseButton = widget.newButton{
	default = "images/gameview_pause.png",
	onPress = pauseButtonPressed
}
pauseButton.x = 450; pauseButton.y = 280;

local function onScreenWidth(object)
    return object.width * object.xScale
end

--Runtime:addEventListener("enterFrame",mapControl)
--- Declare function for maps

-- scale property
gameviewScale = 0.005;
treeScale     = 0.01;

local function zoomObject(object, scale)
    object.xScale = object.xScale + scale;
    object.yScale = object.yScale + scale;
    
end

local function zoomObjectTo(object, scale)
    object.xScale = scale;
    object.yScale = scale;
    
end

function ZoomMap(ratio)
    -- Zoom object in Game
    zoomObject(treesGroup,    treeScale * ratio)
    zoomObject(gameviewGroup, gameviewScale* ratio)
end

function ZoomMapTo(ratio)
    -- Zoom object in Game to specific ratio
    --zoomObjectTo(treesGroup,    ratio)
    zoomObjectTo(gameviewGroup, ratio)
end

------------------------- Map follow balls Control function --------------------

local balls    = require ("game.ball").instance() 

local markedY = 70   -- Start zoom effect
local minY    = 25   -- keep ball be not smaller when its y axis < minY

local bgY     = 30   -- distance offset of background

local previousX = 0

local function mapControl(event)
    
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

------------------------- Map Control function ---------------------------------

local isFollowBalls = false -- Map state

function resetMap()
    -- Reset map to start position
    game.x = 0; gameviewGroup.x = 0;
    game.y = 0; gameviewGroup.y = 0;
end

function setMapFollowBalls(status)
    if (status == true) then
        Runtime:addEventListener("enterFrame",mapControl)
    else
        Runtime:removeEventListener("enterFrame", mapControl)
    end
end
