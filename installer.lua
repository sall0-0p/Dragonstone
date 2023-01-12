shell.run("wget", "run", "https://basalt.madefor.cc/install.lua", "packed")

basalt = require(".Basalt")

local mainFrame = basalt.createFrame()

local rw, rh = mainFrame:getSize()
    
--[[if rw < 70 or rh < 25 then]]
    smallscreenwarning = [[
        Your screen is too small! 
        Your current resolution is ]]..rw.."x"..rh..[[ px.
        If you want to use UwU change your resolution,
        minimum resolution is 70x25.
        You can do this is world configs or in CraftOS-PC configs.
        ---------------
        Ctrl+T to exit.
    ]]
    --[[ocal SmallResolutionFrame = mainFrame:addFrame()
        :setSize(rw,rh)
        :setBackground(colors.lightGray)
            
            SmallResolutionFrame:addLabel()
                :setText("Warning!")
                :setFontSize(2)
                :setPosition(5,5)

            SmallResolutionFrame:addLabel()
                :setPosition(6,8)
                :setSize(rw-"8", 10)
                :setText(smallscreenwarning)

end]]

local licenseScreen = mainFrame:addFrame()
    :setSize(rw.."-10", rh.."-11")
    :setPosition(6,6)
    :setBackground(colors.gray)

    --[[local request = http.get("https://raw.githubusercontent.com/sall0-0p/Dragonstone/master/LICENSE")
    local License = request.readAll()
    request.close()]]

    License = [[
        Copyright 2022 Dragonstone 
        -------------------
        Permission is hereby granted, free of charge, 
        to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
        The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
        -------------------
        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.]]

    licenseScreen:addLabel()
        :setText("Welcome to UwUntu")
        :setFontSize(2)
        :setPosition(5,4)
        :setBackground(colors.gray)
        :setForeground(colors.white)
    
        licenseScreen:addLabel()
            :setText("You can ignore that, Its just MIT license")
            :setPosition(6,7)
            :setBackground(colors.gray)
            :setForeground(colors.lightGray)
    
        local LicenseText = licenseScreen:addFrame()
            :setPosition(5,9)
            :setSize(rw.."-20", rh.."-24")
            :setBackground(colors.lightGray)
            
            :setForeground(colors.black)

            :addLabel()
                :setPosition(2,2)
                :setText(License)
                :setSize(rw.."-23", rh.."-26")

        local LicenseCheckBox = licenseScreen:addCheckbox()
                :setPosition(6, rh.."-14")
                :setBackground(colors.white)

        licenseScreen:addLabel() 
                :setPosition(8, rh.."-14")
                :setForeground(colors.white)
                :setText("I agree with Terms & Conditions")

        local NextButton = licenseScreen:addButton()
                :setPosition(rw.."-29", rh.."-14")
                :setText("Install")
                :setSize(13,3)
                :setBackground(colors.lightGray)
                :setForeground(colors.lightGray)
                :disable()

        local MemeCheckbox = licenseScreen:addCheckbox():setValue(true)
                :setPosition(6, rh.."-12")
                :setBackground(colors.white)

            licenseScreen:addLabel() 
                :setPosition(8, rh.."-12")
                :setForeground(colors.white)
                :setText("I don`t want to use LevelOS")

        LicenseCheckBox:onChange(function() 
            if LicenseCheckBox:getValue() then
                NextButton:setForeground(colors.black)
                NextButton:setBorder(colors.black)
                NextButton:setPosition(rw.."-28", rh.."-13")
                NextButton:setSize(11,1)
                NextButton:enable()
            else
                NextButton:setForeground(colors.lightGray)
                NextButton:setBorder(false)
                NextButton:setPosition(rw.."-29", rh.."-14")
                NextButton:setSize(13,3)
                NextButton:disable()
            end
        end)

        MemeCheckbox:onChange(function()
            _G._G = nil
        end)

NextButton:onClick(function()
    local request = http.get("https://raw.githubusercontent.com/sall0-0p/Dragonstone/master/UwU.lua")
    
    basalt.stop()
    term.clear()
    term.setCursorPos(1,1)
    shell.run("wget", "https://raw.githubusercontent.com/sall0-0p/Dragonstone/master/UwU.lua")

    shell.run("UwU.lua")

    shell.run("startup.lua")

    fs.delete("UwU.lua")
    --fs.delete("installer.lua")

    os.reboot()
    
end)
basalt.autoUpdate()

