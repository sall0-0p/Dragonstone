local basalt = require(".UwUntuCC.OS.Libraries.Basalt")
local highlightColor = colors.orange

return function(frame)
    local rw, rh = frame:getSize()
    -- default: 38 - 50
    local appearanceTitle = frame:addLabel()
        :setPosition(2,2)
        :setText("Appearance")

    local selectedThemePane = frame:addPane()
        :setPosition(rw.."-9", 5)
        :setSize(9,1)
        :setBackground(colors.lightGray, "\131", highlightColor)

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

    local accentColorLabel = frame:addLabel()
        :setPosition(2, 5)
        :setText("Accent Color:")

        local accentColor1 = frame:addFrame()
            :setSize(2,1)
            :setPosition(rw.."-2",6)
            :setBackground(colors.lime)

        local accentColor2 = frame:addFrame()
            :setSize(2,1)
            :setPosition(rw.."-5",6)
            :setBackground(colors.yellow)

        local accentColor3 = frame:addFrame()
            :setSize(2,1)
            :setPosition(rw.."-8",6)
            :setBackground(colors.orange)
         
        local accentColor4 = frame:addFrame()
            :setSize(2,1)
            :setPosition(rw.."-11",6)
            :setBackground(colors.red)

        local accentColor5 = frame:addFrame()
            :setSize(2,1)
            :setPosition(rw.."-14",6)
            :setBackground(colors.purple)

        local accentColor6 = frame:addFrame()
            :setSize(2,1)
            :setPosition(rw.."-17",6)
            :setBackground(colors.blue)

        local selectedColorPane = accentColor3:addPane()
            :setPosition(2,1)
            :setBackground(false, "\130", colors.gray)


end