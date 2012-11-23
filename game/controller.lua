
module (...,package.seeall)
local controller 
local ball = require ("game.ball").instance()
local physics = require ("game.physics").instance()
local state = require ("game.ballState")

function instance ()
	
end
-- nem bong 
function thowBall()
	ball.x = 100
    ball.y = 50
    ball:applyForce(-5, 0,ball.x, ball.y )
	ball.state = state.standing
	
end
--danh bong tai diem pointX,pointY  voi do lon luc 2 phuong x, y la forceX va forceY
function hitBall(forceX,forceY,pointX,pointY)
	 ball:applyForce(forceX, forceY,ball.x, ball.y )
	 ball.state = state.flying
end

--v a vao bong bay
function eatFlyBall()
	
end

function collideGround()
	ball.state = state.stoping
end