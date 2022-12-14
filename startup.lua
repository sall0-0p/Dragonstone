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
    
    settings.define("uwuntucc.accent_color")
    settings.set("uwuntucc.accent_color", colors.magenta)
    settings.save()
end

print("Print legacy to launch legacy Desktop")
print("Print new to launch desktop that currently in dev")
print("Print exit to stop launching and stay in terminal")

local desktop = read()

if desktop == "legacy" then
    print("Launching Legacy...")
    term.setTextColor(colors.red)
    print("If you encounter any bugs, contact me via discord")
    sleep(0.3)
    shell.setDir("UwUntuCC/OS/SystemApps/Desktop/")
    shell.run("Desktop.lua")
elseif desktop == "new" then
    print("Launching New...")
    term.setTextColor(colors.red)
    print("If you encounter any bugs contact me via discord")
    sleep(0.3)
    shell.setDir("UwUntuCC/OS/Desktop/")
    shell.run("main.lua")
else
    print("Exiting...")
    print("You can speedup levelOS beating progress by joining my team.")
    print("Contact _lordBucket")
end

if not os.getComputerLabel then
        os.setComputerLabel("UwU")
end

