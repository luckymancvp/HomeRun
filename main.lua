--require "CiderDebugger";-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
--Debug the smart way with Cider!
--start coding and press the debug button

 local physics = require ("game.physics").instance()
 physics.start()

require "map"

require "game.controller".init()
local ui = require ("game.ui")
ui.initUI()

