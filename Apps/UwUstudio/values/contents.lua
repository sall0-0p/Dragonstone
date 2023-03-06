local basalt = require(".Dragonstone.OS.Libraries.Basalt")
local mainFrame = require(".Dragonstone.Apps.UwUstudio.values.mainFrame")

local contents = mainFrame:addFrame()
        :setSize("parent.w-22", "parent.h-3")
        :setPosition(23, 3)
        :setBackground(colors.black)
        :setZIndex(4)

return terminal_area