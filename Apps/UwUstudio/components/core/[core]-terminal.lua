local basalt = require(".Dragonstone.OS.Libraries.Basalt")

local mainFrame = require(".Dragonstone.Apps.UwUstudio.values.mainFrame")
local terminal_area = require(".Dragonstone.Apps.UwUstudio.values.bottom-pane")

local path = "/Dragonstone/Apps/UwUstudio"

return function()
    
    local menu = terminal_area:addFrame()
        :setSize(7, 1)
        :setPosition("parent.w-6", 1)
        

        local collapse_button = menu:addButton()
            :setSize(1,1)
            :setPosition(7,1)
            :setForeground(colors.white)
            :setText("\25")



end