local basalt = require(".Dragonstone.OS.Libraries.Basalt")

return function(mainFrame)
    local mainFrame = require(".Dragonstone.OS.Desktop.values.mainFrame")
    local closeFrame = require(".Dragonstone.OS.Desktop.values.closeFrame")

    local launchMenuStatus = false
    local launchIcon = mainFrame:addImage()
        :setSize(3,2)
        :setPosition(1, "parent.h-2") 
        :setZIndex(18)
        :setBackground(colors.red)
        :loadImage("/Dragonstone/OS/Icons/LaunchIcon.bimg")

    
    local rw, rh = mainFrame:getSize()
    
    local launchMenu = mainFrame:addFrame()
        :setSize(30, 25)
        :setPosition(1, "parent.h+5") --1, "parent.h-26"
        :setZIndex(16)
        :addLayout("/Dragonstone/OS/Desktop/layouts/launchMenu/main.xml")

        local sidebar = launchMenu:addFrame()
            :setSize(3, "parent.h")
            :addLayout("/Dragonstone/OS/Desktop/layouts/launchMenu/sidebar.xml")

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


    -- shutdown menu
    local SHmenuStatus = false
    local shutdownMenu = launchMenu:addFrame()
        :setSize(15,5)
        :setPosition(-15, 4)
        :setBackground(colors.white)
        :setBorder(colors.gray)
        :setZIndex(10)
        :addLayout("/Dragonstone/OS/Desktop/layouts/launchMenu/shutdown.xml")

    
    local SHshow = mainFrame:addAnimation()
        :clear()
        :setObject(shutdownMenu)
        :move(4, 4, 0.3)
    
    local SHhide = mainFrame:addAnimation()
        :clear()
        :setObject(shutdownMenu)
        :move(-15, 4, 0.3)

    
    local SHMenuButton = sidebar:getObject("main"):getObject("shutdown")
    local SPMenuButton = sidebar:getObject("main"):getObject("settings")

        SHMenuButton:onClickUp(function() 
            if SHmenuStatus == false then
            SHshow:play()
            SHmenuStatus = true
                launchMenu:onClick(function()
                    SHhide:play()
                    SHmenuStatus = false
                end)
                
            else
                SHhide:play()
                SHmenuStatus = false
            end
        
        end)

    local shutdownBtn = shutdownMenu:getObject("main"):getObject("shutdown")
        shutdownBtn:onClick(function() os.shutdown() end)
    local rebootBtn = shutdownMenu:getObject("main"):getObject("reboot")
        rebootBtn:onClick(function() os.reboot() end)
    
        local win = require(".Dragonstone.OS.Libraries.windowingSystem")

        SPMenuButton:onClickUp(function()
            
            local settingsWIN = win.create()
                :setSize(51,19)
                :setBar("Settings")
                :run("/Dragonstone/Apps/Settings/Settings.lua")
        
        end)

     launchMenu:onClick()
end