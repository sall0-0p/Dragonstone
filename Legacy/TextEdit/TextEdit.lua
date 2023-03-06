local basalt = require(".Dragonstone.OS.Libraries.Basalt")

local mainFrame = basalt.createFrame()


local header = mainFrame:addFrame()
    :setSize("parent.w", 1)
    :setPosition(1,1)
    :setBackground(colors.gray)

local headerBorder = mainFrame:addFrame()
    :setSize("parent.w", 1)
    :setPosition(1,2)
    :setBackground(false, "\131", colors.gray)
local textArea = mainFrame:addTextfield()
    :setSize("parent.w-2", "parent.h-3")
    :setPosition(2,3)
    :setBackground(colors.lightGray)


local fileButton = header:addButton()
    :setSize(6, 1)
    :setPosition(1, 1)
    :setBackground(false)
    :setForeground(colors.lightGray)
    :setText("File")

basalt.autoUpdate()