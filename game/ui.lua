module(...,package.seeall)
local widget = require( "widget" )

local controller = require("game.controller")

local ftLabel,scoreLabel,comboLabel,outLabel
local arrayBall

function initUI ()
	local localGroup =  display.newGroup()
	ftLabel = display.newText("", 240, 160, native.systemFont, 25)
	ftLabel:setTextColor(255, 255, 255)
	ftLabel:setReferencePoint(display.CenterReferencePoint);
	ftLabel.text = ""
	
	localGroup:insert(ftLabel)
	
	
	scoreLabel = display.newText("0", 240, 3, native.systemFont, 25)
	scoreLabel:setTextColor(255, 255, 255)
	scoreLabel:setReferencePoint(display.CenterReferencePoint);
	--scoreLabel.text = "123FT"
	
	localGroup:insert(scoreLabel)
	
	
	comboLabel = display.newText("5 combo!!", 300,100, native.systemFont, 18)
	comboLabel:setTextColor(255, 0, 0)
	comboLabel:setReferencePoint(display.CenterReferencePoint);
	comboLabel.text = ""
	
	localGroup:insert(comboLabel)
	
	
	outLabel = display.newText("Out", 240, 160, native.systemFont, 25)
	outLabel:setTextColor(255, 255, 255)
	outLabel:setReferencePoint(display.CenterReferencePoint);
	outLabel.text = ""
	
	localGroup:insert(outLabel)
	
	
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
		return true
	end
	local start = widget.newButton{
		default = "images/gameview_pause.png",
		over = "images/gameview_pause.png",
		onPress = startButtonPressed
	}
	start.x = 100; start.y = 200;
	
	localGroup:insert(start)
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