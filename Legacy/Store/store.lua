--- App Store
--- Sammy.K (c) 2022 | MIT Licence

local basalt = require(".UwUntuCC.OS.Libraries.Basalt")
local dir = "/UwUntuCC/Apps/Store"
local main = basalt.createFrame()
local page = main:addFrame()
    :addLayout(dir.."/layout/main.xml")

page:getObject("main"):getObject("header"):getObject("disk_used_space")
    :setProgress(45)

local tApps = {}
for i=1,6 do
    tApps[#tApps+1] = 
        page:getObject("main"):getObject("content"):addFrame()
            :setPosition(i%2==1 and 3 or "(parent.w-6)/2+4", (math.floor(i/2+0.5)-1)*7+3)
            :setSize("(parent.w-6)/2",6)
            :addLayout(dir.."/layout/widget.xml")
    tApps[#tApps]:getObject("widget"):getObject("content"):getObject("title")
        :setText("Title_"..i)
end

basalt.autoUpdate()