local basalt = require(".UwUntuCC.OS.Libraries.Basalt")

return function(mainFrame)

    local mainFrame = require(".UwUntuCC.OS.Desktop.values")
    local rw, rh = mainFrame:getSize()
    local currentNotif = {}

    local plusAnimation = mainFrame:addAnimation()
    local minusAnimation = mainFrame:addAnimation()
    local hideAnimation = mainFrame:addAnimation()
    local showAnimation = mainFrame:addAnimation()

    local function plusStep()
        for i, v in pairs(currentNotif) do
            local w, h = v.frame:getPosition()

            local rww = rw-31
            local hh = h+8
            plusAnimation:setObject(v.frame)
                :move(rww, hh, 0.5)
                :play()
        end
    end

    local function minusStep()
        for i, v in pairs(currentNotif) do
            local w, h = v.frame:getPosition()

            local rww = rw-31
            local hh = h-7

            minusAnimation:setObject(v.frame)
                :move(rww, hh, 0.5)
                :play()
        end
    end

    local function hideNotif(v)
        local w, h = v.frame:getPosition()

            local rww = rw+2
            table.remove(currentNotif, v.index)
            hideAnimation:setObject(v.frame)
                :move(rww, h, 0.5)
                :play()
            mainFrame:addTimer():setTime(0.5)
                :onCall(function()
                    v.frame:remove()
                end)
                :start()
    end

    mainFrame:onEvent(function(self, event, title, desc, button1Event, button2Event)
        
        if event == "notification" then
            mainFrame:addThread():start(function()
            
            plusStep()
            sleep(0.5)
            local group = {}
                group.index = table.maxn(currentNotif) + 1
                group.body = desc
                group.title = title

                group.frame = p5:addFrame()
                    :setSize(31,6)
                    :setPosition(rw.."-31", 3)
                    :setBackground(colors.gray)
                group.titleL = group.frame:addLabel()
                    :setPosition(3,2)
                    :setText(title)
                    :setForeground(colors.white)
                group.bodyL = group.frame:addLabel()
                    :setSize(27,3)
                    :setPosition(3,3)
                    :setText(desc)
                    :setForeground(colors.lightGray)

                group.frame:addPane()
                    :setPosition(2,3)
                    :setSize(1,3)
                    :setBackground(colors.gray, "\149", colors.lightGray)
                group.frame:addPane()
                    :setPosition(2,2)
                    :setSize(1,1)
                    :setBackground(colors.gray, "\132", colors.white)

                if button1Event or button2Event == nil then
                    mainFrame:addTimer()
                        :onCall(function() 
                            hideNotif(group)
                        end)
                        :setTime(7)
                        :start()

                    group.frame
                        :onClick(function() 
                            hideNotif(group)
                        end)
                elseif button1Event and button2Event ~= nil then
                    group.allow = group.frame:addImage()
                        :loadImage("UwUntuCC/OS/Icons/okay.bimg")
                        :setPosition(24,4)
                        :setSize(3,2)
                        :onClick(function()
                            os.queueEvent(button1Event)
                        end)
                    
                    group.reject = group.frame:addImage()
                        :loadImage("UwUntuCC/OS/Icons/okay.bimg")
                        :setPosition(28,4)
                        :setSize(3,2)
                        :onClick(function()
                            os.queueEvent(button2Event)
                        end)

                    group.bodyL:setSize(21,3)
                else

                end

                table.insert(currentNotif, group)
            end)
        end
    end)
end