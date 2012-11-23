
module (...,package.seeall)


local ball 
local physics 
local state
function init()
	 ball = require ("game.ball").instance()
 	physics = require ("game.physics").instance()
 	state = require ("game.ballState")
 	
 	
end

-- nem bong 
function throwBall()
	ball.bodyType = "static"
	ball.x = 490
    ball.y = 50
    ball.bodyType = "dynamic"
    ball:applyForce(-90, 0,ball.x, ball.y )
	ball.state = state.throwing
	
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
	if ball.state == state.throwing then
	-- danh truot
		print "collideGround : danh truot"
	elseif ball.state == state.flying then
	-- danh trung bong tinh khoang cach danh duoc	
	  print "collideGround : danh trung"
	else
	end
	ball.state = state.stoping
	timer.performWithDelay(1000, reHit)


end

--danh lai neu nhu con luot danh
function reHit()
	--check neu con luot thi nem tiep 
	--todo
	
	--test nem luon khoi check
	ball.state = state.standing
	throwBall()
end	
--update game state 
--none = 0
--standing = 1
--throwing = 2
--flying = 3
--stoping = 4
function update ()
	if ball.state == state.none then
	--khoi tao
	elseif ball.state == state.standing then
	-- cho nem
	elseif ball.state == state.thowing then
	--nem bong, cho phep touch vao bong 
	elseif ball.state == state.flying then
	--bong dang bay
	elseif ball.state == state.stoping then
	--bong cham dat
	else
	--default
	end
end

Runtime:addEventListener("enterFrame",update)
