if fs.exists("/UwUntuCC") == false then
    print("Print")
    fs.makeDir("/UwUntuCC")
    fs.move("/OS", "/UwUntuCC/OS")
    fs.move("/Apps", "/UwUntuCC/Apps")
    fs.makeDir("/UwUntuCC/AppData")
    fs.makeDir("/UwUntuCC/User")
    fs.makeDir("/UwUntuCC/User/Downloads")
    fs.makeDir("/UwUntuCC/User/Desktop")
    fs.makeDir("/UwUntuCC/User/Bin")
    fs.makeDir("/UwUntuCC/User/")
    fs.makeDir("/UwUntuCC/User/Documents")
end

local OSLabel = os.getComputerLabel()

if OSLabel == nil then
        os.setComputerLabel("UwU")
end

local basalt = require(".UwUntuCC.OS.Libraries.Basalt")

local mainFrame = basalt.createFrame("main")
    :setBackground(colors.black)
    
local rw, rh = mainFrame:getSize()

    logo = mainFrame:addLabel()
        :setText("UwU")
        :setFontSize(3)
        :setForeground(colors.magenta)
        :setBackground(colors.black)
    local lw, lh = logo:getSize()
        local lx = math.floor(rw/2 - lw - 9)
        local ly = math.floor(rh/2 - lh - 2)
        logo:setPosition(lx, ly)

    local LoadingBar = mainFrame:addProgressbar()
        :setSize(rw.."/3", 1)
        :setPosition(rw.."/3", ly.."+8")
        :setProgressBar(colors.magenta)

    local MOTD = mainFrame:addLabel()
        :setBackground(colors.black)
        :setForeground(colors.white)


local CenterMOTD = function()
    local mw, mh = MOTD:getSize()

    local mx = rw/2 - mw/2
    local my = ly + 10
    MOTD:setPosition(mx, my)
end


local function checkVersion(version)
    local request = http.get("https://raw.githubusercontent.com/sall0-0p/UwUntuCC/master/OS/Version.md")
            
        local content = request.readAll()
        request.close()
        return content
end

if fs.exists("UwUntuCC/OS/Version.md") then
    local file = fs.open("UwUntuCC/OS/Version.md", "r")
        version = file.readAll()
        file.close()
end
if version == nil then
   version = "???"
end


local serverVersion = checkVersion(version)

if serverVersion == version then

    local f = fs.open("UwUntuCC/OS/MOTD", "r")
    local MOTDs = f.readAll()
    MOTDs = textutils.unserialise(MOTDs)
    f.close()

    MOTDid = math.random(1, table.getn(MOTDs))

    MOTD:setText(MOTDs[MOTDid])
    CenterMOTD()

else

    MOTD:setText("Update Found! "..serverVersion)
    CenterMOTD()
end

local progress = 0
local progressBarVis = function()
    while true do
        LoadingBar:setProgress(progress)
        progress = progress+1
        sleep(0.02)
        if progress >= 100 then
            break
        end
    end
end

local Update = function()
    basalt.autoUpdate()
end

parallel.waitForAny(progressBarVis, Update)
shell.setDir("/UwUntuCC/OS/SystemApps/Desktop")
shell.run("Desktop.lua")

