local basalt = require(".UwUntuCC.OS.Libraries.Basalt")

local mainFrame = basalt.createFrame()

for _, v in pairs(fs.list("UwUntuCC/OS/Desktop/plugins")) do

    local newPlugin = require(".UwUntuCC.OS.Desktop.plugins."..v:gsub(".lua", ""))
    newPlugin(mainFrame)
end

local function openterminal()
local win = require(".UwUntuCC.OS.Libraries.windowingSystem")

local terminal = win.create()
    :setSize(51,19)
    :setResizable()
    :setBar("Terminal")
    :run("/UwUntuCC/Apps/Terminal/Terminal.lua")
end

local function Update()
    basalt.autoUpdate()
end

parallel.waitForAll(openterminal, Update)