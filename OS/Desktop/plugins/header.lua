local basalt = require(".Dragonstone.OS.Libraries.Basalt")

local accentColor = settings.get("uwuntucc.accent_color")
local mainColor = settings.get("uwuntucc.main_color")
local secondColor = settings.get("uwuntucc.second_color")
local text_color1 = settings.get("uwuntucc.text_color1")
local text_color2 = settings.get("uwuntucc.text_color2")

return function(mainFrame)
    
local mainFrame = require(".Dragonstone.OS.Desktop.values.mainFrame")
local TimeFormat = true
local TimeType = "local"
local rw, rh = mainFrame:getSize()



local header = mainFrame:addFrame()
    :setSize(rw,1)
    :setPosition(1,1)
    :setBackground(mainColor)
    :setZIndex(2)

    local headerPanel1 = mainFrame:addFrame()
        :setSize(rw,1)
        :setPosition(1,2)
        :setBackground(false, "\131", mainColor)
        :setZIndex(2)

    
    
    
    
    
    
    
    
    -- Clock services located here.
    local clock = mainFrame:addLabel()
        :setBackground(false)
        :setText("")
        :setForeground(text_color1)
        :setZIndex(12)
        :setSize(16,1)
    
    local function RunClock()
        while true do
            local rw, rh = mainFrame:getSize()
            local time = os.time("local")
            day = os.date("%a %d %b")
            local clockWidth = rw - clock:getSize()
            clock:setPosition(clockWidth,1)
            clock:setText(day.." "..textutils.formatTime(time, TimeFormat))
            sleep(5)
        end
    end

    local clockThread = mainFrame:addThread():start(RunClock)

end