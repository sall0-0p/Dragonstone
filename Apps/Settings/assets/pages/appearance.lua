local basalt = require(".UwUntuCC.OS.Libraries.Basalt")

return function(frame)
    local rw, rh = frame:getSize()
    -- default: 38 - 50
    local appearanceTitle = frame:addLabel()
        :setPosition(2,2)
        :setText("Appearance")

    local darkThemeImage = frame:addImage()
        :setPosition(rw.."-9", 2)
        :setSize(9,3)
        :setBackground(colors.gray)
        :loadImage("/UwUntuCC/Apps/Settings/assets/images/dark-theme.bimg")
    local lightThemeImage = frame:addImage()
        :setPosition(rw.."-19", 2)
        :setSize(9,3)
        :setBackground(colors.white)
        :loadImage("/UwUntuCC/Apps/Settings/assets/images/light-theme.bimg")

    --local communistThemeImage = frame:addImage()




end