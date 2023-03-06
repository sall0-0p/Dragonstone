local basalt = require(".Dragonstone.OS.Libraries.Basalt")
local db = require(".Dragonstone.OS.Libraries.Databaser")

local path = "/Dragonstone/Apps/UwUstudio"

local mainFrame = basalt.createFrame()
    :setBackground(colors.black)

basalt.debugLabel
    :setBackground(colors.cyan)
    :setForeground(colors.white)

local projectTitle = "My project"

local sidebar = mainFrame:addFrame()
    :setSize("20", "parent.h")
    :setPosition(1, 1)
    :setBackground(colors.gray)
    :setBorder(colors.lightGray, "right")
    :setZIndex(3)

    local sidebarCategories = sidebar:addFrame()
        :setSize(4, "parent.h")
        :setPosition(1,1)
        :setBackground(colors.gray)
        
        local sidebarCategoriesBorder = sidebarCategories:addPane() -- custom border
            :setSize(1, "parent.h")
            :setPosition(4,1)
            :setBackground(false, "\149", colors.lightGray)

        local explorerCtgButton = sidebarCategories:addImage()
            :setSize(3,3)
            :setPosition(1,1)
            :loadImage(path.."/assets/images/icons/explorerIcon.bimg")

        local searchCtgButton = sidebarCategories:addImage()
            :setSize(3,3)
            :setPosition(1,4)
            :loadImage(path.."/assets/images/icons/searchIcon.bimg")



    local sidebarTitle = sidebar:addLabel()
        :setPosition(5, 1)
        :setForeground(colors.white)
        :setBackground(false)
        :setText("EXPLORER")

    local sidebarContextButton = sidebar:addButton()
        :setSize(1,1)
        :setPosition(19, 1)
        :setForeground(colors.white)
        :setBackground(false)
        :setText("=")

    local ProjectTitleLabel = sidebar:addLabel()
        :setPosition(6, 2)
        :setForeground(colors.lightGray)
        :setBackground(false)
        :setText(projectTitle)

local header = mainFrame:addFrame()
    :setSize("parent.w-20", 1)
    :setPosition(21, 1)
    :setBackground(colors.gray)
    :setZIndex(2)

    local headerPane = mainFrame:addPane()
        :setSize("parent.w-20", 1)
        :setPosition(21, 2)
        :setBackground(false, "\131", colors.gray)

local footer = mainFrame:addFrame()
    :setSize("parent.w", 1)
    :setPosition(1, "parent.h")
    :setBackground(colors.cyan)
    :setZIndex(4)

    local cursorPosLB = footer:addLabel()
        :setPosition("parent.w-12", "parent.h")
        :setForeground(colors.white)

        :setText("Ln 0, Col 0")

    basalt.debugLabel
    :setBackground(colors.cyan)
    :setForeground(colors.white)

    basalt.debug("")

local test_code = [[
    local basalt = require(".Dragonstone.OS.Libraries.Basalt")
    local db = require(".Dragonstone.OS.Libraries.Databaser")
    
    
    local accentColor = settings.get("uwuntucc.accent_color")
    local mainColor = settings.get("uwuntucc.main_color")
    local secondColor = settings.get("uwuntucc.second_color")
    local text_color1 = settings.get("uwuntucc.text_color1")
    local text_color2 = settings.get("uwuntucc.text_color2")
    
    local mainFrame = require(".Dragonstone.OS.Desktop.values.mainFrame")
    
    
    local function createToken()
        return math.random(1000000, 9999999)
    end
    
    local function centerText(obj)
        obj:setPosition("parent.w / 2 -"..obj:getSize().."/2", 1)
    end
    
    local windows = {}
    
    win =  {
    
        create = function()
            local winX, winY = math.random(3, 40), math.random(5, 25)
            local winW, winH = 51, 19
            local token = createToken()
            local tokens = db.getColumn("RunningApps", "token")
            local index
            local fullscre = "false"
    
            if tokens == nil then
                index = 1
            else
                index = #tokens+1
            end
            if index == nil then
                index = 1
            end
    
            db.setDir("/Dragonstone/OS/Data/")
            db.setValue("RunningApps", "token", token, index)
            db.setValue("RunningApps", "hidden", "false", index)
            local frame = mainFrame:addFrame()
                :setSize(winW + 2, winH + 2)
                :setMovable()
                :setPosition(winX, winY)
                :setZIndex(10)
                :setBackground(mainColor)
                local hideAnimation = mainFrame:addAnimation()
                local showAnimation = mainFrame:addAnimation()
            -- local bar = frame:addFrame()
            --     :setSize(53,1)
            local label = frame:addLabel()
                :setPosition(22, 1)
                :setText("Window")
                :setForeground(text_color2)
                centerText(label)
            local program = frame:addProgram()
                :setSize(51,19)
                :setPosition(2,2)
            local buttons = frame:addFrame()
                :setSize(5,1)
                :setPosition(2,1)
                :setBackground(false)
    
                local closeButton = buttons:addButton()
                    :setSize(1,1)
                    :setPosition(1,1)
                    :setBackground(false)
                    :setForeground(secondColor)
                    :setText("\7")
                
                local hideButton = buttons:addButton()
                    :setSize(1,1)
                    :setPosition(3,1)
                    :setBackground(false)
                    :setForeground(secondColor)
                    :setText("\7")
    
                local fullscreenButton = buttons:addButton()
                    :setSize(1,1)
                    :setPosition(5,1)
                    :setBackground(false)
                    :setForeground(secondColor)
                    :setText("\7")
            
                local resizableButton = frame:addButton():hide()
    
            local minW = minW or 4
            local minH = minH or 4
            local maxW = maxW or 99
            local maxH = maxH or 99
            --os.queueEvent("updateDock")
            local instance = {
                setSize = function(self, width, height)
                    winW, winH = width, height
                    frame:setSize(winW + 2, winH + 2)
                    program:setSize(winW, winH)
                    return self
                end,
                
                setBar = function(self, text)
                    label:setText(text)
                    db.setValue("RunningApps", "name", text, index)
                    return self
                end,
    
                setResizable = function(self)
                    if(resizableButton==nil)then
                        resizableButton = frame:addButton():hide()
                            :setSize(1,1)
                            :setPosition("parent.w", "parent.h")
                            :setText("/")
                        :onDrag(function(self, event, btn, xOffset, yOffset)
                            local w, h = frame:getSize()
                            local wOff, hOff = w, h
                            if(w+xOffset-1>=minW)and(w+xOffset-1<=maxW)then
                                wOff = w+xOffset-1
                            end
                            if(h+yOffset-1>=minH)and(h+yOffset-1<=maxH)then
                                hOff = h+yOffset-1
                            end
                            frame:setSize(wOff, hOff)
                        end)
                    end
                    return self
                end,
    
                run = function(self, path, args)
    
                    if fs.exists(fs.getDir(path).."/DG_config.lua") then
                        local file = fs.open(fs.getDir(path).."/DG_config.lua", "r")
                        local table = textutils.unserialise(file.readAll())
    
                        file.close()
    
                            db.setValue("RunningApps", "name", table["name"], index)
                            label:setText(table["name"])
                            frame:setSize(table["width"].."+2", table["height"].."+2")
                            program:setSize(table["width"], table["height"])
                            winW, winH = table["width"], table["height"]
                        
                    end
    
                    if not args then
                        program:execute(path)
                        basalt.schedule(function()
                            sleep(0.1)
                            program:injectEvent("uwuntu.program_path", path)
                            program:injectEvent("uwuntu.token", token)
                        
                        
                        end)
                    else
                        program:execute(path, args)
                        basalt.schedule(function()
                            sleep(0.1)
                            program:injectEvent("uwuntu.program_path", path)
                            program:injectEvent("uwuntu.token", token)
                        
                        
                        end)
                    end
                    db.setValue("RunningApps", "path", path, index)
                    db.setValue("RunningApps", "icon", fs.getDir(path).."/icon.bimg", index)
    
                    os.queueEvent("updateDock")
    
                    return true
                end, 
    
                close = function(self)
                    basalt.debug("delete")
                    os.queueEvent("uwuntu.fullscreen_off")
                    
                    local index = db.search("RunningApps", "token", token)
                        db.removeValue("RunningApps", "hidden", index)
                        db.removeValue("RunningApps", "icon", index)
                        db.removeValue("RunningApps", "name", index)
                        db.removeValue("RunningApps", "path", index)
                        db.removeValue("RunningApps", "token", index)
    
                    os.queueEvent("updateDock")
                    
                    frame:remove()
                    return self
                end,
    
                hideWindow = function(self)
                    local rw, rh = mainFrame:getSize()
                    label:hide()
                    buttons:hide()
                    resizableButton:hide()
                    winX, winY = frame:getPosition()
                    hideAnimation
                        :clear()
                        :setObject(frame)
                        :move(rw+1, rh+1, 0.6)
                        :size(3, 3, 0.6)
                        :play()
    
                    local index = db.search("RunningApps", "token", token)
                    db.setValue("RunningApps", "hidden", "true", index)
                    os.queueEvent("uwuntu.fullscreen_off")
                    os.queueEvent("updateDock")
                    return self
                end,
    
                showWindow = function(self)
                    label:show()
                    buttons:show()
                    resizableButton:hide()
                    fullscre = "false"
                    frame:setMovable(true)
                    showAnimation
                        :clear()
                        :setObject(frame)
                        :move(winX, winY, 0.6)
                        :size(winW+2, winH+2, 0.6)
                        :setObject(program)
                        :size(winW, winH, 0.6)
                        :setObject(buttons)
                        :move(2, 1, 0.6)
                        :play()
    
                    local index = db.search("RunningApps", "token", token)
                    db.setValue("RunningApps", "hidden", "false", index)
                    os.queueEvent("updateDock")
                    os.queueEvent("uwuntu.fullscreen_off")
                    return self
                end,
    
                fullscreen = function(self)
                    local rw, rh = mainFrame:getSize()
                    resizableButton:hide()
                    frame:setMovable(false)
                    fullscre = "true"
                    showAnimation
                        :clear()
                        :setObject(frame)
                        :move(0, 1, 0.6)
                        :size(rw+1, rh, 0.6)
                        :setObject(program)
                        :size(rw, rh-1, 0.6)
                        :setObject(buttons)
                        :move(3, 1, 0.6)
                        :play()
    
                    os.queueEvent("uwuntu.fullscreen_on")
                    return self
                end,
    
                focus = function(self)
                    frame:setFocus()
                end,
            }
    
            table.insert(instance, frame)
            table.insert(instance, label)
            table.insert(instance, program)
            table.insert(instance, program)
            table.insert(instance, fullscre)
            windows[token] = instance
    
            frame:onGetFocus(function() 
                program:injectEvent("gained_focus")
                label:setForeground(text_color1)
                closeButton:setForeground(colors.red)
                hideButton:setForeground(colors.orange)
                fullscreenButton:setForeground(colors.lime)
            end)
    
            frame:onLoseFocus(function()
                program:injectEvent("loosed_focus")
                label:setForeground(text_color2)
                closeButton:setForeground(secondColor)
                hideButton:setForeground(secondColor)
                fullscreenButton:setForeground(secondColor)
            
            end)
    
            closeButton:onClick(function() 
                os.queueEvent("updateDock")
                os.queueEvent("uwuntu.fullscreen_off")
                local index = db.search("RunningApps", "token", token)
                    db.removeValue("RunningApps", "hidden", index)
                    db.removeValue("RunningApps", "icon", index)
                    db.removeValue("RunningApps", "name", index)
                    db.removeValue("RunningApps", "path", index)
                    db.removeValue("RunningApps", "token", index)
                frame:remove()
                --basalt.debug("HELLO THERE")
            end)
    
            hideButton:onClick(function() 
                instance.hideWindow()
            end)
    
            fullscreenButton:onClick(function()
                if fullscre == "false" then
                    instance.fullscreen()
                    instance.fullscre = "true"
                else
                    instance.showWindow()
                    os.queueEvent("uwuntu.fullscreen_off")
                    instance.fullscre = "false"
                end
            end)
    
            program:onDone(function()
                os.queueEvent("updateDock")
                local index = db.search("RunningApps", "token", token)
                    db.removeValue("RunningApps", "hidden", index)
                    db.removeValue("RunningApps", "icon", index)
                    db.removeValue("RunningApps", "name", index)
                    db.removeValue("RunningApps", "path", index)
                    db.removeValue("RunningApps", "token", index)
                frame:remove()
            end)
            
            
            return instance
    
        end,
    
        setup = function()
        
        end,
    
        getWindow = function(token)
            return windows[token]
        end,
    
    }
    
    return win

]]

local calculateLineAmout = function()

end

local codespace = mainFrame:addFrame()
    :setSize("parent.w-21", "parent.h-4")
    :setPosition(21, 3)
    :setBackground(colors.black)
    :setScrollable()

    local codespaceTF = codespace:addTextfield()
        :setSize("parent.w", "parent.h")
        :setPosition(2, 1)
        :setBackground(colors.black)
        :setForeground(colors.white)
        :setSelectionColor(colors.lightGray)
        --:addKeywords(colors.yellow, { "[", "]", "{", "}", "(", ")"})
        


local loadKeywords = function()
    local files = fs.list(path.."/assets/keywords")
        
    for _, v in pairs(files) do
        local keywordFile = fs.open(path.."/assets/keywords/"..v, "r")
        local keywordContents = keywordFile.readAll()
        local keywords = textutils.unserialise(keywordContents)
        keywordFile.close()

        local word_color = keywords[1]
        table.remove(keywords, 1)

        codespaceTF:addKeywords(word_color, keywords)
    end
end

local loadRules = function()
    codespaceTF:addRule("%c", colors.red)
end

local updatePosition = function()
    local cursorX, cursorY = codespaceTF:getTextCursor()

    local stringa = "Ln "..cursorY..", Col "..cursorX

    cursorPosLB:setPosition("parent.w-2-"..string.len(stringa))
    cursorPosLB:setText(stringa)
end 

loadKeywords()
loadRules()

for s in test_code:gmatch("[^\r\n]+") do
    codespaceTF:addLine(s)
end

codespace:onClick(updatePosition)
codespace:onKey(updatePosition)

basalt.autoUpdate()