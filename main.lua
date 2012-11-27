--require "CiderDebugger";-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
--Debug the smart way with Cider!
--start coding and press the debug button

 local physics = require ("game.physics").instance()
 physics.start()

local map = require "map"
map.initGame()

require "game.controller".init()
local ui = require ("game.ui")
local uiview =ui.initUI()
	
