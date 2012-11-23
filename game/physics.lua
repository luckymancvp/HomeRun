module(...,package.seeall)
local physics = nil
function instance()
  if physics == nil then
     physics = require("physics")
     physics.setDrawMode( "hybrid" )
     return physics
  else 
  	 return physics
  end
end

function startPhysics()
	physics.start()
end