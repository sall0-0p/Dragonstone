local version
local success
local basalt = require(".BucketOS.OS.Libraries.Basalt")

local function checkVersion(version)
    local request = http.get("https://raw.githubusercontent.com/sall0-0p/UwUntuCC/master/OS/Version.md")
    
    local content = request.readAll()
    request.close()
    return content
end

if fs.exists("BucketOS/OS/Version.md") then
    local file = fs.open("BucketOS/OS/Version.md", "r")
        version = file.readAll()
        file.close()
end
if version == nil then
   version = "???"
end
local mainFrame = basalt.createFrame():show()
    :setBackground(colors.gray)

local Overview = mainFrame:addFrame()
    :setBackground(colors.black)
    :setPosition(1,2)
    :setSize(39,13)
    :setScrollable(true)

local Storage = mainFrame:addFrame():hide()
    :setBackground(colors.black)
    :setPosition(1,2)
    :setSize(39,13)

local Support = mainFrame:addFrame():hide()
    :setBackground(colors.black)
    :setPosition(1,2)
    :setSize(39,13)

local Resources = mainFrame:addFrame():hide()
    :setBackground(colors.black)
    :setPosition(1,2)
    :setSize(39,13)


local MenuBar = mainFrame:addMenubar()
    :setBackground(colors.gray)
    :setSelectedItem(colors.gray, colors.white)
    :setForeground(colors.lightGray)
    :setPosition(8,1)
    :setSize(28,1)
    :setScrollable(true)
    :addItem("Overview", colors.gray, colors.lightGray)
    :addItem("Storage", colors.gray, colors.lightGray)
    :addItem("Support", colors.gray, colors.lightGray)
    --:addItem("Resources", colors.gray, colors.lightGray)

    MenuBar:onChange(function()
        if MenuBar:getItemIndex() == 1 then
            Overview:show()
            Storage:hide()
            Support:hide()
            Resources:hide()
        elseif MenuBar:getItemIndex() == 2 then
            Overview:hide()
            Storage:show()
            Support:hide()
            Resources:hide()
        elseif MenuBar:getItemIndex() == 3 then
            Overview:hide()
            Storage:hide()
            Support:show()
            Resources:hide()
        else
            Overview:hide()
            Storage:hide()
            Support:hide()
            Resources:show()
        end
    end)

local UwULabel = Overview:addLabel()
    :setText("UwUntu")
    :setFontSize(2)
    :setForeground(colors.magenta)
    :setBackground(colors.black)
    :setPosition(15,3)

local VersionLabel = Overview:addLabel()
    :setText("Version: "..version)
    :setForeground(colors.magenta)
    :setBackground(colors.black)
    :setPosition(17,5)

--[[local OSLogo = Overview:addImage():loadImage("BucketOS/OS/SystemApps/AboutThisUwU/logo.nfp"):shrink()
    :setPosition(2,4)
    :setSize(12,8)]]--

local CPULabel = Overview:addLabel()
    :setText("\4 CPU: Idk")
    :setForeground(colors.white)
    :setBackground(colors.black)
    :setPosition(17,7)
local IDLabel = Overview:addLabel()
    :setText("\4 ID: "..os.getComputerID())
    :setForeground(colors.white)
    :setBackground(colors.black)
    :setPosition(17,8)
local ComputerLabelVisual = Overview:addLabel()
    :setText("\4 Label: "..os.getComputerLabel())
    :setForeground(colors.white)
    :setBackground(colors.black)
    :setPosition(17,9)

local ChangeLabel = Overview:addButton()
    :setText(" Edit ")
    :setForeground(colors.white)
    :setBackground(colors.gray)
    :setPosition(17,11)
    :setSize(6,1)

local CheckVersions = Overview:addButton()
    :setText(" Updates ")
    :setForeground(colors.white)
    :setBackground(colors.gray)
    :setPosition(25, 11)
    :setSize(9,1)

local Copyright = Overview:addLabel()
    :setText("© UwUntuCC 2022")
    :setForeground(colors.lightGray)
    :setBackground(colors.black)
    :setPosition(24,13)

local LabelWindow = Overview:addFrame():hide()
    :setBackground(colors.lightGray)
    :setSize(16,6)
    :setPosition(13,4)
    :setMovable(true)
    :setBar(" ", colors.gray, colors.gray):showBar()
    ChangeLabel:onClick(function() 
        LabelWindow:show()
    end)


        local CloseButton = LabelWindow:addButton()
            :setSize(1,1)
            :setBackground(false)
            :setForeground(colors.red)
            :setText("\7")
            :setPosition(2,1)
            
            :onClick(function() 
                LabelWindow:hide()
            end)


    local LabelWindowInput = LabelWindow:addInput()
        :setDefaultText(os.getComputerLabel(), colors.lightGray, colors.black)
        :setSize(14, 1)
        :setPosition(2,3)
        :setBackground(colors.black)
        :setForeground(colors.white)
    
    local ApplyButton = LabelWindow:addButton()
        :setText(" Apply ")
        :setSize(7,1)
        :setPosition(9,5)
        :setBackground(colors.gray)
        :setForeground(colors.white)

        :onClick(function() 
            local ComputerLabel = LabelWindowInput:getValue()
                os.setComputerLabel(ComputerLabel)
                ComputerLabelVisual:setText("\4 Label: "..os.getComputerLabel())
                LabelWindow:hide()
        end)

local UpdatesWindow = Overview:addFrame():hide()
    :setBackground(colors.lightGray)
    :setSize(16,6)
    :setPosition(13,4)
    :setMovable(true)
    :setBar(" ", colors.gray, colors.gray):showBar()
    

        local CloseButton = UpdatesWindow:addButton()
            :setSize(1,1)
            :setBackground(false)
            :setForeground(colors.red)
            :setText("\7")
            :setPosition(2,1)
            
            :onClick(function() 
                UpdatesWindow:hide()
            end)
        local StatusLabel = UpdatesWindow:addLabel()
            :setSize(14,1)
            :setPosition(2,3)
            :setBackground(false)
            :setForeground(colors.black)
            :setText("  No Updates =)")
    CheckVersions:onClick(function() 
        UpdatesWindow:show()
        local success = checkVersion(version)
        if success ~= version then
            StatusLabel:setText(" Update Found ")
        elseif success == nil then
            StatusLabel:setText(" Check Failed ER: 404 ")
        elseif success == version then

        else
            StatusLabel:setText(" Check Failed ER: 405 ")
        end
    end)


    local DiskFrame = Storage:addFrame()
        :setBackground(colors.black)
        :setSize(39,3)
        :setPosition(1,1)
        local Load = 0
        if fs.getFreeSpace("BucketOS") < 1000000 then
            local Load = fs.getFreeSpace("BucketOS")/1000000 * 100
        end
        local DiskIcon = DiskFrame:addImage():loadImage("BucketOS/OS/Icons/Disks/Blue.nfp"):shrink()
            :setPosition(2,2)
            :setSize(3,3)

        local DiskName = DiskFrame:addLabel()
            :setText("HDD "..Load.." %")
            :setPosition(6,2)
            :setBackground(colors.black)
            :setForeground(colors.lightGray)
            :setSize(13,1)

        local DiskProgress = DiskFrame:addProgressbar()
            :setDirection(0)
            :setBackground(colors.gray)
            :setProgressBar(colors.lightGray, " ")
            :setPosition(6,3)
            :setSize(29)

            if Load < 4 then
                DiskProgress:setProgress(4)
                :setDirection(0)
            else
                DiskProgress:setProgress(Load)
                :setDirection(3)
            end


    local GitHubLabel = Support:addLabel()
        :setText("\4 GitHub: ")
        :setPosition(2,2)
        :setForeground(colors.white)
        :setBackground(false)
        local GitHubLinkLabel = Support:addLabel()
        :setText("https://github.com/sall0-0p/UwUntuCC")
        :setPosition(3,3)
        :setForeground(colors.lightGray)
        :setBackground(false)

    local DiscordLabel = Support:addLabel()
        :setText("\4 Discord: ")
        :setPosition(2,5)
        :setForeground(colors.white)
        :setBackground(false)
        local DiscordLinkLabel = Support:addLabel()
        :setText("https://discord.gg/ANaFzp8n8Y")
        :setPosition(3,6)
        :setForeground(colors.lightGray)
        :setBackground(false)

    local ImportantLabel = Support:addLabel()
        :setText("LOOKING FOR DEVS =)")
        :setPosition(2,12)
        :setForeground(colors.magenta)
        :setBackground(false)


basalt.autoUpdate()





