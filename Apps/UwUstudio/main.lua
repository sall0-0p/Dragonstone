local basalt = require(".Dragonstone.OS.Libraries.Basalt")

local path = "/Dragonstone/Apps/UwUstudio"

local mainFrame = require(".Dragonstone.Apps.UwUstudio.values.mainFrame")

mainFrame:setBackground(colors.black)

--* Main Elements and layout

    local category_bar = mainFrame:addFrame()
        :setSize(4, "parent.h-1")
        :setBackground(colors.gray)
        :setBorder(colors.lightGray, "right")
        :setZIndex(5)

    local sidebar = mainFrame:addFrame()
        :setSize(18, "parent.h-1")
        :setPosition(5)
        :setBackground(colors.gray)
        :setBorder(colors.lightGray, "right")
        :setZIndex(5)

    local header = mainFrame:addFrame()
            :setSize("parent.w-22", 1)
            :setPosition(23, 1)
            :setBackground(colors.gray)
            :setZIndex(5)

        local header_border = mainFrame:addPane()
            :setSize("parent.w-22", 2)
            :setPosition(23, 2)
            :setBackground(false, "\131", colors.lightGray)


        
    local footer = mainFrame:addFrame()
        :setSize("parent.w", 1)
        :setPosition(1, "parent.h")
        :setBackground(colors.cyan)
        :setZIndex(7)

    local contents = require(".Dragonstone.Apps.UwUstudio.values.contents")

    local terminal_area = require(".Dragonstone.Apps.UwUstudio.values.bottom-pane")

    basalt.debugLabel
        :setBackground(colors.cyan)
        :setForeground(colors.white)

--* loading core extensions

for _, v in pairs(fs.list(path.."/components/core")) do
    local newPlugin = require(".Dragonstone.Apps.UwUstudio.components.core."..v:gsub(".lua", ""))
    newPlugin(mainFrame)
end





--* header buttons

    local header_run_button = header:addButton()
        :setPosition("parent.w-3")
        :setSize(1,1)
        :setForeground(colors.lightGray)
        :setText("\16")

    local header_menu_button = header:addButton()
        :setPosition("parent.w-1")
        :setSize(1,1)
        :setForeground(colors.lightGray)
        :setText("=")

--* codespaces 

    local codespaces = {}

    contents:onEvent(function(self, event, path) 
        if event == "uwuIDE.createCodespace" then
            
        end
    end)

--* tabs

    local tabs_frame = header:addFrame()
        :setSize("parent.w-5", 1)
        :setBackground(false)

    local tabs = {
        "/Dragonstone/Apps/Finder/Finder.lua",
        "/Dragonstone/Apps/ASCII/ASCII.lua",
    }

    local selected_tab = 1
    local tab_objects = {}

    local function updateTabs()
        for i,v in pairs(tabs) do
            --basalt.debug(i,v)
            local group = {}

            group.frame = tabs_frame:addFrame()
                :setSize(15, 1)
                :setPosition(i.."*15-14")
                :setBackground(colors.gray)

            group.label = group.frame:addLabel()
                :setPosition(2,1)
                :setText(fs.getName(v))
                :setForeground(colors.white)
                :setBackground(false)

            group.closebutton = group.frame:addButton()
                :setPosition(14,1)
                :setSize(1,1)
                :setText("x")
                :setForeground(colors.red)
                :setBackground(false)

            if selected_tab == i then
                group.frame:setBackground(colors.black)

            else
                group.frame:onClick(function(self, event, button) 
                    if button == 1 then
                        selected_tab = i
                        updateTabs()
                    end
                
                end)
            end
        end

    end

    updateTabs()


basalt.autoUpdate()