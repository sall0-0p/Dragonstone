local basalt = require(".UwUntuCC.OS.Libraries.Basalt")

local mainFrame = basalt.createFrame()

local rw, rh = mainFrame:getSize() -- getting resolution

local sidebar = mainFrame:addFrame()
    :setPosition(1,1)
    :setSize(13, rh)
    :setBackground(colors.gray)
    local sidebarPane = sidebar:addPane()
        :setPosition(13, 1)
        :setSize(1, rh)
        :setBackground(colors.black, "\149", colors.gray)

    local sideList = sidebar:addList()
        :setPosition(3,1)
        :setSize(12, rh.."-5")
        :setBackground(colors.gray)
        :setForeground(colors.lightGray)
        :setSelectedItem()

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
    
mainFrame:onEvent(function(self, event, arg1, arg2, arg3) 
    
    if event == "gained_focus" then
        searchBar:setDefaultText("Search", colors.lightGray, colors.black)
    end
        
    if event == "losed_focus" then
        searchBar:setDefaultText(" ", colors.lightGray, colors.black)
    end
        
end)
        
basalt.autoUpdate()



