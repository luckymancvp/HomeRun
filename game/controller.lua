
module (...,package.seeall)


local ball 
local physics 
local state
local ui 
local data
local map


local _ratio = 15

function init()
	 ball = require ("game.ball").instance()
 	physics = require ("game.physics").instance()
 	state = require ("game.ballState")
 	ui = require ("game.ui")
 	data = require ("game.data")
        
    map = require("map")
    _ratio = data.BALL_POWER_RATIO
 	
end
--start game 

function startGame()
	ball.state = state.standing
	data.remainBall = 10
	data.currentCombo= 0
	data.score=0
	data.maxDistance = 0
	ui.resetRemainBall()
	throwBall()
end

--pause game

function pauseGame()
	physics.pause()
	
	ui.pauseGame()
end

--resume game

function resumeGame()
	physics.start()
	
	ui.resumeGame()
end

--goto main menu
function  gotoMainMenu()
	map.setMapFollowBalls(false)
	physics.stop()
	
	require ("game.ball").destroyBall()
	
	director:changeScene ("mainMenu")
end

--retry game

function retryGame()
	startGame()
end
-- nem bong 
function throwBall()
        map.resetMap()
    
	ball.bodyType = "static"
	ball.x = 490
      ball.y = 50
        ball.bodyType = "dynamic"
        ball:applyForce(-80, 0,ball.x, ball.y )
	ball.state = state.throwing
	
end
--danh bong tai diem pointX,pointY  voi do lon luc 2 phuong x, y la forceX va forceY
function hitBall(pointX,pointY)
	local endP = ui.getEndPoint()

	print(endP)
	local forceX  = (pointX - endP[1].x)*_ratio
	local forceY  = (pointY - endP[1].y)*_ratio
	if forceX>data.MAXFORCEX then
		forceX = data.MAXFORCEX*forceX/math.abs(forceX)
		forceY = forceY*data.MAXFORCEX/math.abs(forceX)
	elseif forceX < data.MINFORCEX then
		forceX = data.MINFORCEX*forceX/math.abs(forceX)
		forceY = forceY*data.MINFORCEX/math.abs(forceX)
	end
	 if math.abs(forceY)>data.MAXFORCEY then
		forceY = data.MAXFORCEY*forceY/math.abs(forceY)
		forceX = forceX*data.MAXFORCEY/math.abs(forceY)
	
	end
	pointX = pointX + (ball.x -pointX) /3
	pointY = pointY + (ball.y - pointY)/3
		print("end point     "..forceX.."      "..forceY.."       "..endP[1].x)
	 ball:applyForce(forceX, forceY,pointX, pointY )
      ball.state = state.flying
         
         
	map.setMapFollowBalls(true)
end

--v a vao bong bay
function eatFlyBall()
	
end

function collideGround()
    map.setMapFollowBalls(false)
    
	if ball.state == state.throwing then
	-- danh truot
		print "collideGround : danh truot"
		 calculateScore()
	elseif ball.state == state.flying then
	-- danh trung bong tinh khoang cach danh duoc	
	  print "collideGround : danh trung"
	  calculateScore()
	else
	end
end

--danh lai neu nhu con luot danh
function reHit()
	--check neu con luot thi nem tiep 
	--todo
	
	--test nem luon khoi check
	ball.state = state.standing
	throwBall()
end	


--check ball  position 
function calculateScore()
	
	if data.remainBall<=0  then
		
		print ("ket thuc")
		ui.gameResult(data.score,data.maxDistance)
		return
	end
	if ball.x <= data.xOutLine then
		--bong bay ra ngoai  giam so bong tru diem, giam so combo ve -1
		-- giam remainball
		data.remainBall = data.remainBall -1
		print (data.remainBall)
		--giam combo ve -1
		data.currentCombo = -1
		--tru diem
		
		-- thong bao out ra man hinh
		ui.setOutText()
		--  update so bong con lai
		ui.updateRemainBall(data.remainBall)
	else
	-- bong hop le tinh diem
	--cam co
	
	local flag = require ("game.flag").newFlag(ball.x,ball.y)
	map.getInstance():insert(flag)
	--tinh khoang cach
		local ft = math.round( ball.x )
		if ft > data.maxDistance then
			data.maxDistance = ft
		end
		--hien khoang cach dat duoc
		ui.setFtText(ft)
		--tang so combo
		data.currentCombo = data.currentCombo +1
		--neu so combo >0 hien so com bo
		if data.currentCombo >0 then
			ui.setComboText(data.currentCombo)
		end
		-- turn score
		local turnScore = ft *(1 + data.currentCombo /10)
		
		--cong diem tong so diem
		data.score = data.score + math.round( turnScore)
		--update diem 
		ui.setScoreText(data.score)
		
	end
	if data.remainBall>0  then
		ball.state = state.stoping
		timer.performWithDelay(1000, reHit)
	end
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

--Runtime:addEventListener("enterFrame",update)
