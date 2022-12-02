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

local desktop = read()

print("Print legacy to launch legacy Desktop")
print("Print new to launch desktop that currently in dev")


if desktop == "legacy" then
    print("Launching Legacy")
    sleep(0.3)
    shell.setDir("UwUntuCC/OS/SystemApps/Desktop/")
    shell.run("Desktop.lua")
else
    print("Launching New")
    sleep(0.3)
    shell.setDir("UwUntuCC/OS/Desktop/")
    shell.run("main.lua")
end


local OSLabel = os.getComputerLabel()

if OSLabel == nil then
        os.setComputerLabel("UwU")
end
