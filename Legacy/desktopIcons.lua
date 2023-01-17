local basalt = require(".Dragonstone.OS.Libraries.Basalt")

local function centerText(obj, y)
    obj:setPosition(obj:getSize().."/4", y)
end

return function(mainFrame) 

    local gridArea = mainFrame:addFrame()
        :setPosition(0,3)
        :setSize("parent.w", "parent.h-5")
        :setZIndex(2)
        :setBackground(false)

    local areaW, areaH = gridArea:getSize()
    
    local cellH = 5
    local cellW = 7

    local gridH = math.floor(areaH/cellH) - 1
    local gridW = math.floor(areaW/cellW)

    basalt.debug(gridH, gridW)
    -- local grid = {}
    
    -- for i = 1, gridH do
    --     grid[i] = {}
    -- end

    local items = {}
    local function addIcon(xPos, yPos, file)
        local item = {}
        local iconPath
        item.frame = gridArea:addFrame()
            :setSize(cellW,cellH)
            :setBackground(false)

        item.label = item.frame:addLabel()
            :setSize(cellW, 1)
            :setBackground(false)

        item.label2 = item.frame:addLabel()
            :setSize(3, 1)
            :setBackground(false)
            :setForeground(colors.lightGray)
            :setText("")
            :setPosition(3, 3)
        
        item.icon = item.frame:addImage()
            :setSize(5,3)
            :setPosition(2,1)
            :setBackground(colors.lightGray)
          
        item.path = "Dragonstone/User/Desktop/"..file
        item.extension = file:match "[^%.]+$"
        item.isDir = fs.isDir(item.path)

        if item.isDir then
            if fs.exists("/Dragonstone/User/Desktop/"..file.."/icon-large.bimg") then
                iconPath = "/Dragonstone/User/Desktop/"..file.."/icon-large.bimg"
            else
                iconPath = "/Dragonstone/OS/Icons/Folder-large.bimg"
            end
        else
            if item.extension ~= nil then
                if fs.exists("/Dragonstone/User/Desktop"..item.extension..".bimg") then

                else
                    iconPath = "/Dragonstone/OS/Icons/File-large.bimg"
                    item.label2:setText(item.extension)
                end
            else
                iconPath = "/Dragonstone/OS/Icons/File-large.bimg"
            end
        end

        local label = file

        if item.extension ~= nil or item.extension ~= "" then
            label = string.gsub(file, "."..item.extension, "")
        else
            label = file
        end

        if iconPath ~= nil then
            item.icon:loadImage(iconPath)
        end

        item.label:setText(label)

        centerText(item.label, 4)



        item.xPos = xPos
        item.yPos = yPos

        item.x = math.ceil((xPos - 1) * cellW + (cellW * 0.5))
        item.y = math.ceil((yPos - 1) * cellH + (cellH * 0.5))

        item.frame:setPosition(item.x, item.y)
        table.insert(items, item)
    end
    



    local function updateDesktop()
        items = {}
        files = fs.list("/Dragonstone/User/Desktop")
        for i,v in pairs(files) do
            local posX
            local posY

            local posY = i%gridH
            local posX = math.floor(i/gridH) + 1
            if posX > 1 then 
                posY = posY + 1
            end
            basalt.debug(v, i, posX, posY)
            addIcon(posX, posY, v)
        end
    end
    updateDesktop()
end