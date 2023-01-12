local basalt = require(".Dragonstone.OS.Libraries.Basalt")
local db = require(".Dragonstone.OS.Libraries.Databaser")


return function(mainFrame) 

    local mainFrame = require(".Dragonstone.OS.Desktop.values")
        local rw, rh = mainFrame:getSize()
        local trFrame = mainFrame:addFrame()
            :setSize(rw, 8)
            :setPosition(1, rh.."-7")
            :setBackground(false)
            :setZIndex(2)

        local duckFrame = trFrame:addFrame()
            :setSize(math.floor(rw/2), 2)
            :setPosition(math.floor(rw/4), 7)
            :setBackground(colors.gray)
            :setZIndex(3)


        local objects = {}

        loadDock = function()
            if objects ~= nil then
                for i,v in pairs(objects) do
                    v.icon:remove()
                    v.label:remove()
                end
            end

            local dx, dy = duckFrame:getAbsolutePosition()
            local dw, dy = duckFrame:getSize()
            local rw, rh = mainFrame:getSize()
            local runningApps = db.getColumn("RunningApps", "token")

            local pinnedApps = 
            {
                "Dragonstone/Apps/Finder/Finder.lua",

            }
            local defaultIcons = {}

            local apps = {}

            for i,v in pairs(defaultIcons) do
                table.insert(apps, v)
            end


            for i,v in pairs(pinnedApps) do
                local block = false

                if runningApps ~= nil then
                    for l,k in pairs(runningApps) do
                        if k == v then
                            block = true
                        end
                    end
                end
                if block then
                    
                else 
                    table.insert(apps, v)
                end
            end

            if runningApps ~= nil then
                for i,v in pairs(runningApps) do
                    table.insert(apps, v)
                end
            end


            --basalt.debug(textutils.serialise(apps))
            for i,v in pairs(apps) do
                local group = {}
                group.running = false
                group.index = db.search("RunningApps", "token", v)
                group.data = db.getData("RunningApps", group.index)
                    group.hidden = group.data[1]
                    group.name = group.data[3]
                    group.path = group.data[4]
                    group.token = group.data[5]


                if type(group.path) == "string" then
                    if fs.exists(fs.getDir(group.path).."/icon.bimg") then
                        group.iconPath = fs.getDir(group.path).."/icon.bimg"
                    else
                        group.iconPath = "Dragonstone/OS/Icons/app.bimg"
                    end
                else
                    group.iconPath = "Dragonstone/OS/Icons/app.bimg"
                end

                group.w = math.floor(1 + i * 4 - 4 + rw/4)
                
                group.icon = trFrame:addImage()
                    :setSize(3,2)
                    :setPosition(group.w, 6)
                    :setZIndex(4)
                    :loadImage(group.iconPath)

                group.label = trFrame:addLabel()
                    :setSize(1,1)
                    :setPosition(group.w.."+1", 8)
                    :setZIndex(4)
                    :setForeground(colors.lightGray)

                if runningApps ~= nil then
                    for l,k in pairs(runningApps) do
                        if v == k then
                            group.running = true
                        end
                    end
                end
                table.insert(objects, group)

                --basalt.debug(group.hidden)
                if group.running then

                    if group.hidden == "false" then
                        group.label:setText("\7")
                    else
                        group.label:setText("\186")
                    end
                else
                    group.label:setText(" ")
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