local basalt = require(".UwUntuCC.OS.Libraries.Basalt")

local mainFrame = basalt.createFrame()

local accentColor = settings.get("uwuntucc.accent_color")

local rw, rh = mainFrame:getSize() -- getting resolution

local sidebar = mainFrame:addFrame()
    :setPosition(1,1)
    :setSize(13, rh)
    :setBackground(colors.gray)

    local sideList = sidebar:addList()
        :setPosition(1,3)
        :setSize(12, rh.."-2")
        :setBackground(colors.gray)
        :setForeground(colors.lightGray)
        :setSelectedItem()

    local sidebarPane = sidebar:addPane()
        :setPosition(13, 1)
        :setSize(1, rh)
        :setBackground(colors.black, "\149", colors.gray)

    local searchBar = sidebar:addInput()
        :setSize(10, 1)
        :setPosition(2, 1)
        :setBackground(colors.black)
        :setForeground(colors.white)
        :setDefaultText(" ", colors.lightGray, colors.black)
    
        sidebar:addFrame()
            :setSize(1, 1)
            :setPosition(1, 1)
            :setBackground(colors.black, "\149", colors.gray)
        sidebar:addFrame()
            :setSize(1, 1)
            :setPosition(12, 1)
            :setBackground(colors.gray, "\149", colors.black)

local appearanceSettings = mainFrame:addFrame()
    :setSize(rw.."-13", 50)
    :setPosition(14, 1)
    :setBackground(colors.lightGray)
    :setScrollable()
local f = require(".UwUntuCC.Apps.Settings.assets.pages.appearance")
f(appearanceSettings)

mainFrame:onEvent(function(self, event, arg1, arg2, arg3) 
    
    if event == "gained_focus" then
        searchBar:setDefaultText("Search", colors.lightGray, colors.black)
    end
        
    if event == "losed_focus" then
        searchBar:setDefaultText(" ", colors.lightGray, colors.black)
    end
        
end)
        
basalt.autoUpdate()



