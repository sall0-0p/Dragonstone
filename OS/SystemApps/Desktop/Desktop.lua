

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

--         ___   _____  _   _ _____ 
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


-- Clock
local Clock = UpMenu:addLabel()
    :setBackground(false)
    :setText("")
    :setForeground(colors.white)

    local function RunClock()
      while true do
        local day = os.day()
        local time = os.time()
        local ClockWidth = rw - Clock:getSize() - 1
        Clock:setPosition(ClockWidth,1)
        Clock:setText("Day "..day.." | "..textutils.formatTime(time, TimeFormat))
        sleep(0.8)
      end
    end

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
    
        --program:pause()

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
    
    
    databaser.setValue("RunningWindows", "hidden", "false", id)
    
    --program:pause(false)
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
        :setSelectedItem(colors.orange, colors.black)

        local AppList = fs.list("BucketOS/Apps")
        
        for _, app in pairs(AppList) do
            LaunchPadList:addItem(" "..app, colors.black, colors.lightGray)
        end

        local function LaunchProgram()
            local AppsFolder = fs.list("BucketOS/Apps/")
            local SelectedID = LaunchPadList:getItemIndex()
            createWindow("BucketOS/Apps/"..AppsFolder[SelectedID], false)
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
        LaunchPadLabel:onClickUp(function(self, event, button)
            local LaunchPadX, LaunchPadY = LaunchPad:getPosition()
            if button == 1 and LaunchPadY == rh-2 then
                showLaunchPad(LaunchPad)
                LaunchPadIcon:setText("\31")
            elseif button == 1 and LaunchPadY == rh-15 then
                hideLaunchPad(LaunchPad)
                LaunchPadIcon:setText("\30")
            else end
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
                            showWindow(desktop, name)
                        end
                    end

                    DoubleClick(Object, runWindow, 1)
        end
        return DockPanel, Dock
end







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
createWindow = function(path, fullscreen, executable, name, ww, wh, useBorders, pageBackground, framePosx, framePosy, frame, program, button1, button2, button3, buttonx, fh, id, parentframe)
    
    --Getting Settings from file
    if fs.exists(path.."/UwUsettings") then

        settings.load(path.."/UwUsettings")
        fullscreen = settings.get(fullscreen, fullscreen)
        ww = settings.get(width, ww)
        wh = settings.get(heigt, wh)
        name = settings.get(name, fs.getName(path))
        executable = settings.get(executable, fs.getName(path)..".lua")
        useBorders = settings.get(borders, false)
        pageBackground = settings.get(background, colors.black)

    else -- settings defaults if there is no file
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
            framePosx = math.random(5,10)
            framePosy = math.random(5,10)
        end

        frame = desktop:addFrame():setBorder(colors.gray, "left", "right", "bottom")
            :setSize(ww,wh.."+1")
            :setPosition(framePosx,framePosy)
            :setMovable(true)
            :setBackground(colors.gray)
            :setBar(name, colors.gray, colors.lightGray):showBar():setBarTextAlign("center")
            if useBorders then
                frame:setBackground(pageBackground)
                frame:setBorder(colors.gray, "left", "right", "bottom")
            end
        --databaser.addValue("RunningWindows", "frame", frame)
    end

        --Creating Buttons
        buttonx = ww
        button1 = frame:addButton() -- close button
            :setForeground(colors.lightGray)
            :setBackground(false) --colors.red
            :setPosition(buttonx,1)
            :setSize(1,1)
            :setText("\7")
        :onClick(function()
            deleteWindow(name, frame)

        end)
        buttonx = ww - 2
        button2 = frame:addButton() -- hide button
            :setForeground(colors.lightGray)
            :setBackground(false) --colors.orange
            :setPosition(buttonx,1)
            :setSize(1,1)
            :setText("\7")
        :onClick(function() 
            local lastw, lasth = frame:getSize()
            local lastx, lasty = frame:getPosition()
            hideWindow(frame, program)
            local id = databaser.search("RunningWindows", "name", name)
            databaser.setValue("RunningWindows", "hidden", "true", id)
            loadDock()
            
        end)

        buttonx = ww - 4
        button3 = frame:addButton() -- fullscreen button
            :setForeground(colors.lightGray)
            :setBackground(false) --colors.lime
            :setPosition(buttonx,1)
            :setSize(1,1)
            :setText("\7")
        :onClick(function() end)

        --Creating Program Window
       
        shell.setDir(":")
        program = frame:addProgram()
            :setSize(ww,wh)
            :setPosition(1,2)
            :execute(path.."/"..executable) -- running program
        shell.setDir("BucketOS/OS/SystemApps/Desktop")
        FramePosx, FramePosy = frame:getPosition()
        --Focus change

        frame:onGetFocus(function() 
            frame:setBar(name, colors.gray, colors.white)
            button1:setForeground(colors.red)
            button2:setForeground(colors.orange)
            button3:setForeground(colors.lime)
        end)
        frame:onLoseFocus(function() 
            frame:setBar(name, colors.gray, colors.lightGray)
            button1:setForeground(colors.lightGray)
            button2:setForeground(colors.lightGray)
            button3:setForeground(colors.lightGray)
        end)

        mainFrame:onKeyUp(function(self, event, key)
            if key == keys.k then
                
                
                showWindow(frame, program, ww, wh, FramePosx, FramePosy, name)
                loadDock()
            end
        end)
        return frame

        

end



-------------------
--createWindow("BucketOS/Apps/ASCII/", false, "ASCII", nil, nil, nil, false)
createWindow("BucketOS/Apps/Terminal/", false, nil, "Terminal (Shell)")
--createWindow("BucketOS/Apps/Finder", false, "Finder.lua", "Finder")
--createWindow("BucketOS/Apps/Worm/", false, "Worm")
--createWindow(":", false, "LevelOS.lua", "LevelOS", 119, 50)

loadDock()



desktop:onKeyUp(function(self, event, key)
    if key == keys.c then
        loadDock()
    end
    end)

parallel.waitForAll(Update, RunClock)
