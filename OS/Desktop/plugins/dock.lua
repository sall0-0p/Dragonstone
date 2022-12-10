local basalt = require(".UwUntuCC.OS.Libraries.Basalt")
local debug = false
return function(mainFrame, p1, p2, p3, p4, p5) 
    if debug then

        local rw, rh = mainFrame:getSize()
        local trFrame = p2:addFrame()
            :setSize(rw, 15)
            :setPosition(1, rh.."-14")
            :setBackground(false)

        local dockFrame = trFrame:addFrame()
            :setSize(math.floor(rw/2), 3)
            :setPosition(math.floor(rw/4), 11)
            :setBackground(colors.gray)


    end

end