local basalt = require(".Dragonstone.OS.Libraries.Basalt")

return function(mainFrame)
    local mainFrame = require(".Dragonstone.OS.Desktop.values.mainFrame")
    local closeFrame = require(".Dragonstone.OS.Desktop.values.closeFrame")

    local launchMenuStatus = false
    local launchIcon = mainFrame:addImage()
        :setSize(3,2)
        :setPosition(1, "parent.h-2") 
        :setZIndex(13)
        :setBackground(colors.red)
        :loadImage("/Dragonstone/OS/Icons/LaunchIcon.bimg")

    
    local rw, rh = mainFrame:getSize()
    
    local launchMenu = mainFrame:addFrame()
        :setSize(30, 25)
        :setPosition(1, "parent.h") --1, "parent.h-26"
        :setZIndex(4)
        :addLayout("/Dragonstone/OS/Desktop/layouts/launchMenu/main.xml")

        local LMshow = mainFrame:addAnimation()
            :clear()
            :setObject(launchMenu)
            :move(1, rh-26, 0.4)
            
            
        local LMhide = mainFrame:addAnimation()
            :clear()
            :setObject(launchMenu)
            :move(1, rh, 0.3)



    launchIcon:onClick(function() 
        if launchMenuStatus == false then
            rw, rh = mainFrame:getSize()
            LMshow:play()
            launchMenuStatus = true
            closeFrame:onClick(function() 
                rw, rh = mainFrame:getSize()
                LMhide:play()
                launchMenuStatus = false
            
            end)
        else
            rw, rh = mainFrame:getSize()
            LMhide:play()
            launchMenuStatus = false
        end
        
    end)

    

    launchMenu:onClick()
end