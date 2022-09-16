local basalt = require(".BucketOS.OS.Libraries.Basalt")
local databaser = require(".BucketOS.OS.Libraries.Databaser.main")
local ProgramsRunning = databaser.getColumn("RunningWindows", "name")
ProgramsRunning = table.getn(ProgramsRunning) - 1

local mainFrame = basalt.createFrame()
    :setBackground(colors.lightGray)

    local ShutDownButton = mainFrame:addButton()
        :setPosition(16, 6)
        :setSize(10, 1)
        :setText("Shutdown")
        :setBackground(colors.gray)
        :setForeground(colors.white)

    local ReloadButton = mainFrame:addButton()
        :setPosition(7,6)
        :setSize(8, 1)
        :setText("Reboot")
        :setBackground(colors.gray)
        :setForeground(colors.white)

    local AreYouSureLabel = mainFrame:addLabel()
        :setPosition(3,2)
        :setText("\4 Are you sure?")
        :setBackground(false)
        :setForeground(colors.black)
    
    local RunningLabel = mainFrame:addLabel()
        :setPosition(3,3)
        :setSize(20,2)
        :setBackground(false)
        :setForeground(colors.black)

        if ProgramsRunning > 1 then
            RunningLabel:setText("You have "..ProgramsRunning.." programs currently running")
        elseif ProgramsRunning == 0 then
            RunningLabel:setText("You have no programs running =)")
        else
            RunningLabel:setText("You have "..ProgramsRunning.." program currently running")
        end

        ShutDownButton:onClick(function()
            os.shutdown()
        end)

        ReloadButton:onClick(function()
            os.reboot()
        end)

    

basalt.autoUpdate()

