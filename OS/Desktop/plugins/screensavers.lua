local basalt = require(".UwUntuCC.OS.Libraries.Basalt")

return function(mainFrame, p1, p2, p3, p4, p5)
    local rw, rh = mainFrame:getSize()

    local screensaver = "UwUntuCC/OS/SystemApps/ScreenSavers/fireworks.lua"
    local useScreensaver = true
    local ScreenSaverTimeOut = 600
    local function launchScreensaver()
        shell.setDir(":")
        basalt.debugLabel
            :setBackground(colors.black)
        local ScreensaverProgram = p5:addProgram()
            :setSize(rw,rh)
            :setFocus()
            :execute(screensaver)
        --desktop:hide()
        
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