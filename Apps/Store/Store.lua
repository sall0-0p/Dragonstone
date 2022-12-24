
local basalt = require(".UwUntuCC.OS.Libraries.Basalt")
local dir = "/UwUntuCC/Apps/Store"
local accentColor = settings.get("uwuntucc.accent_color")

local mainFrame = basalt.createFrame()

local homePage = mainFrame:addFrame()
    :addLayout(dir.."/test.xml") --"/assets/pages/main.xml"

--[[local contents = homePage:getObject("homePage"):getObject("content")
    local tApps = {}
    for i=1,6 do
        tApps[#tApps+1] = 
            contents:addFrame()
                :setPosition(i%2==1 and 2 or 26, (math.floor(i/2+0.5)-1)*14+3)
                :setSize(23,13)
                :addLayout(dir.."/assets/layout/large-widget.xml")
        tApps[#tApps]:getObject("widget"):getObject("content"):getObject("title")
            :setText("Title_"..i)
    end]]

basalt.autoUpdate()