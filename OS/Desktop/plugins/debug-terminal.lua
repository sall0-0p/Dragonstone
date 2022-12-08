local basalt = require(".UwUntuCC.OS.Libraries.Basalt")

return function(mainFrame)
    shell.setDir("/")
    local rw, rh = mainFrame:getSize()
    mainFrame:addFrame()
        :setPosition(rw.."-55", rh.."-23")
        :setSize(53, 21)
        :addProgram()
            :setPosition(2,2)
            :setSize(51, 19)
            :execute("/UwUntuCC/Apps/Terminal/Terminal.lua")
end