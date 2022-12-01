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

package.path = "/UwUntuCC/OS/Libraries/?.lua;/UwUntuCC/OS/Libraries/?/init.lua;" .. package.path

local desktop = read()

if desktop ~= 1 then
    shell.setDir("/UwUntuCC/OS/SystemApps/Desktop")
    shell.run("Desktop.lua")
else
    shell.setDir("/UwUntuCC/OS/Desktop")
    shell.run("main.lua")
end


local OSLabel = os.getComputerLabel()

if OSLabel == nil then
        os.setComputerLabel("UwU")
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

if serverVersion ~= version then

    os.queueEvent("notification", "Update found!", serverVersion.." is out! Try it now!")

end
