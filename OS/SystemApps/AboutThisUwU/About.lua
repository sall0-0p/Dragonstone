
local basalt = require(".BucketOS.OS.Libraries.Basalt")

local mainFrame = basalt.createFrame():show()
    :setBackground(colors.black)
local Overview = mainFrame:addFrame()
    :setBackground(colors.black)
    :setPosition(1,2)
    :setSize(39,11)

local Storage = mainFrame:addFrame():hide()
    :setBackground(colors.black)
    :setPosition(1,2)
    :setSize(39,11)

local Support = mainFrame:addFrame():hide()
    :setBackground(colors.black)
    :setPosition(1,2)
    :setSize(39,11)

local Resources = mainFrame:addFrame():hide()
    :setBackground(colors.black)
    :setPosition(1,2)
    :setSize(39,11)


basalt.autoUpdate()