module(...,package.seeall)
local physics = nil


function instance()
  if physics == nil then
  	print ("physics")
     physics = require("physics")
     --physics.setDrawMode( "hybrid" )
     return physics
  else 
  	 return physics
  end
end

