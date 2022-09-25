local basalt = require(".UwUntuCC.OS.Libraries.Basalt")

local mainFrame = basalt.createFrame()

local MainScreen = mainFrame:addFrame()

local MainLabel = MainScreen:addLabel()
    :setFontSize(2)
    :setPosition(5,5)
    :setText(name)

    basalt.autoUpdate()
