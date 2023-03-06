local basalt = require(".Dragonstone.OS.Libraries.Basalt")

local win = require(".Dragonstone.OS.Libraries.windowingSystem")

return function(mainFrame)
    local mainFrame = require(".Dragonstone.OS.Desktop.values.mainFrame")
    local closeFrame = require(".Dragonstone.OS.Desktop.values.closeFrame")

    local accentColor = settings.get("uwuntucc.accent_color")
    local mainColor = settings.get("uwuntucc.main_color")
    local secondColor = settings.get("uwuntucc.second_color")
    local text_color1 = settings.get("uwuntucc.text_color1")
    local text_color2 = settings.get("uwuntucc.text_color2")

    local launchMenuStatus = false
    local launchIcon = mainFrame:addImage()
        :setSize(3,2)
        :setPosition(1, "parent.h-2") 
        :setZIndex(18)
        :setBackground(colors.red)
        :loadImage("/Dragonstone/OS/Icons/LaunchIcon.bimg")

    basalt.setVariable("mainColor", mainColor)

    local function DoubleClick(btn, func, mouseButton)
        local doubleClickMaxTime = 0.20 -- in seconds
        local doubleClick = 0
        btn:onClick(function(self, event, button)
            if(os.epoch("local")-doubleClickMaxTime*1000<=doubleClick)then
                if button == mouseButton then
                    func()
                end
                doubleClick = 0
            end
            doubleClick = os.epoch("local")
        end)
    end

    
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

        local selectedItem

        local launchList = launchMenu:addList()
            :setSize("20", "parent.h-2")
            :setPosition(5, 2)
            :setBackground(colors.black)
            :setSelectedItem(colors.black, colors.white)
            :setZIndex(17)

            local apps = fs.list("/Dragonstone/Apps")

            for i,v in pairs(apps) do
                launchList:addItem(fs.getName(v), colors.black, colors.lightGray)
            end

            launchList:onChange(function() 
                selectedItem = launchList:getItemIndex()
            end)

            DoubleClick(launchList, function() 
                local item = "/Dragonstone/Apps/"..apps[selectedItem].."/"..apps[selectedItem]..".lua"
                --basalt.debug(item)

                local success, errormsg = pcall(function()
                    local window = win.create()
                        :setSize(51,19)
                        :setBar(apps[selectedItem])
                        :run(item)
                        
                end)
                
                if not success then
                    os.queueEvent("notification", "Program Crashed!", "Error log was written to 'dragonstone' directory")
                    
                    pcall(function() 
                        local file = fs.open("/Dragonstone/crash-log.log", "w")
                        file.write(errormsg)
                    
                        file.close()
                    end)
                end

                
            
            
            end, 1)

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
        :setZIndex(18)
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

            local success, errormsg = pcall(function()
                local settingsWIN = win.create()
                    :setSize(51,19)
                    :setBar("Settings")
                    :run("/Dragonstone/Apps/Settings/Settings.lua")
                    
            end)
            
            if not success then
                os.queueEvent("notification", "Program Crashed!", "Error log was written to 'dragonstone' directory")
                
                pcall(function() 
                    local file = fs.open("/Dragonstone/crash-log.log", "w")
                    file.write(errormsg)
                
                    file.close()
                end)
            end

            
        
        end)

    mainFrame:onEvent(function(self, event) 
        if event == "uwuntu.fullscreen_off" then
            launchIcon:show()
            launchMenu:show()
        end
        if event == "uwuntu.fullscreen_on" then
            launchIcon:hide()
            launchMenu:hide()
        end
    end)

    launchMenu:onClick()
end