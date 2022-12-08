local basalt = require(".UwUntuCC.OS.Libraries.Basalt")

return function(mainFrame)
    
local TimeFormat = true
local TimeType = "local"
local rw, rh = mainFrame:getSize()

basalt.debug(rw, rh)

local footer = mainFrame:addFrame()
    :setSize(rw,1)
    :setPosition(1,1)
    :setBackground(colors.gray)

    local footerPanel1 = mainFrame:addFrame()
        :setSize(rw,1)
        :setPosition(1,2)
        :setBackground(false, "\131", colors.gray)

    
    
    
    
    
    
    
    
    -- Clock services located here.
    local clock = footer:addLabel()
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