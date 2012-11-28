module(...,package.seeall)
function newEffect(degree)
	local directX = math.sin(degree)
	local directY = -math.cos(degree)

	local distance = 100
	local element = display.newImageRect("images/particle1.png",30,30)
	local function complete()

		element:removeSelf()
	end
	function element: startAnim()

		local _x = self.x
		local _y = self.y
	transition.to(self,{time = 900,alpha = 0,x =  _x+distance* directX, y = _y+distance*directY,xScale = 2,yScale = 2,onComplete = complete})
	end	
	return element
end