local basalt = require(".UwUntuCC.OS.Libraries.Basalt")
local active = true
return function(mainFrame, p1, p2, p3, p4, p5) 

        local rw, rh = mainFrame:getSize()
        local trFrame = p2:addFrame()
            :setSize(rw, 8)
            :setPosition(1, rh.."-7")
            :setBackground(false)
            :setZIndex(1)

        local duckFrame = trFrame:addFrame()
            :setSize(math.floor(rw/2), 2)
            :setPosition(math.floor(rw/4), 7)
            :setBackground(colors.gray)
            :setZIndex(2)


        local objects = {}

        loadDock = function()
            local dx, dy = duckFrame:getAbsolutePosition()
            local dw, dy = duckFrame:getSize()
            local rw, rh = mainFrame:getSize()
            local runningApps = {}
            local pinnedApps = {}
            local defaultIcons = {}

            local apps = {
                "app"
            }

            for i,v in pairs(apps) do
                local group = {}

                group.iconPath = "UwUntuCC/Apps/Finder/icon.bimg"
                
                group.w = math.floor(1 + i * 4 - 4 + rw/4)
                --basalt.debug(group.w)
                
                group.icon = trFrame:addImage()
                    :setSize(3,2)
                    :setPosition(group.w, 6)
                    :setZIndex(3)
                    :loadImage(group.iconPath)

                group.label = trFrame:addLabel()
                    :setSize(1,1)
                    :setPosition(group.w.."+1", 8)
                    :setZIndex(3)
                    :setText("\7")
                    :setForeground(colors.lightGray)
            end
        end

        loadDock()

    

end