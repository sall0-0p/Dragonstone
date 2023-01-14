local basalt = require(".Dragonstone.OS.Libraries.Basalt")

return function(mainFrame)
    local rw, rh = mainFrame:getSize()

    local screensaver = "/Dragonstone/OS/SystemApps/Screensavers/fireworks.lua"
    local useScreensaver = true
    local ScreenSaverTimeOut = 600
    local function launchScreensaver()
        os.shutdown()
        local mainFrame = require(".Dragonstone.OS.Desktop.values.mainFrame")
        shell.setDir(":")
        
        basalt.debugLabel
            :setBackground(colors.black)
        local ScreensaverProgram = mainFrame:addProgram()
            :setSize(rw,rh)
            :setZIndex(15)
            :setFocus()
            :execute(screensaver)
            
        --desktop:hide()
        --basalt.debug(ScreensaverProgram:getStatus())
        
        mainFrame:onClick(function()
            ScreensaverProgram:remove()
            scTimer:start()
            basalt.debugLabel
                :setBackground(colors.gray)
        end)
        mainFrame:onKey(function()
            ScreensaverProgram:remove()
            scTimer:start()
            basalt.debugLabel
                :setBackground(colors.gray)
        end)
    end

    if useScreensaver then
        scTimer = mainFrame:addTimer()
            :onCall(launchScreensaver)
            :setTime(ScreenSaverTimeOut)
            mainFrame:onClickUp(function()
                scTimer:cancel()
                scTimer:start()
    
            end)
            scTimer:start()
    end



end