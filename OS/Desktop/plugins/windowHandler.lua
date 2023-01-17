--strange temporary thing is here

local win = require(".Dragonstone.OS.Libraries.windowingSystem")
local basalt = require(".Dragonstone.OS.Libraries.Basalt")

return function(mainFrame)
    local mainFrame = require(".Dragonstone.OS.Desktop.values.mainFrame")

    mainFrame:onEvent(function(self, event, path) 
        if event == "uwuntu.runEditor" then
            local editor = win.create()
                :setSize(51,19)
                :setBar("Editor")
                :run("/Dragonstone/OS/SystemApps/Edit/edit.lua")
            
            sleep(0.1)
            os.queueEvent("3210050775", path)
            os.queueEvent("updateDock")
        end
    end)

    mainFrame:onEvent(function(self, event, path) 
        if event == "uwuntu.runProgram" then
            local program = win.create()
                :setSize(51,19)
                :setBar(fs.getName(path))
                :run(path)
                os.queueEvent("updateDock")
        end
    end)
end