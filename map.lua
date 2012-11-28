module (...,package.seeall)

local widget = require( "widget" )

display.setStatusBar(display.HiddenStatusBar)

local function absX(object)
    return object.x + object.parent.x
end

local function createGameview()
    --- add background
    gameviewGroup = display.newGroup()
    for i = 0, 50, 1 do
        local gameview = display.newImage("images/gameview.png", i*512, -190)
        gameviewGroup:insert(gameview)
    end
    
    game:insert(gameviewGroup)
    
    -- add physic ground
    local ground = require ("game.ground").createGround()
    game:insert(ground)
end

local function createTrees()
    --- add tree
    treesGroup = display.newGroup()
    for i = 0, 50, 1 do
         local tree = display.newImage("images/trees.png", 512 * i, 0)
         treesGroup:insert(tree)
    end
    
    treesGroup:setReferencePoint(display.BottomLeftReferencePoint)
    treesGroup.y = 320
    
    game:insert(treesGroup)
end

local function createItem()
    -- add item
    itemsGroup = display.newGroup()
    
    itemDatas = {
        { image = "images/bar.png", x = 500},
        { image = "images/bus.png", x = 700},
        { image = "images/car1.png", x = 900},
        { image = "images/car2.png", x = 1100},
    }
    
    for key, item in pairs(itemDatas) do
        local newItem = display.newImage(item["image"], item["x"], 320)
        newItem:setReferencePoint(display.BottomLeftReferencePoint)
        newItem.y = 320
        itemsGroup:insert(newItem)
        print(newItem.y)
    end
    
    
    itemsGroup:setReferencePoint(display.BottomLeftReferencePoint)
    itemsGroup.y = 320
    game:insert(itemsGroup)
end

function initGame()
    -- Create master display group (for global "camera" scrolling effect)
    game = display.newGroup();
    
    
    createGameview()
    createTrees()
    createItem()
    
    
    local balls    = require ("game.ball").instance()
    game:insert(balls)
    
    return game
    
end

------------------------- Map follow balls Control function --------------------

local balls    = require ("game.ball").instance() 

local markedY = 70   -- Start zoom effect
local minY    = 25   -- keep ball be not smaller when its y axis < minY

local bgY     = 30   -- distance offset of background

local boundRightX = 400

local previousX = 0

local function mapControl(event)
    -- Parse 1
    if (balls.y < 320) and (balls.y >= markedY) then
        -- Let ball move itself
        -- Check bound
        if ( balls.x >= boundRightX) then
            game.x = game.x + (previousX - balls.x)
        end
    end
    
    -- Parse 2
    if (balls.y < markedY) and (balls.y >= minY) then
        -- start move background and scale ball
        print("Enter parse 2")
        
        game.x = game.x + (previousX - balls.x)
        gameviewGroup.x = gameviewGroup.x + (previousX - balls.x)*2

        gameviewGroup.y = (markedY - balls.y) / (markedY - minY) * bgY - game.y
        
        -- Zoom effect
        scaleRatio = (balls.y - markedY) / (minY - markedY) * 0.5
        balls.xScale = 1 - scaleRatio
        balls.yScale = 1 - scaleRatio
        
        ZoomMap((balls.y - markedY) / (minY - markedY))
    end
    
    -- Parse 3
    if (balls.y < minY) then 
        -- keep balls in screen
        print("Enter parse 3")
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

local function zoomObject(object, scale)
    object.xScale = scale;
    object.yScale = scale;
    
end

function ZoomMap(ratio)
    ratio = 1 - ratio * 0.3
    zoomObject( treesGroup, ratio)
end
