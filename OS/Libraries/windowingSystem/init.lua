local basalt = require(".UwUntuCC.OS.Libraries.Basalt")
local db = require(".UwUntuCC.OS.Libraries.Databaser")
os.queueEvent("8495532365")

local event, mainFrame, p1, p2, p3, p4, p5 = os.pullEvent("6771818008")

local function createToken()
    return math.random(1000000, 9999999)
end

local function centerText(obj)
    obj:setPosition("parent.w / 2 -"..obj:getSize().."/2", 1)
end

local windows = {}

return {

    create = function()
        local token = createToken()
        local index = table.maxn(db.getColumn("RunningApps", "token")) + 1
 
        basalt.debug(index)
        db.setValue("RunningApps", "token", token, index)
        db.setValue("RunningApps", "hidden", "false", index)
        local frame = p3:addFrame()
            :setSize(53,21)
            :setMovable()
            :setPosition(5,5)
        local bar = frame:addFrame()
            :setSize(53,1)
        local label = bar:addLabel()
            :setPosition(22, 1)
            :setText("Window")
            :setForeground(colors.lightGray)
            centerText(label)
        local program = frame:addProgram()
            :setSize(51,19)
            :setPosition(2,2)
        local buttons = bar:addFrame()
            :setSize(5,1)
            :setPosition(2,1)
            :setBackground(false)

            local closeButton = buttons:addButton()
                :setSize(1,1)
                :setPosition(1,1)
                :setBackground(false)
                :setForeground(colors.lightGray)
                :setText("\7")
            
            local hideButton = buttons:addButton()
                :setSize(1,1)
                :setPosition(3,1)
                :setBackground(false)
                :setForeground(colors.lightGray)
                :setText("\7")

            local fullScreenButton = buttons:addButton()
                :setSize(1,1)
                :setPosition(5,1)
                :setBackground(false)
                :setForeground(colors.lightGray)
                :setText("\7")
        
            local resizableButton

        local minW = minW or 4
        local minH = minH or 4
        local maxW = maxW or 99
        local maxH = maxH or 99

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
                    resizableButton = frame:addButton()
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
                return true
            end, 

            close = function(self)
                frame:remove()
                return self
            end,

            hide = function(self)
                -- function to hide window
                return self
            end,

            show = function(self)
                return self

            end,

            fullscreen = function(self)

                return self
            end,
        }
        windows[token] = instance

        frame:onGetFocus(function() 
            program:injectEvent("gained_focus")
            label:setForeground(colors.white)
            closeButton:setForeground(colors.red)
            hideButton:setForeground(colors.orange)
            fullScreenButton:setForeground(colors.lime)
        end)

        frame:onLoseFocus(function()
            program:injectEvent("loosed_focus")
            label:setForeground(colors.lightGray)
            closeButton:setForeground(colors.lightGray)
            hideButton:setForeground(colors.lightGray)
            fullScreenButton:setForeground(colors.lightGray)
        
        end)

        return instance

    end,

    setup = function()
        db.setDir("UwUntuCC/OS/Data")
        fs.delete("UwUntuCC/OS/Data/RunningApps/name.json")
        fs.delete("UwUntuCC/OS/Data/RunningApps/path.json")
        fs.delete("UwUntuCC/OS/Data/RunningApps/hidden.json")
        fs.delete("UwUntuCC/OS/Data/RunningApps/token.json")

        db.addColumn("RunningApps", "name")
        db.addColumn("RunningApps", "path")
        db.addColumn("RunningApps", "hidden")
        db.addColumn("RunningApps", "token")
    end,

    getWindow = function(token)
        
    end,

}