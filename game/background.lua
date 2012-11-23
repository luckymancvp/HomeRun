module(...,package.seeall)
local widget = require( "widget" )


function createGround()
  local physics = require("game.physics").instance()
  local localGroup = display.newGroup()
  --local bgImg = display.newImageRect("stripes.png", 480 , 320)
--  bgImg.x = 240
--  bgImg.y = 160
 -- bgImg:setReferencePoint( display.BottomLeftReferencePoint )
 -- localGroup:insert(bgImg)
  
  
  borderCollisionFilter = { categoryBits = 1, maskBits = 14 } -- collides with (8 & 4 & 2) only
  borderBodyElement = { friction=1, bounce=1.1, filter=borderCollisionFilter }
  local borderBottom = display.newRect( -960, 318, 2700, 2 )
  borderBottom:setFillColor( 1, 0, 1, 1)		-- make 
  borderBottom.name = "ground"  
  physics.addBody( borderBottom, "static", borderBodyElement )
  
--  borderBottom.x =100
--  borderBottom.y = 100
	localGroup:insert(borderBottom)
  
  return localGroup

end