module(...,package.seeall)

local ball = nil
local state = require("game.ballState")
local controller = require ("game.controller")
local effect = require ("game.ballEffect")
local data = require("game.data")

function  instance()
	print ("ball instance")
	if ball == nil then
		ball = createBall()
	end
	return ball
end
function destroyBall()
	ball:removeSelf()
	ball = nil
end
local function onTouch(event)
	print (event.phase)
	
	local physics = require("game.physics").instance()
	--local ball = event.target
	--if event.phase == "began" then
		print ("ontouch : state :"..ball.state)
		if ball.state == state.throwing then
			--danh bong khi bong duoc nem
			print "danh cai nao"
			for i = 1,10 do 
				local _ef = effect.newEffect(36*(i-1))
				_ef.x = ball.x
				_ef.y = ball.y
				_ef:startAnim()
			end
			controller.hitBall(event.x,event.y)
			--ball:applyForce( 200, -100, ball.x, ball.y )
			ball.state = state.flying
		else
			-- chua nem danh the deo nao duoc
			print "chua nem danh the deo nao duoc"
		end
	--end
	
	return true
end


local function onLocalCollision(  event )
	    local target = event.target
	    local objname = event.other.name
        if ( event.phase == "began" ) then
 
                print( target.name .. ": collision began with " .. event.other.name )
                if objname == "flyBall" then
                	
                elseif objname == "ground" then
                  controller.collideGround()
                end

        elseif ( event.phase == "ended" ) then
 
                print( target.name .. ": collision ended with " .. event.other.name )
 
        end
end
 

function createBall()
  print ("create ball")
  local physics = require("game.physics").instance()
  local ball = display.newImageRect("images/gameview_ball1.png", 30 , 30)
  ball.name = "ball"
  ball.state = state.none
  ball.follow = display.newImageRect("images/gameview_ball1.png",  data.BALL_FOLLOW_RECT,data.BALL_FOLLOW_RECT)
  ball.follow.alpha = 0.01
   
  borderCollisionFilter = { categoryBits = 2, maskBits = 15 } -- collides with (8 & 4 & 2 & 1) only
  borderBodyElement = {  density=0.3,friction=0.1,bounce = 1, radius=15, filter=borderCollisionFilter }
  
  physics.addBody( ball, "static", borderBodyElement )
  
  local function  onEnter(event)
  	
  	ball.follow.x = ball.x
  	ball.follow.y = ball.y
  end
  ball.follow:addEventListener("touch",onTouch)
  ball:addEventListener( "collision", onLocalCollision )
  Runtime:addEventListener("enterFrame",onEnter)
  return ball

end