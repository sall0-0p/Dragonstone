
local basalt = require(".BucketOS.OS.Libraries.Basalt")

basalt.debug("This is debug from basalt!")
local mainFrame = basalt.createFrame():show()
    mainFrame:setBackground(colors.gray)



basalt.autoUpdate()