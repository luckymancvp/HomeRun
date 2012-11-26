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

local function mapControl(event)
    ForwardMap(1)
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

