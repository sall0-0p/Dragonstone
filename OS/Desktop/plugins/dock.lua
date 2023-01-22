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
    local closeFrame = require(".Dragonstone.OS.Desktop.values.closeFrame")
    
    local isCraftOSPC = string.find("Black", "PC")
    if isCraftOSPC ~= nil then
        isCraftOSPC = true
        basalt.setMouseMoveThrottle(100)
    else
        isCraftOSPC = false
    end
    --basalt.debug(isCraftOSPC)

        if not fs.exists("Dragonstone/OS/Data/PinnedApps/path.json") then
            local defaults = {
                "/Dragonstone/Apps/Finder/Finder.lua",
                "/Dragonstone/Apps/Terminal/Terminal.lua",
                "/Dragonstone/Apps/ASCII/ASCII.lua",
                "/Dragonstone/Apps/BasaltImages/BasaltImages.lua",
            }
            local file = fs.open("Dragonstone/OS/Data/PinnedApps/path.json", "w")
            file.write(textutils.serialise(defaults))
            file.close()
        end

        local rw, rh = mainFrame:getSize()
        
        local trFrame = mainFrame:addFrame()
            :setSize(rw, 8)
            :setPosition(1, "parent.h-7")
            :setBackground(false)
            :setZIndex(17)

        if rh < 22 then 
            trFrame:setZIndex(5)
        end
        local duckFrame = trFrame:addFrame()
            :setSize(rw, 2)
            :setPosition(1, 7)
            :setBackground(mainColor)
            :setZIndex(17)

            --duckFrame:onClick(function() basalt.debug(mainFrame:getSize()) end)


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

            local pinnedApps = db.getColumn("PinnedApps", "path")
            
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
                    table.insert(apps, v)
                    
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

                group.w = math.floor(1 + i * 4 - 4 + 4)
                
                group.icon = trFrame:addImage()
                    :setSize(3,2)
                    :setPosition(group.w, 6)
                    :setZIndex(17)
                    :loadImage(group.iconPath)

                group.label = trFrame:addLabel()
                    :setSize(3,1)
                    :setPosition(group.w.."", 8)
                    :setZIndex(17)
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
                    else
                        group.label:setText("\128\186\128")
                    end
                    
                    group.icon:onClick(function(self, event, button) 
                        if button == 1 then
                            if group.hidden == "false" then
                                    local instance = win.getWindow(group.token)
                                    if instance ~= nil then
                                        instance.focus()
                                    end
                            else
                                local instance = win.getWindow(group.token)
                                if instance ~= nil then
                                    instance.showWindow()
                                    instance.focus()
                                end
                            end
                        end
                        
                        if button == 2 then
                            local iconPosX, iconPosY = group.icon:getAbsolutePosition()
                            --basalt.debug(iconPosX+1, iconPosY-11)
                            --local Animation = mainFrame:addAnimation()
                            local menu = mainFrame:addFrame()
                                :addLayout("/Dragonstone/OS/Desktop/layouts/dock/activeMenu.xml")
                                :setSize(15,7)
                                :setPosition(iconPosX, iconPosY.."-8")
                                :setZIndex(12)

                            local menuBRD = mainFrame:addLabel()
                                :setText("\130\143\129")
                                :setSize(3,1)
                                :setPosition(iconPosX, iconPosY.."-1")
                                :setBackground(false)
                                :setForeground(colors.gray)
                                :setZIndex(13)

                            menu:onClick(function() end)
                            closeFrame:onClick(function() menu:remove() menuBRD:remove() end)
                            trFrame:onClick(function() menu:remove() menuBRD:remove() end)
                            local closeBtn = menu:getObject("menu2"):getObject("close")
                            local folderBtn = menu:getObject("menu2"):getObject("showFolder") 
                            local pinBtn = menu:getObject("menu2"):getObject("pin")
                                closeBtn:onClick(function() 
                                    local instance = win.getWindow(group.token)
                                    if instance ~= nil then
                                        instance.close()
                                        menu:remove()
                                        menuBRD:remove()
                                    end
                                end)

                                folderBtn:onClick(function()
                                    local finder = win.create()
                                        :setSize(51,19)
                                        :setBar("Finder")
                                        :run("Dragonstone/Apps/Finder/Finder.lua", fs.getDir(group.path))
                                        menu:remove()
                                        menuBRD:remove()
                                end)

                                pinBtn:onClick(function() 
                                    local ifExists = db.search("PinnedApps", "path", group.path)
                                    --basalt.debug(group.path, ifExists)
                                    --basalt.debug(ifExists)
                                    if ifExists ~= nil then
                                        
                                        os.queueEvent("notification", "Error", "You can`t pin app that already pinned.")
                                    else
                                        db.addValue("PinnedApps", "path", group.path)
                                        os.queueEvent("updateDock")
                                    end
                                    menu:remove()
                                    menuBRD:remove()
                                end)

                                
                        end

                    
                    end)
                else
                    group.label:setText("\140\140\140")

                    group.icon:onClick(function(self, event, button)
                        --basalt.debug(button)
                        if button == 1 then
                            local newInstance = win.create()
                                :setSize(51,19)
                                :setBar(fs.getName(fs.getDir(group.path)))
                                :run(group.path)
                                os.queueEvent("updateDock")
                        end
                        if button == 2 then
                            local iconPosX, iconPosY = group.icon:getAbsolutePosition()

                            local menu = mainFrame:addFrame()
                                :addLayout("/Dragonstone/OS/Desktop/layouts/dock/pinnedMenu.xml")
                                :setSize(15,6)
                                :setPosition(iconPosX, iconPosY.."-7")
                                :setZIndex(12)

                            local menuBRD = mainFrame:addLabel()
                                :setText("\130\143\129")
                                :setSize(3,1)
                                :setPosition(iconPosX, iconPosY.."-1")
                                :setBackground(false)
                                :setForeground(colors.gray)
                                :setZIndex(13)

                            local openBtn = menu:getObject("menu1"):getObject("open")
                            local folderBtn = menu:getObject("menu1"):getObject("showFolder") 
                            local unpinBtn = menu:getObject("menu1"):getObject("unpin")

                            openBtn:onClick(function() 
                                local newInstance = win.create()
                                    :setSize(51,19)
                                    :setBar(fs.getName(fs.getDir(group.path)))
                                    :run(group.path)
                                os.queueEvent("updateDock")
                                menu:remove()
                                menuBRD:remove()
                            end)

                            folderBtn:onClick(function()
                                local finder = win.create()
                                    :setSize(51,19)
                                    :setBar("Finder")
                                    :run("Dragonstone/Apps/Finder/Finder.lua", fs.getDir(group.path))
                                menu:remove()
                                menuBRD:remove()
                            end)

                            unpinBtn:onClick(function() 
                                local ifExists = db.search("PinnedApps", "path", group.path)

                                if ifExists == nil then
                                    os.queueEvent("notification", "Error", "You can`t unpin app that not pinned.")
                                else
                                    db.removeValue("PinnedApps", "path", ifExists)
                                    os.queueEvent("updateDock")
                                end
                                menu:remove()
                                menuBRD:remove()
                            end)


                            
                            menu:onClick(function() end)
                            closeFrame:onClick(function() menu:remove() menuBRD:remove() end)
                            trFrame:onClick(function() menu:remove() menuBRD:remove() end)
                        end

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