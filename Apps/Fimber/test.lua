local basalt = require(".UwUntuCC.OS.Libraries.Basalt")
local main = basalt.createFrame()

local files = fs.list("/")


local fileObjects = {}
local fileList = main:addFrame():setSize(35, 12):setScrollable()

local function updateFiles(selected)
    for k,v in pairs(fileObjects)do
        v.label:setPosition(1,1):hide()
        v.pane:setPosition(1,1):hide()
    end
    local rColoring = false
    local y = 1

    local function updateItem(group, text, bg, fg)
        if(selected==y)then
            group.pane:setPosition(1, y):setBackground(colors.red):show()
            group.label:setText(text):setPosition(3, y):setBackground(colors.red):setForeground(colors.black):show()
        else
            group.pane:setPosition(1, y):setBackground(bg):show()
            group.label:setText(text):setPosition(3, y):setBackground(bg):setForeground(fg):show()
        end
        y = y + 1
    end

    for k,v in pairs(files)do
        if(fileObjects[y]~=nil)then
            updateItem(fileObjects[y], v, rColoring and colors.black or colors.white, rColoring and colors.white or colors.black)
        else
            local group = {}
            group.pane = fileList:addPane():setSize("parent.w", 1)
            group.label = fileList:addLabel()
            updateItem(group, v, rColoring and colors.black or colors.white, rColoring and colors.white or colors.black)
            group.pane:onClick(function()
                updateFiles(group.pane:getY())
            end)
            table.insert(fileObjects, group)
        end
        rColoring = not rColoring
    end
end
updateFiles()

local btn = main:addButton():setPosition(38, 5):onClick(function()
    updateFiles(math.random(1,8))
end)

basalt.autoUpdate()