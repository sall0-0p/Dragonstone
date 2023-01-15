local basalt = require(".Dragonstone.OS.Libraries.Basalt")
local db = require(".Dragonstone.OS.Libraries.Databaser")


local mainFrame = require(".Dragonstone.OS.Desktop.values.mainFrame")

        db.setDir("Dragonstone/OS/Data")
        fs.delete("Dragonstone/OS/Data/RunningApps/name.json")
        fs.delete("Dragonstone/OS/Data/RunningApps/path.json")
        fs.delete("Dragonstone/OS/Data/RunningApps/hidden.json")
        fs.delete("Dragonstone/OS/Data/RunningApps/token.json")
        fs.delete("Dragonstone/OS/Data/RunningApps/icon.json")

        db.addColumn("RunningApps", "name")
        db.addColumn("RunningApps", "path")
        db.addColumn("RunningApps", "hidden")
        db.addColumn("RunningApps", "token")
        db.addColumn("RunningApps", "icon")

basalt.debugLabel
    :setBackground(colors.gray)
    :setSize("parent.w", 1)
    :setForeground(colors.lightGray)

-- local p1 = mainFrame:addFrame()
--     :setBackground(false)
--     :setSize("parent.w", "parent.h")

-- local p2 = mainFrame:addFrame()
--     :setBackground(false)
--     :setSize("parent.w", "parent.h") 

-- local p3 = mainFrame:addFrame()
--     :setBackground(false)
--     :setSize("parent.w", "parent.h")

-- local p4 = mainFrame:addFrame()
--     :setBackground(false)
--     :setSize("parent.w", "parent.h")

-- local p5 = mainFrame:addFrame()
--     :setBackground(false)
--     :setSize("parent.w", "parent.h")

for _, v in pairs(fs.list("Dragonstone/OS/Desktop/plugins")) do
    local newPlugin = require(".Dragonstone.OS.Desktop.plugins."..v:gsub(".lua", ""))
    newPlugin(mainFrame)
end



--local function openterminal()
    local win = require(".Dragonstone.OS.Libraries.windowingSystem")
    --os.queueEvent("547485834394884934", win)
    win.setup()

-- local terminal = win.create()
--     :setSize(51,19)
--     :setResizable()
--     :setBar("Terminal")
--     :run("/Dragonstone/Apps/Terminal/Terminal.lua")

local terminal = win.create()
     :setSize(51,19)
     :setResizable()
     :setBar("Worm")
     :run("/Dragonstone/Apps/Terminal/Terminal.lua")


local function Update()
    basalt.autoUpdate()
end

-- local lastClickedObject
-- for k,v in pairs(allObjects) do
--     v:onClick(function(self)         
--     lastClickedObject = self 
--   end)
-- end

Update()
--parallel.waitForAll(openterminal, Update)