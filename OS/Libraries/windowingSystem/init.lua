local basalt = require(".UwUntuCC.OS.Libraries.Basalt")

os.queueEvent("8495532365")

local event, mainFrame = os.pullEvent("6771818008")

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
        local frame = mainFrame:addFrame()
            :setSize(53,21)
            :setMovable()
        local bar = frame:addFrame()
            :setSize(53,1)
        local label = bar:addLabel()
            :setPosition(22, 1)
            :setText("Window")
            centerText(label)
        local program = frame:addProgram()
            :setSize(51,19)
            :setPosition(2,2)
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

            run = function(self, path)
                if not args then
                    program:execute(path)
                else
                    --program:execute(path, args)
                end
                return true
            end, 

            close = function(self)
                frame:remove()
                return self
            end,
        }
        windows[token] = instance
        return instance
    end,

    getWindow = function(token)

    end,

}