--TODO: make Silent Apps (do not appear in dock)
--TODO: Button for moving unmovable windows

--119 x 50

--  _  _ ___   _   ___  
-- | || | __| /_\ |   \ 
-- | __ | _| / _ \| |) |
-- |_||_|___/_/ \_\___/ 

-- API --
local databaser = require(".BucketOS.OS.Libraries.Databaser.main")
local basalt = require(".BucketOS.OS.Libraries.Basalt")

local mainFrame = basalt.createFrame():show()   
mainFrame:setBackground(colors.lightGray)
local rw, rh = mainFrame:getSize()

--basalt.debug(textutils.formatTime(os.time("local"), true))

local function Update()
    basalt.autoUpdate()
end

databaser.setDir("BucketOS/OS/Data")
databaser.deleteColumn("RunningWindows", "name")
databaser.deleteColumn("RunningWindows", "path")
databaser.deleteColumn("RunningWindows", "executable")
databaser.deleteColumn("RunningWindows", "hidden")

databaser.addColumn("RunningWindows", "name")
databaser.addColumn("RunningWindows", "path")
databaser.addColumn("RunningWindows", "executable")
databaser.addColumn("RunningWindows", "hidden")

local DesktopColor = colors.lightGray

local DesktopImage = "BucketOS/OS/SystemApps/Desktop/Desktop2.nfp"

local UseDesktopImage = false

local TimeFormat = true

local createWindow

local ShowWindowF

local TimeType = "local"

if TimeType == "ingame" then
    local TimeTimeOut = 0.8
else
    local TimeTimeOut = 15
end

local function DoubleClick(btn, func, mouseButton)
    local doubleClickMaxTime = 0.25 -- in seconds
    local doubleClick = 0
    btn:onClick(function(self, event, button)
        if(os.epoch("local")-doubleClickMaxTime*1000<=doubleClick)then
            if button == mouseButton then
                func()
            end
            doubleClick = 0
        end
        doubleClick = os.epoch("local")
    end)
end


--  _      ___   _____  _   _ _____ 
-- | |    /_\ \ / / _ \| | | |_   _|
-- | |__ / _ \ V / (_) | |_| | | |  
-- |____/_/ \_\_| \___/ \___/  |_|  

local desktop = mainFrame:addFrame()
desktop:setBackground(false)

if UseDesktopImage then
    local desktopBG = mainFrame:addImage():loadImage(DesktopImage)
       :setSize(119,71)
       :setPosition(1,1)
    else
        desktop:setBackground(DesktopColor)                    
    end

local UpMenu = desktop:addFrame():show()
    :setSize(rw,1)
    :setPosition(1,1)
    :setBackground(colors.gray)
    :setForeground(colors.white)

local UpMenuBottom = desktop:addFrame():show()
    :setSize(rw,1)
    :setPosition(1,2)
    :setBackground(false, "\131", colors.gray)

-- Clock
local Clock = UpMenu:addLabel()
    :setBackground(false)
    :setText("")
    :setForeground(colors.white)
    :setSize(15,1)

    local function RunClock()
      while true do
        
        local time = os.time(TimeType)
        day = os.date("%a %d %b")
        local ClockWidth = rw - Clock:getSize() - 1
        Clock:setPosition(ClockWidth,1)
        Clock:setText(day.." "..textutils.formatTime(time, TimeFormat))
        sleep(5)
      end
    end

local UwUButton = UpMenu:addButton()
    :setBackground(false)
    :setForeground(colors.white)
    :setText("UwU")
    :setSize(3,1)
    :setPosition(2,1)

    local UwUMenu = desktop:addFrame()
        :setSize(9, 6)
        :setPosition(2,3)
        :setBackground(colors.gray)
        :setBorder(colors.black)

        local myUwU = UwUMenu:addLabel()
            :setPosition(1,1)
            :setBackground(colors.gray)
            :setForeground(colors.white)
            :setText("About UwU")

        local UwUMenuSeparator1 = UwUMenu:addLabel()
            :setPosition(1,2)
            :setBackground(colors.gray)
            :setForeground(colors.lightGray)
            :setText("---------")

        local SettingsButton = UwUMenu:addLabel()
            :setPosition(1,3)
            :setBackground(colors.gray)
            :setForeground(colors.white)
            :setText("Settings")

        local UwUStoreButton = UwUMenu:addLabel()
            :setPosition(1,4)
            :setBackground(colors.gray)
            :setForeground(colors.white)
            :setText("UwUStore")

        local UwUMenuSeparator2 = UwUMenu:addLabel()
            :setPosition(1,5)
            :setBackground(colors.gray)
            :setForeground(colors.lightGray)
            :setText("---------")

        local PowerButton = UwUMenu:addLabel()
            :setPosition(1,6)
            :setBackground(colors.gray)
            :setForeground(colors.white)
            :setText("Power")


    local openMyUwU = function()
        createWindow("BucketOS/OS/SystemApps/AboutThisUwU", false, "About.lua", "MyUwU", 39, 14, false, 6, 1, true, true, true)
    end
    myUwU:onClick(openMyUwU)

    local AreYouSure = function()
        createWindow("BucketOS/OS/SystemApps/AreYouSure", false, nil, "Confirm", 26, 7, true, nil, nil, true, true, true)
    end
    PowerButton:onClick(AreYouSure)

local function centerObject(Object, height, ow, oh, launchpad)
    ow, oh = Object:getSize()
    Object:setPosition(rw.."/2".." - "..ow.."/2", height)
end
-- ANIMATIONS

local function hideLaunchPad(pad, ah)
    local hideLAnimation = mainFrame:addAnimation()
        :setObject(pad)
        ah = rh - 2
        hideLAnimation:move(2, ah, 1)
    
    hideLAnimation:play()
end
local function showLaunchPad(pad, ah)
    local showLAnimation = mainFrame:addAnimation()
        :setObject(pad)
        ah = rh - 15
        showLAnimation:move(2, ah, 1)
    
    showLAnimation:play()
end

local function hideWindow(frame, program, ah, aw)
    desktop:removeFocusedObject()
    frame:setBar(" ", colors.gray, colors.gray)
    basalt.update()
    local hideWAnimation = mainFrame:addAnimation()
        :setObject(frame)
        :size(1,1,1)
        ah = rh + 5
        aw = rw + 5
        hideWAnimation:move(aw, ah, 1)
    
        program:pause()

    hideWAnimation:play()
    end

local function showWindow(frame, program, lastw, lasth, lastx, lasty, name)
    lastx = math.random(5,15)
    lasty = math.random(5,10)
    local id = databaser.search("RunningWindows", "name", name)
    local frameStatus = databaser.getColumn("RunningWindows", "hidden")
    local showWAnimation = mainFrame:addAnimation()
        :setObject(frame)
        :size(lastw,lasth,1)
        :move(lastx,lasty,1)
    if frameStatus[id] == "true" then
    showWAnimation:play()
    frame:setBar(name, colors.gray, colors.lightGray)
    frame:setBarTextAlign("center")
    end
    
    
    if id == nil then  
    else
    databaser.setValue("RunningWindows", "hidden", "false", id)
    end
    
    program:pause(false)
    end


local LaunchPad = desktop:addFrame()
    :setSize(13,15)
    :setBackground(colors.gray)
    :setMovable(true)
    :setPosition(2, rh.."-2")
    local LaunchPadIcon = LaunchPad:addLabel()
        :setText("\30")
        :setPosition(2,2)
        :setForeground(colors.orange)
        :setBackground(false)
    local LaunchPadLabel = LaunchPad:addLabel()
        :setText("LaunchPad")
        :setPosition(4,2)
        :setForeground(colors.white)
        :setBackground(false)

    local LaunchPadList = LaunchPad:addList()
        :setBackground(colors.black)
        :setForeground(colors.white)
        :setPosition(2,4)
        :setSize(11,11)
        :setScrollable(true)
        :selectItem(4)
        :setSelectedItem(colors.orange, colors.black)

        local AppList = fs.list("BucketOS/Apps")
        
        for _, app in pairs(AppList) do
            LaunchPadList:addItem(" "..app, colors.black, colors.lightGray)
        end

        local function LaunchProgram()
            local AppsFolder = fs.list("BucketOS/Apps/")
            local SelectedID = LaunchPadList:getItemIndex()
            createWindow("BucketOS/Apps/"..AppsFolder[SelectedID])
        end

        LaunchPadList:onChange(LaunchProgram)
        



    ---- EVENTS
        LaunchPadIcon:onClickUp(function(self, event, button)
            local LaunchPadX, LaunchPadY = LaunchPad:getPosition()
            if button == 1 and LaunchPadY == rh-2 then
                showLaunchPad(LaunchPad)
                LaunchPadIcon:setText("\31")
            elseif button == 1 and LaunchPadY == rh-15 then
                hideLaunchPad(LaunchPad)
                LaunchPadIcon:setText("\30")
            else end
        end)
        LaunchPadLabel:onClickUp(function()
            LaunchProgram()
        end)


        LaunchPadList:onKey(function(self, event, key)
            if key == keys.enter then
        
            end
        end)




local DockPanel = desktop:addFrame()
local Dock = DockPanel:addFrame():setSize(1,2)

local function loadDock(path)
    local DockApps = databaser.getColumn("RunningWindows", "path")
    if DockApps == nil then
        DockApps = {   
            "bruh"
        }
    end
    DockPanel:remove()
        DockPanel = desktop:addFrame():show()
    -----------------------
        local DownPanelSize = table.getn(DockApps)*4 + 1
        local DownPanelPos = DownPanelSize/2
        DownPanelPos = rw/2 - DownPanelSize
            DockPanel
                :setSize(DownPanelSize,3)
                :setPosition(DownPanelPos.."+4", rh.."-3")
                :setBackground(false)
    

    -----------------------

    
    -----------------------
    Dock = DockPanel:addFrame()
        Dock:setBackground(colors.gray)
        Dock:setForeground(colors.lightGray)
        Dock:setPosition(1,2)
        Dock:setSize(DownPanelSize, 3)
        --[[local DownLabelTop = Dock:addFrame():show()
            :setPosition(1,1)
            :setSize(DownPanelSize, 1)
            :setBackground(colors.glay, "\143", DesktopColor)]]--
        local n = 1
        local DockApps = databaser.getColumn("RunningWindows", "path")
        for _, object in pairs(DockApps) do
        local path = DockApps[n]
        
            ---------- Custom Generated ------------
            local Object = DockPanel:addFrame()
                :setSize(3,3)
                    local ObjectStatus = databaser.getColumn("RunningWindows", "hidden")
                    Object:setPosition("2+"..n.."*4-4", 1)--
                    if fs.exists(path.."/icon.nfp") then
                        Object:addImage():loadImage(path.."/icon.nfp"):setSize(4,2):shrink()
                    else
                        Object:addImage():loadImage("BucketOS/OS/Icons/app.nfp"):setSize(3,2):shrink()
                    end
                    if ObjectStatus[n] == "false" then
                    Object:addLabel():setForeground(colors.lightGray):setBackground(colors.gray):setText("\0".."\7"):setPosition(1,3):setSize(3,1)
                    else
                    Object:addLabel():setForeground(colors.lightGray):setBackground(colors.gray):setText("\0".."\186"):setPosition(1,3):setSize(3,1)
                    end
                    -- \187
                    n = n+1
                    centerObject(DockPanel, rh-3)

                    local runWindow = function()
                        if ObjectStatus[n] == false then
                            createWindow(path, false)
                        else
                        end
                    end

                    DoubleClick(Object, runWindow, 1)
        end
        return DockPanel, Dock
end


--[[local desktopIcon = desktop:addFrame()
    :setSize(5,5)
    :setPosition(3,3)
    :setBackground(colors.lightGray)
    
    local desktopIconImage = desktopIcon:addImage()
        :setPosition(2,1)
        :loadImage("BucketOS/OS/Icons/folder.nfp")
        :setSize(3,2)
        :shrink()]]--



  --  \    /||\ | / \    /||\ /__ 
   --  \/\/_|| \|_\_/\/\/_|| \\_| 

deleteWindow = function(name, frame, id) -- REWRITE THIS
        id = databaser.search("RunningWindows", "name", name)
        databaser.removeValue("RunningWindows", "name", id)
        databaser.removeValue("RunningWindows", "path", id)
        databaser.removeValue("RunningWindows", "executable", id)
        databaser.removeValue("RunningWindows", "hidden", id)
        sleep(0.05)
        loadDock()
        frame:remove()
end

-- CREATING WINDOWS
createWindow = function(path, fullscreen, executable, name, ww, wh, useBar, buttonPosX, buttonPosY, disableFullscreeen, disableHide, centered, pageBackground, framePosx, framePosy, frame, program, button1, button2, button3, buttonx, fh, id, parentframe, MoveButton)
    
    --Getting Settings from file
    if fs.exists(path.."/UwUsettings") then

        --[[]settings.load(path.."/UwUsettings")
        ww = settings.get("width", ww)
        wh = settings.get("height", wh)
        name = settings.get("name", fs.getName(path))
        executable = settings.get("executable", fs.getName(path)..".lua")
        useBorders = settings.get("borders", false)
        pageBackground = settings.get("background", colors.black)
        useBar = settings.get("bar", true)
        buttonPosX = settings.get("ButtonPosX", nil)
        buttonPosY = settings.get("ButtonPosY", nil)
        disableFullscreen = settings.get("disableFullscreen", false)
        disableHide = settings.get("disableHide", false)]]--

        local file = fs.open(path.."/UwUsettings", "r")
        local curSettings = file.readAll()
        curSettings = textutils.unserialize(curSettings)
        ww = curSettings[1]
        wh = curSettings[2]
        name = curSettings[3]
        executable = curSettings[4]
        useBar = curSettings[5]
        buttonPosX = curSettings[6]
        buttonPosY = curSettings[7]
        disableFullscreen = curSettings[8]
        disableHide = curSettings[9]
        centered = curSettings[10]
        file.close()
    end
        if fullscreen == nil then
            fullscreen = false
        end
        if ww == nil then
            ww = 51
        end
        if wh == nil then
            wh = 19
        end
        if executable == nil then
            executable = fs.getName(path)
        end
        if name == nil then
            name = executable
        end
        if useBorders == nil then
            useBorders = false
        end
        if pageBackground == nil then
            pageBackground = colors.black
        end
        if useBar == nil then
            useBar = true
        end
        if disableFullscreen == nil then
            disableFullscreen = false
        end
        if disableHide == nil then
            disableHide = false
        end
        if centered == nil then
            centered = false
        end

    --databaser.addValue("RunningWindows", "id", id)
    databaser.addValue("RunningWindows", "name", name)
    databaser.addValue("RunningWindows", "path", path)
    databaser.addValue("RunningWindows", "hidden", "false")
    databaser.addValue("RunningWindows", "executable", executable)
    loadDock()
    --Creating Frame
    if fullscreen then -- if fullscreen

        frame = desktop:addFrame(id)
            :setSize(rw,rh)
            :setPosition(1,1)
        fullscreen = true

        shell.setDir(":")

        program = frame:addProgram()
            :setSize(rw,rh)
            :setPosition(1,1)
            :execute(path.."/"..executable)
        shell.setDir("BucketOS/OS/SystemApps/Desktop")

    else -- if general frame
        if framePosx == nil or framePosy == nil then
            if centered == false then
            
                framePosx = math.random(5,10)
                framePosy = math.random(5,10)
            
            else

                framePosx = rw/2 - ww/2
                framePosy = rh/2 - wh/2
                framePosx = math.floor( framePosx )
                framePosy = math.floor( framePosy )
            end
        end

        frame = desktop:addFrame()
            :setPosition(framePosx,framePosy)
            :setMovable(true)
            :setBackground(colors.gray)
            if useBar == true then
                frame:setBar(name, colors.gray, colors.lightGray):showBar():setBarTextAlign("center")
                frame:setBorder(colors.gray, "left", "right", "bottom")
                frame:setSize(ww,wh.."+1")
            else
                frame:setBorder(colors.gray, "left", "right", "bottom")
                frame:setSize(ww,wh)
            end

            
        --databaser.addValue("RunningWindows", "frame", frame)
    end
        shell.setDir(":")
        program = frame:addProgram()
            :setSize(ww,wh)
            if useBar == false then
            program:setPosition(1,1)
            else
            program:setPosition(1,2)
            end
            program:execute(path.."/"..executable) -- running program
        shell.setDir("BucketOS/OS/SystemApps/Desktop")

        --Creating Buttons
        if useBar == false and buttonPosX == nil then
        
        else
            if buttonPosX == nil then
                buttonx = ww
            else
                buttonx = buttonPosX
            end
            if ButtonPosY == nil then
                buttony = 1
            else
                buttony = buttonPosY
            end
            button1 = frame:addButton() -- close button
                :setForeground(colors.lightGray)
                :setBackground(false) --colors.red
                :setPosition(buttonx, buttony)
                :setSize(1,1)
                :setText("\7")
            button1:onClick(function()
                deleteWindow(name, frame)

            end)
            buttonx = buttonx - 2
            button2 = frame:addButton() -- hide button
                :setForeground(colors.lightGray)
                :setBackground(false) --colors.orange
                :setPosition(buttonx,1)
                :setSize(1,1)
                :setText("\7")
            if disableHide ~= true then
                button2:onClick(function() 
                    local lastw, lasth = frame:getSize()
                    local lastx, lasty = frame:getPosition()
                    hideWindow(frame, program)
                    local id = databaser.search("RunningWindows", "name", name)
                    databaser.setValue("RunningWindows", "hidden", "true", id)
                    loadDock()
                end)
            end

            buttonx = buttonx - 2
            button3 = frame:addButton() -- fullscreen button
                :setForeground(colors.lightGray)
                :setBackground(false) --colors.lime
                :setPosition(buttonx,1)
                :setSize(1,1)
                :setText("\7")
            if disableFullscreen ~= true then
                button3:onClick(function() 
                    --basalt.debug("It do nothing ¯\92_(bruh)_/¯ but it will do in future")
                end)
            end
        end

        --Creating Program Window
       
        
        FramePosx, FramePosy = frame:getPosition()
        --Focus change
    if button1 ~= nil and button2 ~= nil and button3 ~= nil then
            frame:onGetFocus(function() 
                frame:setBar(name, colors.gray, colors.white)

                button1:setForeground(colors.red)

                if disableHide ~= true then
                    button2:setForeground(colors.orange)
                end
                if disableFullscreen ~= true then
                    button3:setForeground(colors.lightGray)
                end
                
            end)

            frame:onLoseFocus(function() 
                frame:setBar(name, colors.gray, colors.lightGray)
                button1:setForeground(colors.lightGray)
                button2:setForeground(colors.lightGray)
                button3:setForeground(colors.lightGray)

            end)
        end

        --[[MoveButton = frame:addLabel()
                :setSize(1,1)
                :setBackground(colors.gray)
                :setPosition(1,1)
                :setText("\186")
                :setForeground(colors.white)]]--

        
        mainFrame:onKeyUp(function(self, event, key)
            if(key==keys.k)and(basalt.isKeyDown(keys.leftCtrl))then
                showWindow(frame, program, ww, wh, FramePosx, FramePosy, name)
                loadDock()
            end
        end)
        return frame
end



-------------------
--createWindow("BucketOS/Apps/ASCII/", false, "ASCII", nil, nil, nil, false)
createWindow("BucketOS/Apps/Terminal/", nil, nil, "Terminal")
--createWindow("BucketOS/Apps/Finder", false, "Finder.lua", "Finder")
--createWindow("BucketOS/Apps/Worm/", false, "Worm")
--createWindow(":", false, "LevelOS.lua", "LevelOS", 119, 50)

loadDock()


parallel.waitForAll(Update)
