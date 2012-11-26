local widget = require "widget"
local controller = require "game.controller"
local ball = require "game.ball".instance()
local state = require "game.ballState"
local data = require "game.data"
local function startButtonPressed(event)
	ball.state = state.standing
	data.remainBall = 10
	controller.throwBall()
	return true
end
local start = widget.newButton{
	default = "images/gameview_pause.png",
	onPress = startButtonPressed
}
start.x = 100; start.y = 200;