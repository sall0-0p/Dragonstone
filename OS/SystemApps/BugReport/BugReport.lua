local basalt = require(".UwUntuCC.OS.Libraries.Basalt")

local discord = require(".UwUntuCC.OS.Libraries.DiscordHook")


local mainFrame = basalt.createFrame()

local rw, rh = mainFrame:getSize()

local log = fs.open("UwUntuCC/log.txt", "r")
    local data = log.readAll()
    log.close()

    data = textutils.unserialize(data)

    local name = data[1] or "General"
    local time = data[2] or os.date()
    local pclabel = data[3] or os.getComputerLabel() or "Not stated"
    local host = data[4] or _HOST
    local errorcode = data[5] or "Not given"

local MainScreen = mainFrame:addFrame()
    :setBackground(colors.lightGray) 

    local MainLabel = MainScreen:addLabel()
        :setFontSize(2)
        :setPosition(3,3)
        :setText(name.." crashed!")

    local ErrorCodeFrame = MainScreen:addFrame()
        :setBackground(colors.gray)
        :setSize(47,11)
        :setPosition(3,5)
        :setBorder(colors.lightGray)

    local ErrorCodeLabel = ErrorCodeFrame:addLabel()
        :setBackground(colors.gray)
        :setForeground(colors.white)
        :setText(errorcode)
        :setSize(44)
        :setPosition(2,2)
        --:setScrollable(true)

    local ReportButton = MainScreen:addButton()
        :setBackground(colors.gray)
        :setForeground(colors.white)
        --:setBorder(colors.lightGray)
        :setText("Report")
        :setPosition(37, 16)

    local FAQButton = MainScreen:addButton()
        :setPosition(4,16)
        :setSize(7,3)
        :setText("FAQ")
        :setBackground(colors.gray)
        :setForeground(colors.white)

local DescribeScreen = mainFrame:addFrame():hide()
    :setSize(rw,rh)
    :setBackground(colors.lightGray)
    
    local AdditionalIngo = DescribeScreen:addLabel()
        :setFontSize(2)
        :setPosition(3,3)
        :setText("Additional info")
    
    local InfoTextfieldFrame = DescribeScreen:addFrame()
        :setBackground(colors.gray)
        :setSize(47,11)
        :setPosition(3,5)
        :setBorder(colors.lightGray)

        local InfoTextfield = InfoTextfieldFrame:addTextfield()
            :setBackground(colors.gray)
            :setForeground(colors.white)
            :setSize(44, 7)
            :setPosition(2,2)
            :addLine("Give us as much info, as you can =)")
    
        local NextButton = DescribeScreen:addButton()
            :setBackground(colors.gray)
            :setForeground(colors.white)
            --:setBorder(colors.lightGray)
            :setText("Proceed")
            :setPosition(38, 16)
            :setSize(11,3)

        local BackButton = DescribeScreen:addButton()
            :setPosition(4,16)
            :setSize(8,3)
            :setText("Back")
            :setBackground(colors.gray)
            :setForeground(colors.white)

local EndScreen = mainFrame:addFrame():hide()
    :setBackground(colors.lightGray)

    local EndLabel = EndScreen:addLabel()
        :setFontSize(2)
        :setPosition(3,3)
        :setText("Thanks you!")

    local DiscordLabel = EndScreen:addLabel()
        :setPosition(3,5)
        :setSize(47,2)
        :setText("You can check your report in our discord:\n https://discord.gg/ANaFzp8n8Y")




ReportButton:onClick(function() 

    MainScreen:hide()
    DescribeScreen:show()

end)

BackButton:onClick(function() 
    DescribeScreen:hide()
    MainScreen:show()
end)

NextButton:onClick(function() 
    DescribeScreen:hide()
    EndScreen:show()
    local AdditInfo = InfoTextfield:getLines()
    AdditInfo = textutils.serialize(AdditInfo)
    local success, hook = discord.createWebhook("https://discord.com/api/webhooks/1023578650517442620/PwyQqrM-v_ysVr-Kc2yTM1f3fVlwZUw3ve-UCAc7QUk2uqf-91u_Yz3DA6b_49lJ8M6I")
    if not success then
        os.queueEvent("notification", "Failed!", "Check your internet connection and try again")
    end

    hook.sendEmbed("App: "..name, "New BugReport!", AdditInfo.." ".."\n\n```"..errorcode.."```\n TimeStamp: "..time.."\n Host: "..host.."\n PCLabel: "..pclabel, "", FF5835, nil, nil, nil, nil)
end)

    basalt.autoUpdate()
