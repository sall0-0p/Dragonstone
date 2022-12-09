local basalt = require(".UwUntuCC.OS.Libraries.Basalt")

return function(mainFrame) 
    
-- TODO: Update on 1.6.4
--[[
    local desktop = mainFrame:addFrame()
        :setSize(rw,rh)
        :setTexture(DesktopImage, "stretch")
]]

local rw, rh = mainFrame:getSize()

local useDesktopBG = true

if useDesktopBG then
    local DesktopImage = "UwUntuCC/OS/DesktopBackgrounds/Desktop3.bimg"

    local DesktopBG = mainFrame:addImage()
        :setSize(rw,rh)
        :setPosition(1,1)
        :loadImage(DesktopImage)
else
    
    local DesktopColor = colors.lightGray
    mainFrame:setBackground(DesktopColor)

end



end