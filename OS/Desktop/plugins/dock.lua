local basalt = require(".Dragonstone.OS.Libraries.Basalt")
local db = require(".Dragonstone.OS.Libraries.Databaser")
local win = require(".Dragonstone.OS.Libraries.windowingSystem")

local accentColor = settings.get("uwuntucc.accent_color")
local mainColor = settings.get("uwuntucc.main_color")
local secondColor = settings.get("uwuntucc.second_color")
local text_color1 = settings.get("uwuntucc.text_color1")
local text_color2 = settings.get("uwuntucc.text_color2")


return function(mainFrame) 

    local mainFrame = require(".Dragonstone.OS.Desktop.values.mainFrame")
        local rw, rh = mainFrame:getSize()
        local trFrame = mainFrame:addFrame()
            :setSize(rw, 8)
            :setPosition(1, rh.."-7")
            :setBackground(false)
            :setZIndex(11)

        local duckFrame = trFrame:addFrame()
            :setSize(rw, 2)
            :setPosition(1, 7)
            :setBackground(mainColor)
            :setZIndex(3)


        local objects = {}

        loadDock = function()
            if objects ~= nil then
                for i,v in pairs(objects) do
                    v.icon:remove()
                    v.label:remove()
                    v = {}
                end
            end

            local dx, dy = duckFrame:getAbsolutePosition()
            local dw, dy = duckFrame:getSize()
            local rw, rh = mainFrame:getSize()
            local runningApps = db.getColumn("RunningApps", "token")

            local pinnedApps = 
            {
                "Dragonstone/Apps/Finder/Finder.lua",
                "Dragonstone/Apps/Terminal/Terminal.lua",
                "Dragonstone/Apps/ASCII/ASCII.lua",
                "Dragonstone/Apps/BasaltImages/BasaltImages.lua"
            }
            local defaultIcons = {}

            local apps = {}
            
            for i,v in pairs(defaultIcons) do
                table.insert(apps, v)
            end

            
            for i,v in pairs(pinnedApps) do
                local path
                if runningApps ~= nil then
                    
                    for l,k in pairs(runningApps) do

                        local index = db.search("RunningApps", "token", k)
                        
                        local data = db.getColumn("RunningApps", "path")
                        path = "/"..data[index]
                        
                    end
                    if path == v then
                        basalt.debug("same")
                    else
                        
                        table.insert(apps, v)
                    end
                end
            end

            if runningApps ~= nil then
                for i,v in pairs(runningApps) do
                    table.insert(apps, v)
                end
            end

            for i,v in pairs(apps) do
                local group = {}
                group.running = false

                if string.find(v, "/") == nil then
                    group.index = db.search("RunningApps", "token", v)
                    group.data = db.getData("RunningApps", group.index)
                        group.hidden = group.data[1]
                        group.name = group.data[3]
                        group.path = group.data[4]
                        group.token = group.data[5]

                    group.running = true
                else
                    group.path = v
                    group.running = false
                end
                
                if type(group.path) == "string" then
                    if fs.exists(fs.getDir(group.path).."/icon.bimg") then
                        group.iconPath = fs.getDir(group.path).."/icon.bimg"
                    else
                        group.iconPath = "Dragonstone/OS/Icons/app.bimg"
                    end
                else
                    group.iconPath = "Dragonstone/OS/Icons/app.bimg"
                end

                group.w = math.floor(1 + i * 4 - 4 + 1)
                
                group.icon = trFrame:addImage()
                    :setSize(3,2)
                    :setPosition(group.w, 6)
                    :setZIndex(4)
                    :loadImage(group.iconPath)

                group.label = trFrame:addLabel()
                    :setSize(3,1)
                    :setPosition(group.w.."", 8)
                    :setZIndex(4)
                    :setForeground(secondColor)

                if runningApps ~= nil then
                    for l,k in pairs(runningApps) do
                        if v == k then
                            group.running = true
                            
                        end
                    end
                end

                table.insert(objects, group)

                if group.running then

                    if group.hidden == "false" then
                        group.label:setText("\128\7\128")
                        group.icon:onClick(function(self, event, button)
                            local instance = win.getWindow(group.token)
                            if instance ~= nil then
                                instance.focus()
                            end
                        end)
                    else
                        group.label:setText("\128\186\128")

                        group.icon:onClick(function(self, event, button)
                            local instance = win.getWindow(group.token)
                            if instance ~= nil then
                                instance.showWindow()
                                instance.focus()
                            end
                        end)
                    end
                else
                    group.label:setText("\140\140\140")

                    group.icon:onClick(function(self, event, button)
                        local newInstance = win.create()
                            :setSize(51,19)
                            :setBar(fs.getName(fs.getDir(group.path)))
                            :run(group.path)
                            os.queueEvent("updateDock")
                    end)
                end
            end
        end


        mainFrame:onEvent(function(self, event)
            if event == "updateDock" then
                loadDock()
            end
        end)

        loadDock()
        
end