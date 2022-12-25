local basalt = require(".UwUntuCC.OS.Libraries.Basalt")

return function(mainFrame)
    local rw, rh = mainFrame:getSize()

    local screensaver = "/UwUntuCC/OS/SystemApps/Screensavers/fireworks.lua"
    local useScreensaver = true
    local ScreenSaverTimeOut = 10
    local function launchScreensaver()

        local mainFrame = require(".UwUntuCC.OS.Desktop.values")
        shell.setDir(":")
        basalt.debugLabel
            :setBackground(colors.black)
        local ScreensaverProgram = mainFrame:addProgram()
            :setSize(rw,rh)
            :setFocus()
            :execute(screensaver)
            :setZIndex(15)
        --desktop:hide()
        basalt.debug(ScreensaverProgram:getStatus())
        
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