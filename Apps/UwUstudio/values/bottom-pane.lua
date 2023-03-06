local basalt = require(".Dragonstone.OS.Libraries.Basalt")
local mainFrame = require(".Dragonstone.Apps.UwUstudio.values.mainFrame")

local terminal_area = mainFrame:addFrame()
        :setSize("parent.w-22", 13)
        :setPosition(23, "parent.h-13")
        :setBackground(colors.black)
        :setBorder(colors.gray, "top")
        :setZIndex(8)

return terminal_area