local basalt = require(".UwUntuCC.OS.Libraries.Basalt")

return function(mainFrame) 
    
local mainFrame = require(".UwUntuCC.OS.Desktop.values")
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
        :setZIndex(1)
        :loadImage(DesktopImage)

    local DesktopBG = mainFrame:addFrame()
        :setSize(rw, rh)
        :setPosition(1,1)
        :setZIndex(1)
        :setTexture(DesktopImage, "stretch")
else
    
    local DesktopColor = colors.lightGray
    mainFrame:setBackground(DesktopColor)

end


mainFrame:onResize(function() 
    basalt.debug("RESIZED")
    local rw, rh = mainFrame:getSize()

    DesktopBG
        :setSize(rw, rh)
        :setTexture(DesktopImage, "stretch")


end)


end