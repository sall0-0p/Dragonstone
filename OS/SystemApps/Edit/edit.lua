
local basalt = require(".Dragonstone.OS.Libraries.Basalt")

local mainFrame = basalt.createFrame()


mainFrame:onEvent(function(self, event, file)
    if event == "3210050775" then
        shell.run("edit", file)
    end
end)

basalt.autoUpdate()