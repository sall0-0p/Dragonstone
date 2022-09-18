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

shell.setDir("/UwUntuCC/OS/SystemApps/Desktop/")
shell.run("Desktop.lua")
