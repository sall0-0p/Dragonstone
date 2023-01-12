if fs.exists("/Dragonstone") == false then
    print("Print")
    fs.makeDir("/Dragonstone")
    fs.move("/OS", "/Dragonstone/OS")
    fs.move("/Apps", "/Dragonstone/Apps")
    fs.makeDir("/Dragonstone/AppData")
    fs.makeDir("/Dragonstone/User")
    fs.makeDir("/Dragonstone/User/Downloads")
    fs.makeDir("/Dragonstone/User/Desktop")
    fs.makeDir("/Dragonstone/User/Bin")
    fs.makeDir("/Dragonstone/User/")
    fs.makeDir("/Dragonstone/User/Documents")
    
    settings.define("uwuntucc.accent_color")
    settings.set("uwuntucc.accent_color", colors.magenta)
    settings.save()
end

shell.setDir("Dragonstone/OS/Desktop/")
shell.run("main.lua")

if not os.getComputerLabel then
        os.setComputerLabel("UwU")
end

