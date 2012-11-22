require "CiderDebugger";-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
--Debug the smart way with Cider!
--start coding and press the debug button

local widget = require( "widget" )

display.setStatusBar(display.HiddenStatusBar)

--- add background
local gameview = display.newImage("gameview.png") 
gameview:setReferencePoint(display.TopLeftReferencePoint)
gameview.screenWidth = gameview.width;
gameview.x = 0
gameview.y = -200

--- add tree
local trees         = display.newImage("trees.png", 0, 150)
trees.screenWidth   = trees.width
local trees_2       = display.newImage("trees.png", trees.width, 150)
trees_2.screenWidth = trees_2.width

-- add button
local pitchButtonPressed = function( event )
    Zoom(1)
    
end
local pauseButtonPressed = function( event )
    Zoom(-1)
    
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

local function move(event)
	
	local tDelta = event.time - tPrevious
	tPrevious = event.time

	local xOffset = ( 0.2 * tDelta )
        
        trees.x   = trees.x - xOffset
	trees_2.x = trees_2.x - xOffset
        
        if trees.x < 0 - trees.screenWidth/2 then
		trees.x   = trees_2.x + trees.screenWidth
	end
	if trees_2.x < 0 - trees_2.screenWidth/2 then
		trees_2.x = trees.x + trees.screenWidth
	end
	
end        

Runtime:addEventListener("enterFrame",move)




--- Declare function for maps

-- scale property
gameviewScale = 0.001;
treeScale     = 0.01;

local function zoomObject(object, scale)
    object.xScale = object.xScale + scale;
    object.yScale = object.yScale + scale;
    
    object.screenWidth = object.width * object.xScale
end

function Zoom(ratio)
    -- Zoom object in Game
    zoomObject(gameview, gameviewScale*ratio)
    zoomObject(trees,    treeScale*ratio)
    zoomObject(trees_2,  treeScale*ratio)
    
    
    print(trees.screenWidth)
    -- Recalc positon of parallax
    if (trees.x < trees_2.x) then
        trees_2.x = trees.x + trees.screenWidth
    else
        trees.x   = trees_2.x + trees.screenWidth
    end
end