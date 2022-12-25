local basalt = require(".UwUntuCC.OS.Libraries.Basalt")

local title = "Hello!"

local mainFrame = basalt.createFrame()
    :setBackground(colors.black)

local Label = mainFrame:addLabel()
    :setForeground(colors.magenta)
    :setBackground(colors.black)
    :setText(title)
    :setFontSize(3)
    :setAnchor("center")

basalt.autoUpdate()