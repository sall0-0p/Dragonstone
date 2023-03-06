local basalt = require(".Dragonstone.OS.Libraries.Basalt")

return function(mainFrame) 
    
local mainFrame = require(".Dragonstone.OS.Desktop.values.mainFrame")
-- TODO: Update on 1.6.4
--[[
    local desktop = mainFrame:addFrame()
        :setSize(rw,rh)
        :setTexture(DesktopImage, "stretch")
]]

local rw, rh = mainFrame:getSize()

local useDesktopBG = settings.get("uwuntucc.useDesktopBG")
local DesktopBG
if useDesktopBG == "true" then
    local DesktopImage = "/Dragonstone/OS/DesktopBackgrounds/VenturaLight-low.bimg"--/settings.get("uwuntucc.desktopBG")

    --[[local DesktopBG = mainFrame:addImage()
        :setSize(rw,rh)
        :setPosition(1,1)
        :setZIndex(1)
        :loadImage(DesktopImage)]]

    DesktopBG = mainFrame:addFrame()
        :setSize(rw, rh)
        :setPosition(1,1)
        :setZIndex(1)
        :setTexture(DesktopImage, "stretch")
else
    
    local DesktopColor = settings.get("uwuntucc.desktopColor")
    mainFrame:setBackground(DesktopColor)

end


mainFrame:onResize(self, function() 
    if useDesktopBG == "true" then
        DesktopBG
            :setSize("parent.w", "parent.h")
            :setTexture(DesktopImage, "stretch")
    end

end)


end