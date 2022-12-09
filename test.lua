local basalt = require(".UwUntuCC.OS.Libraries.Basalt")
local win = require(".UwUntuCC.OS.Libraries.windowingSystem")

local program1 = win.create()

program1
    :setSize(51,19)
    :setResizable()
    :run("UwUntuCC/Apps/Terminal/Terminal.lua")
basalt.autoUpdate()