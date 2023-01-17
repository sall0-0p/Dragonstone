local basalt = require(".Dragonstone.OS.Libraries.Basalt")
local mainFrame = require(".Dragonstone.OS.Desktop.values.mainFrame")

local closeFrame = mainFrame:addFrame()
            :setSize("parent.w", "parent.h")
            :setBackground(false)
            :setZIndex(2)

return closeFrame