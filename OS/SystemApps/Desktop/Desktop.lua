--TODO: make Silent Apps (do not appear in dock)
--TODO: Button for moving unmovable windows

--119 x 50

--  _  _ ___   _   ___  
-- | || | __| /_\ |   \ 
-- | __ | _| / _ \| |) |
-- |_||_|___/_/ \_\___/ 

-- API --
local databaser = require(".UwUntuCC.OS.Libraries.Databaser.main")
local basalt = require(".UwUntuCC.OS.Libraries.Basalt")
local versions = require(".UwUntuCC.OS.Libraries.UwUVersions")
basalt.setMouseMoveThrottle(100)
package.path = "/UwUntuCC/OS/Libraries/?.lua;/UwUntuCC/OS/Libraries/?/init.lua;" .. package.path
local Host = _HOST

local mainFrame = basalt.createFrame("mainFrame"):show()   
mainFrame:setBackground(colors.lightGray)
local rw, rh = mainFrame:getSize()

local function Update()
    basalt.autoUpdate()
end

databaser.setDir("UwUntuCC/OS/Data")
databaser.deleteColumn("RunningWindows", "name")
databaser.deleteColumn("RunningWindows", "path")
databaser.deleteColumn("RunningWindows", "executable")
databaser.deleteColumn("RunningWindows", "hidden")
databaser.deleteColumn("RunningWindows", "id")

databaser.addColumn("RunningWindows", "name")
databaser.addColumn("RunningWindows", "path")
databaser.addColumn("RunningWindows", "executable")
databaser.addColumn("RunningWindows", "hidden")
databaser.addColumn("RunningWindows", "id")

local DesktopColor = colors.lightGray

local DesktopImage = "UwUntuCC/OS/DesktopBackgrounds/Desktop4.bimg"

local UseDesktopImage = true

local TimeFormat = true

local createWindow

local ShowWindowF

local LoadDock

local TimeType = "local"

local useScreensaver = true

local Screensaver = "UwUntuCC/OS/SystemApps/ScreenSavers/fireworks.lua"

local ScreenSaverTimeOut = 600

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
       :setSize(rw,rh)
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
        local rw, rh = mainFrame:getSize()
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
    :setSize(5,1)
    :setPosition(1,1)

    local UwUMenu = desktop:addFrame():hide()
        :setSize(11, 8)
        :setPosition(1,2)
        :setBackground(colors.black)
        --:setBorder(colors.black)

        local myUwU = UwUMenu:addLabel()
            :setPosition(2,2)
            :setBackground(colors.black)
            :setForeground(colors.white)
            :setText("About UwU")

        local UwUMenuSeparator1 = UwUMenu:addLabel()
            :setPosition(2,3)
            :setBackground(colors.black)
            :setForeground(colors.lightGray)
            :setText("---------")

        local SettingsButton = UwUMenu:addLabel()
            :setPosition(2,4)
            :setBackground(colors.black)
            :setForeground(colors.white)
            :setText("Settings")

        local UwUStoreButton = UwUMenu:addLabel()
            :setPosition(2,5)
            :setBackground(colors.black)
            :setForeground(colors.white)
            :setText("UwUStore")

        local UwUMenuSeparator2 = UwUMenu:addLabel()
            :setPosition(2,6)
            :setBackground(colors.black)
            :setForeground(colors.lightGray)
            :setText("---------")

        local PowerButton = UwUMenu:addLabel()
            :setPosition(2,7)            
            :setBackground(colors.black)
            :setForeground(colors.white)
            :setText("Power")

        if Host == "ComputerCraft 1.100.9 (CraftOS-PC v2.7)" then
            UwUMenu:setSize(11, 9)
            
            local ChangePCButton = UwUMenu:addLabel()
            :setPosition(2,8)
            :setBackground(colors.black)
            :setForeground(colors.white)
            :setText("Change PC")

            :onClick(function() 
                createWindow("UwUntuCC/OS/SystemApps/ChangePC", nil, nil, "Attach PC", 26, 6, true, nil, nil, true, true, true, true)
            end)
        end
        


    local openMyUwU = function()
        createWindow("UwUntuCC/OS/SystemApps/AboutThisUwU", "About.lua") --"MyUwU", 39, 14, false, 6, 1, true, true, true
    end 
    myUwU:onClick(openMyUwU)

    local AreYouSure = function()
        createWindow("UwUntuCC/OS/SystemApps/AreYouSure", nil, nil, "Confirm", 26, 7, true, true, nil, nil, true, true, true, true)
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
        --:size(1,1,1)
        ah = rh + 5
        aw = rw + 5
        hideWAnimation:move(aw, ah, 1)
    

    hideWAnimation:play()
    end

local function showWindow(frame, program, lastw, lasth, lastx, lasty, name)
    lastx = math.random(5,15)
    lasty = math.random(5,10)
    lastw = lastw+1
    lasth = lasth+1
    local id = databaser.search("RunningWindows", "name", name)
    local frameStatus = databaser.getColumn("RunningWindows", "hidden")
    local showWAnimation = mainFrame:addAnimation()
        :setObject(frame)
        --:size(lastw,lasth,1)
        :move(lastx,lasty,1)
    if frameStatus[id] == "true" then
    showWAnimation:play()
    frame:setBar(name, colors.gray, colors.lightGray)
    frame:setBarTextAlign("center")
    --program:pause(false)
    end
    
    if id ~= nil then
    databaser.setValue("RunningWindows", "hidden", "false", id)
    loadDock()
    end
    
    
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

        local AppList = fs.list("UwUntuCC/Apps")
        
        for _, app in pairs(AppList) do
            LaunchPadList:addItem(" "..app, colors.black, colors.lightGray)
        end

        local function LaunchProgram()
            local AppsFolder = fs.list("UwUntuCC/Apps/")
            local SelectedID = LaunchPadList:getItemIndex()
            createWindow("UwUntuCC/Apps/"..AppsFolder[SelectedID])
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

loadDock = function(path)
    local rw, rh = mainFrame:getSize()
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
        local n = 1
        local DockApps = databaser.getColumn("RunningWindows", "path")
        for _, object in pairs(DockApps) do
        local path = DockApps[n]
        
            ---------- Custom Generated ------------
            local Object = DockPanel:addFrame(n)
                :setSize(3,3)
                :setZIndex(10)
                    local ObjectStatus = databaser.getColumn("RunningWindows", "hidden")
                    Object:setPosition("2+"..n.."*4-4", 1)--
                    if fs.exists(path.."/icon.nfp") then
                        Object:addImage():loadImage(path.."/icon.nfp"):setSize(4,2)
                    else
                        Object:addImage():loadImage("UwUntuCC/OS/Icons/app.nfp"):setSize(3,2)
                    end
                    if ObjectStatus[n] == "false" then
                    Object:addLabel():setForeground(colors.lightGray):setBackground(colors.gray):setText("\0".."\7"):setPosition(1,3):setSize(3,1)
                    else
                    Object:addLabel():setForeground(colors.lightGray):setBackground(colors.gray):setText("\0".."\186"):setPosition(1,3):setSize(3,1)
                    end
                    -- \187
                    n = n+1
                    centerObject(DockPanel, rh-3)

                    Object:onClick(function() 
                    
                    local ObjectID = Object:getName()
                    local ObjectStatus = databaser.getColumn("RunningWindows", "hidden")
                    local frame = desktop:getObject(ObjectID)
                    local program = frame:getObject(ObjectID.."p")
                    local name = frame:getValue()
                        if ObjectStatus[ObjectID] == "true" then
                                showWindow(frame, program, 51, 19, 5, 5, name)
                        elseif ObjectStatus[ObjectID] == "false" then
                                frame:setFocus()
                        end
                    end)

                    Object:onHover(function()
                        local ObjectID = Object:getName()
                        local frame = desktop:getObject(ObjectID)
                        local name = frame:getValue()
                        local ox, oy = Object:getAbsolutePosition()
                        local NameLabel = desktop:addLabel()
                            :setText(name)
                            :setPosition(math.floor(ox - string.len(name)/2 + 1), oy.."-2")
                            :setBackground(colors.gray)
                            :setForeground(colors.white)

                        desktop:onHover(function()
                            NameLabel:remove()
                        end)
                    end)

                    
                    
        end
        return DockPanel, Dock
end

local LoadPanel = function(path)



end



  --  \    /||\ | / \    /||\ /__ 
   --  \/\/_|| \|_\_/\/\/_|| \\_| 

local deleteWindow = function(frame, id, name) -- REWRITE THIS
        name = frame:getValue()
        id = databaser.search("RunningWindows", "name", name)
        databaser.removeValue("RunningWindows", "name", id)
        databaser.removeValue("RunningWindows", "path", id)
        databaser.removeValue("RunningWindows", "executable", id)
        databaser.removeValue("RunningWindows", "hidden", id)
        databaser.removeValue("RunningWindows", "id", id)
        sleep(0.05)
        loadDock()
        frame:remove()
end

local BugReportWindow = function(name, errorcode)
    createWindow("UwUntuCC/OS/SystemApps/BugReport/", "BugReport.lua")
end



-- CREATING WINDOWS
createWindow = function(path, executable, args, name, ww, wh, useBar, buttonPosX, buttonPosY, disableFullscreeen, disableHide, isResizeable, centered, pageBackground, framePosx, framePosy, frame, program, button1, button2, button3, buttonx, fw,fh, id, parentframe, MoveButton, sw, sh, DoneTimer)    
    --Getting Settings from file
    
    if fs.exists(path.."/UwUsettings") then
        local file = fs.open(path.."/UwUsettings", "r")
        local curSettings = file.readAll()
        curSettings = textutils.unserialize(curSettings)
        file.close()
        ww = curSettings[1]
        wh = curSettings[2]
        executable = curSettings[4]
        name = curSettings[3]
        useBar = curSettings[6]
        buttonPosX = curSettings[7]
        buttonPosY = curSettings[8]
        disableFullscreen = curSettings[9]
        disableHide = curSettings[10]
        isResizeable = curSettings[5]
        centered = curSettings[11]
    else
        ww = ww or 51
        wh = wh or 19
        executable = executable or fs.getName(path)
        name = name or executable
        useBar = useBar or true
        buttonPosX = ButtonPosX or nil
        buttonPosY = buttonPosY or nil
        disableFullscreen = disableFullscreen or true
        disableHide = disableHide or false
        isResizeable = isResizeable or false
        centered = centered or false
    end
        sw = ww + 2
        sh = wh + 2
        local ids = databaser.getColumn("RunningWindows", "id")
        if ids ~= nil then
            id = table.getn(ids) + 1
        else
            id = 1
        end
        databaser.addValue("RunningWindows", "id", id)
        databaser.addValue("RunningWindows", "name", name)
        databaser.addValue("RunningWindows", "path", path)
        databaser.addValue("RunningWindows", "hidden", "false")
        databaser.addValue("RunningWindows", "executable", executable)
        loadDock()
    --Creating Frame

    if args == nil then
        args = {}
    end


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

    frame = desktop:addFrame(id):setValue(name) -- ! PROBLEM WITH DATABASES =)
        :setPosition(framePosx,framePosy)
        :setMovable(true)
        :setBackground(colors.gray)
        frame:setSize(ww.."+2",wh.."+2")
        if useBar == true then
            frame:setBar(name, colors.gray, colors.lightGray):showBar():setBarTextAlign("center")
            frame:setSize(ww.."+2",wh.."+2")
        else
            frame:setSize(ww.."+2",wh.."+1")
        end

    shell.setDir(":")
    program = frame:addProgram(id.."p")
        :setSize(ww,wh)
        if useBar == false then
            program:setPosition(2,1)
        else
            program:setPosition(2,2)
        end

        program:onError(function(self, errormsg)
            if errormsg == nil then
                errormsg = { "value" }
            end
            
            local logDate = os.date()
            local logLabel = os.getComputerLabel()
            local logHOST = _HOST
            local log = fs.open("UwUntuCC/log.txt", "w")
            local BugReportArgumets = {}
            table.insert(BugReportArgumets, name)
            table.insert(BugReportArgumets, logDate)
            table.insert(BugReportArgumets, logLabel)
            table.insert(BugReportArgumets, logHOST)
            table.insert(BugReportArgumets, errormsg)

            local log = fs.open("UwUntuCC/log.txt", "w")
            log.write(textutils.serialize(BugReportArgumets))
            log.close()

            program:execute("UwUntuCC/OS/SystemApps/BugReport/BugReport.lua", name, logErrorMSG)
            return false
        end)

        program:execute(path.."/"..executable, name) -- running program


        --Creating Buttons
        if useBar == false and buttonPosX == nil then
        
        else
            if buttonPosX == nil then
                buttonx = ww+1
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
                :setBackground(colors.gray) --colors.red
                :setPosition(buttonx,1)
                :setSize(1,1)
                :setText("\7")
            button1:onClick(function()
                deleteWindow(frame)

            end)
            buttonx = buttonx - 2
            button2 = frame:addButton() -- hide button
                :setForeground(colors.lightGray)
                :setBackground(false) --colors.orange
                :setPosition(buttonx,1)
                :setSize(1,1)
                :setText("\7")
            
                if disableHide then
                    button2:disable()
                end

                button2:onClick(function() 
                    local lastw, lasth = frame:getSize()
                    local lastx, lasty = frame:getPosition()
                    hideWindow(frame, program)
                    id = databaser.search("RunningWindows", "name", name)
                    databaser.setValue("RunningWindows", "hidden", "true", id)
                    loadDock()
                end)

            buttonx = buttonx - 2
            button3 = frame:addButton() -- fullscreen button
                :setForeground(colors.lightGray)
                :setBackground(false) --colors.lime
                :setPosition(buttonx,1)
                :setSize(1,1)
                :setText("\7")
            if disableFullScreen then
                button3:disable()
            end
            button3:onClick(function() 
                --basalt.debug("It do nothing ¯\92_(bruh)_/¯ but it will do in future"
            end)
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
        
        if isResizeable == true then
            MoveButton = frame:addLabel()
                    :setSize(1,1)
                    :setBackground(colors.gray)
                    :setPosition(ww.."+2",wh.."+2")
                    :setText("/")
                    :setForeground(colors.lightGray)
        end
        
        mainFrame:onKeyUp(function(self, event, key)
            if(key==keys.k)and(basalt.isKeyDown(keys.leftCtrl))then
                showWindow(frame, program, ww, wh, FramePosx, FramePosy, name)
                loadDock()
            end
        end)
        if isResizeable == true then
            MoveButton:onDrag(function(self, event, button, x, y, xOffset, yOffset)
                frame:setSize(-xOffset, -yOffset, true)
                local ww, wh = frame:getSize()
                if ww < sw then
                    frame:setSize(sw, nil)
                end
    
                if wh < sh then
                    frame:setSize(nil, sh)
                end
            end)
        end
        frame:onResize(function()
            local ww, wh = frame:getSize()
            program:setSize(ww.."-2", wh.."-2")
            if isResizeable == true then
                MoveButton:setPosition(ww,wh)
            end
            if buttonPosX == nil then
                buttonx = ww-1
                button1:setPosition(buttonx, 1)
                buttonx = buttonx - 2
                button2:setPosition(buttonx, 1)
                buttonx = buttonx - 2
                button3:setPosition(buttonx, 1)
            end
        end)
        program:onDone(function() 
            deleteWindow(frame)  
        end)

        

end

        --[[desktop:onClick(function()
            UwUMenu:hide()
        end)]]

        UwUButton:onClick(function()
            UwUMenu:show()
        end)

        UwUButton:onHover(function()
            UwUMenu:show()
            UwUButton:setBackground(colors.black)
            UwUMenu:setFocus()
        end)

        UwUMenu:onLeave(function()
            UwUMenu:hide()
            UwUButton:setBackground(colors.gray)
        end)

--TODO: term.resize() event?       
mainFrame:onResize(function()
    local rw, rh = mainFrame:getSize()
    desktop:setSize(rw,rh)
    UpMenu:setSize(rw,1)
    LaunchPad:setPosition(nil, rh.."-2")
    UpMenuBottom:setSize(rw,1)
    local ClockWidth = rw - Clock:getSize() - 1
        Clock:setPosition(ClockWidth,1)
    loadDock()

end)

local scTimer

local launchScreensaver = function()
    shell.setDir(":")
    local ScreensaverProgram = mainFrame:addProgram()
        :setSize(rw,rh)
        :setFocus()
        :execute(Screensaver)
    desktop:hide()
    
    mainFrame:onClick(function()
        ScreensaverProgram:remove()
        desktop:show()
        scTimer:start()
    end)
    mainFrame:onKey(function()
        ScreensaverProgram:remove()
        desktop:show()
        scTimer:start()
    end)
end


if useScreensaver then
    scTimer = desktop:addTimer()
        :onCall(launchScreensaver)
        :setTime(ScreenSaverTimeOut)
        desktop:onClickUp(function()
            scTimer:cancel()
            scTimer:start()

        end)
        scTimer:start()
end

local NExampleText = 
[[
    This is example text.
    If you see this, smth went wrong.
]]

local Notification = mainFrame:addFrame()
    :setSize(31,6)
    :setPosition(rw.."+2", 3)
    :setBackground(colors.gray)
    Notification:addFrame()
        :setBackground(colors.gray, "\149", colors.lightGray)
        :setPosition(2,3)
        :setSize(1,3)
    Notification:addFrame()
        :setBackground(colors.gray, "\132", colors.white)
        :setPosition(2,2)
        :setSize(1,1)

    local NotificationLabel = Notification:addLabel()
        :setPosition(3,2)
        :setText("Notification")
        :setForeground(colors.white)
    
    local NotificationText = Notification:addLabel()
        :setSize(27,3)
        :setPosition(3,3)
        :setText(NExampleText)
        :setForeground(colors.lightGray)

local aw = rw + 2
local aww = rw - 29

local NHide = Notification:addAnimation()
    :setObject(Notification)
    :move(aw, 3, 1)     

local NShow = Notification:addAnimation()
    :setObject(Notification)
    :move(aww, 3, 1)    

local NHideTimer = mainFrame:addTimer()
    :onCall(function()
        NHide:play()
    end)
    :setTime(10)

mainFrame:onEvent(function(self, event, arg1, arg2, arg3, arg4, arg5) 
    if event == "notification" then
        NShow:play()
        NHideTimer:start()
        if arg1 == nil or arg2 == nil then
            NotificationLabel:setText("Notification")
            NotificationText:setText(NExampleText)
        end
            NotificationLabel:setText(arg1)
            NotificationText:setText(arg2)
        else
        Notification:onClick(function() 
            NHideTimer:cancel()
            NHide:play()
        end)
    end

    if event == "launch_screensaver" then
        launchScreensaver()
    end

    if event == "clean_notifications" then
        NHide:play()
    end

    if event == "program_crashed" then
        
    end

end)

-------------------
createWindow("UwUntuCC/Apps/Terminal/", "Terminal.lua", nil, "Terminal")

versions.checkVersion()
loadDock()

parallel.waitForAll(Update, RunClock)
