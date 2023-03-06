
    settings.set("uwuntucc.accent_color", colors.orange)

    settings.set("uwuntucc.main_color", colors.gray)

    settings.set("uwuntucc.second_color", colors.lightGray)

    settings.set("uwuntucc.text_color1", colors.white)

    settings.set("uwuntucc.text_color2", colors.lightGray)

    term.setTextColor(colors.lime)
    settings.save()

    print("Success!")
    sleep(1)
    os.reboot()