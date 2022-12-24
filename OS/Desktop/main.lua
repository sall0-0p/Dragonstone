local basalt = require(".UwUntuCC.OS.Libraries.Basalt")
local db = require(".UwUntuCC.OS.Libraries.Databaser")

local mainFrame = basalt.createFrame()

        db.setDir("UwUntuCC/OS/Data")
        fs.delete("UwUntuCC/OS/Data/RunningApps/name.json")
        fs.delete("UwUntuCC/OS/Data/RunningApps/path.json")
        fs.delete("UwUntuCC/OS/Data/RunningApps/hidden.json")
        fs.delete("UwUntuCC/OS/Data/RunningApps/token.json")
        fs.delete("UwUntuCC/OS/Data/RunningApps/icon.json")

        db.addColumn("RunningApps", "name")
        db.addColumn("RunningApps", "path")
        db.addColumn("RunningApps", "hidden")
        db.addColumn("RunningApps", "token")
        db.addColumn("RunningApps", "icon")

basalt.debugLabel
    :setBackground(colors.gray)
    :setSize("parent.w", 1)
    :setForeground(colors.lightGray)

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
    win.setup()

local terminal = win.create()
    :setSize(51,19)
    :setResizable()
    :setBar("Terminal")
    :run("/UwUntuCC/Apps/Terminal/Terminal.lua")

local worm = win.create()
    :setSize(51,19)
    :setResizable()
    :setBar("Worm")
    :run("/UwUntuCC/Apps/Worm/worm.lua")
end

local function Update()
    basalt.autoUpdate()
end

parallel.waitForAll(openterminal, Update)