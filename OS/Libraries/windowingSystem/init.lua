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

local win = {}
local windows = {}

win =  {

    create = function()
        local winX, winY = math.random(3, 40), math.random(5, 25)
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
            :setSize(53,23)
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
                frame:setSize(width.."+2", height.."+2")
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
                if not args then
                    program:execute(path)
                else
                    program:execute(path, args)
                end
                db.setValue("RunningApps", "path", path, index)
                db.setValue("RunningApps", "icon", fs.getDir(path).."/icon.bimg", index)

                os.queueEvent("updateDock")

                return true
            end, 

            close = function(self)
                
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
                    :size(53, 21, 0.6)
                    :setObject(program)
                    :size(51, 19, 0.6)
                    :setObject(buttons)
                    :move(2, 1, 0.6)
                    :play()

                local index = db.search("RunningApps", "token", token)
                db.setValue("RunningApps", "hidden", "false", index)
                os.queueEvent("updateDock")
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
                    :size(rw+1, rh-1, 0.6)
                    :setObject(program)
                    :size(rw, rh-3, 0.6)
                    :setObject(buttons)
                    :move(3, 1, 0.6)
                    :play()
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