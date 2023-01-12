local basalt = require(".UwUntuCC.OS.Libraries.Basalt")
local databaser = require(".UwUntuCC.OS.Libraries.Databaser")
local mainFrame = basalt.createFrame()

    local Label = mainFrame:addLabel()
        :setPosition(3,2)
        :setText("ID of Computer:")

    local Input = mainFrame:addInput()
        :setSize(20,1)
        :setPosition(4,3)
        :setDefaultText("ComputerID", colors.lightGray, colors.black)
        :setBackground(colors.black)
        :setForeground(colors.white)
    mainFrame:addLabel()
        :setPosition(3,3)
        :setText("\149")
        :setBackground(colors.black)
        :setForeground(colors.lightGray)

    local button = mainFrame:addButton()
        :setPosition(5,5)
        :setSize(8,1)
        :setText("Attach")
        :setForeground(colors.white)
        :setBackground(colors.green)
        :onClick(function()
            local id = Input:getValue()
            shell.run("attach", id, "computer")
        end)


    basalt.autoUpdate()

