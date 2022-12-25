local basalt = require(".UwUntuCC.OS.Libraries.Basalt")

return function(mainFrame)
    
local mainFrame = require(".UwUntuCC.OS.Desktop.values")
local TimeFormat = true
local TimeType = "local"
local rw, rh = mainFrame:getSize()



local header = mainFrame:addFrame()
    :setSize(rw,1)
    :setPosition(1,1)
    :setBackground(colors.gray)
    :setZIndex(2)

    local headerPanel1 = mainFrame:addFrame()
        :setSize(rw,1)
        :setPosition(1,2)
        :setBackground(false, "\131", colors.gray)
        :setZIndex(2)

    
    
    
    
    
    
    
    
    -- Clock services located here.
    local clock = header:addLabel()
        :setBackground(false)
        :setText("")
        :setForeground(colors.white)
        :setSize(15,1)
    
    local function RunClock()
        while true do
            local rw, rh = mainFrame:getSize()
            local time = os.time("local")
            day = os.date("%a %d %b")
            local clockWidth = rw - clock:getSize() - 1
            clock:setPosition(clockWidth,1)
            clock:setText(day.." "..textutils.formatTime(time, TimeFormat))
            sleep(5)
        end
    end

    local clockThread = mainFrame:addThread():start(RunClock)

end