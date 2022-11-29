local basalt = require(".UwUntuCC.OS.Libraries.Basalt")
local main = basalt.createFrame()

local files = fs.list("/")

local fileObjects = {}
local fileList = main:addFrame():setSize(35, 12):setScrollable()

local function updateFiles()
    for k,v in pairs(fileObjects)do
        v.pane:remove()
        v.label:remove()
    end
    local rColoring = false
    local y = 1
    for k,v in pairs(files)do
        local group = {}
        group.pane = fileList:addPane():setSize("parent.w", 1):setPosition(1, y):setBackground(rColoring and colors.black or colors.white)
        group.label = fileList:addLabel():setText(v):setPosition(3, y):setBackground(rColoring and colors.black or colors.white):setForeground(rColoring and colors.white or colors.black)
        y = y+1
        rColoring = not rColoring
        table.insert(fileObjects, group)
    end
end
updateFiles()

basalt.autoUpdate()