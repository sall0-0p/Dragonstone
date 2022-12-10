local basalt = require(".UwUntuCC.OS.Libraries.Basalt")

local mainFrame = basalt.createFrame()

local p1 = mainFrame:addFrame()
    :setBackground(false)
    :setSize("parent.w", "parent.h")

local p2 = mainFrame:addFrame()
    :setBackground(false)
    :setSize("parent.w", "parent.h") 

local p3 = mainFrame:addFrame()
    :setBackground(false)
    :setSize("parent.w", "parent.h")

local p4 = mainFrame:addFrame()
    :setBackground(false)
    :setSize("parent.w", "parent.h")

local p5 = mainFrame:addFrame()
    :setBackground(false)
    :setSize("parent.w", "parent.h")

for _, v in pairs(fs.list("UwUntuCC/OS/Desktop/plugins")) do

    local newPlugin = require(".UwUntuCC.OS.Desktop.plugins."..v:gsub(".lua", ""))
    newPlugin(mainFrame, p1, p2, p3, p4, p5)
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