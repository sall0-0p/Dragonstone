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

    settings.define("uwuntucc.main_color")
    settings.set("uwuntucc.main_color", colors.gray)

    settings.define("uwuntucc.second_color")
    settings.set("uwuntucc.second_color", colors.lightGray)
    
    settings.define("uwuntucc.text_color1")
    settings.set("uwuntucc.text_color1", colors.white)

    settings.define("uwuntucc.text_color2")
    settings.set("uwuntucc.text_color2", colors.lightGray)

    settings.define("uwuntucc.useDesktopBG")
    settings.set("uwuntucc.useDesktopBG", "true")

    settings.define("uwuntucc.desktopBG")
    settings.set("uwuntucc.desktopBG", "Dragonstone/OS/DesktopBackgrounds/VenturaLight-low.bimg")

    settings.define("uwuntucc.desktopColor")
    settings.set("uwuntucc.desktopColor", colors.lightGray)

    settings.save()
end

shell.setDir("Dragonstone/OS/Desktop/")
shell.run("main.lua")

if not os.getComputerLabel then
        os.setComputerLabel("UwU")
end

