module(...,package.seeall)

local widget = require( "widget" )
local ui = require("ui")
local controller = require("game.controller")

local ftLabel,scoreLabel,comboLabel,outLabel
local arrayBall

local maxPoints = 5
local lineThickness = 20
local lineFadeTime = 250
local endPoints = {}


local pauseScreen 

function initUI ()
	local localGroup =  display.newGroup()
	pauseScreen= nil
	
	
	ftLabel=display.newText("", 240, 160, native.systemFont, 25)
	ftLabel:setTextColor(255, 255, 254)
	ftLabel:setReferencePoint(display.CenterReferencePoint);
	ftLabel.text = ""
	localGroup:insert(ftLabel)
	

	scoreLabel = display.newText("0", 240, 3, native.systemFont, 25)
	scoreLabel:setTextColor(255, 255, 254)
	scoreLabel:setReferencePoint(display.CenterReferencePoint);
	--scoreLabel.text = "123FT"
	localGroup:insert(scoreLabel)
	
	
	comboLabel = display.newText("5 combo!!", 300,100, native.systemFont, 18)
	comboLabel:setTextColor(255, 0, 0)
	comboLabel:setReferencePoint(display.CenterReferencePoint);
	comboLabel.text = ""
	localGroup:insert(comboLabel)
	
	
	outLabel = display.newText("Out", 240, 160, native.systemFont, 25)
	outLabel:setTextColor(255, 255, 254)
	outLabel:setReferencePoint(display.CenterReferencePoint);
	outLabel.text = ""
	localGroup:insert(outLabel)
	Runtime:addEventListener("touch", drawSlashLine)
	
	
	function ftLabel:timer(event)
 	  ftLabel.text = ""
	end

	function comboLabel:timer(event)
     comboLabel.text = ""
	end
	
	function outLabel:timer(event)
 	  outLabel.text = ""
	end
	
	arrayBall = display.newGroup()
	for i = 1 ,3 do
		local ballimage = display.newImageRect("images/gameview_ball1.png", 20 , 20)
		ballimage.x = (i-1)*22
		arrayBall:insert(ballimage)
	end
	arrayBall.x = 30
	arrayBall.y = 20
	localGroup:insert(arrayBall)
	
	
	local function startButtonPressed(event)
		controller.startGame()
		event.target:removeSelf()
		return true
	end
	
	local start = widget.newButton{
		default = "images/title_start_game.png",
		over = "images/title_start_game_down.png",
		onPress = startButtonPressed
	}
	start.x = 100; start.y = 200;
	localGroup:insert(start)
	
	local function pauseButtonPressed(event)
		controller.pauseGame()
		return true
	end

	local pauseBtt = widget.newButton{
		default = "images/gameview_pause.png",
		over = "images/gameview_pause_down.png",
		onPress = pauseButtonPressed
	}
	pauseBtt.x = 400; pauseBtt.y = 200;
	localGroup:insert(pauseBtt)

	local pauseBtt1 = widget.newButton{
		width=0,
		 height=0,
	default = "images/gameview_pause.png",
		--over = "images/gameview_pause_down.png",
		--onPress = pauseButtonPressed
	}
	pauseBtt1.x = 100; pauseBtt1.y = 300;
	localGroup:insert(pauseBtt1)

	
	return localGroup
end

function setComboText (n)
	comboLabel.text = n.." combo!!"
	visibleAfterSecond(comboLabel,1000)	
end


function setFtText (n)

	ftLabel.text = n.." FT"
	visibleAfterSecond(ftLabel,1000)	
end

function setOutText ()

	outLabel.text = "Out"
	visibleAfterSecond(outLabel,500)	
end

function setScoreText (score)
	scoreLabel.text = score
end

function visibleAfterSecond(labelObj,n)
  timer.performWithDelay(n, labelObj )
end

function updateRemainBall(n)
	if n >=1 and n<=3 then
		arrayBall:remove(n)
	end
end


---------- touch to screen -----------
function drawSlashLine(event)

	print ("event      "..event.x.."      "..event.y)
	-- Insert a new point into the front of the array
	
	table.insert(endPoints, 1, {x = event.x, y = event.y, line= nil})

	-- Remove any excessed points
	if(#endPoints > maxPoints) then
		table.remove(endPoints)
	end
	
	for i,v in ipairs(endPoints) do
		local line = display.newLine(v.x, v.y, event.x, event.y)
		line.width = lineThickness
		transition.to(line, {time = lineFadeTime, alpha = 0, width = 0, onComplete = function(event) line:removeSelf() isTouch = false end})
	end

	if(event.phase == "ended") then
		while(#endPoints > 0) do
			table.remove(endPoints)
		end
	end
	
end
function getEndPoint()
	return endPoints

--create pause screen

function pauseGame()
	 pauseScreen = display.newGroup()
	 local screenCap = display.captureScreen(false) --dont save to album
     pauseScreen:insert(screenCap)
    
     local bound = display.newRect( 10, 199, 480, 320 )
     bound:setFillColor( 255, 1, 1, 1)		-- make 
     pauseScreen:insert(bound)
     
     local function mainMenuButtonPressed(event)
		if event.phase == "release" then
			controller.resumeGame()
		end
		return true
	end
	
	local mainMenu = widget.newButton{
		default = "images/pauseview_main.png",
		over = "images/pauseview_main_down.png",
		onEvent = mainMenuButtonPressed
	}
	mainMenu.x = 240; mainMenu.y = 140;
	pauseScreen:insert(mainMenu)
	
	local function resumeButtonPressed(event)
		--print (event.phase)
		if event.phase == "release" then
			controller.resumeGame()
		end
		return true
	end
	
	local resumeBtt = widget.newButton{
		default = "images/pauseview_resume.png",
		over = "images/pauseview_resume_down.png",
		onEvent = resumeButtonPressed
	}
	resumeBtt.x = 240; resumeBtt.y = 200;
	pauseScreen:insert(resumeBtt)
    
end

--resume game remove pause screen
function resumeGame()

	pauseScreen:removeSelf()
	pauseScreen = nil

end