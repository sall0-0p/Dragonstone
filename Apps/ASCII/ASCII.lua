
--[[
    MIT License

    Copyright (c) 2018 Sewbacca

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
--]]

local nPos = 0
local textCol = "0"
local backCol = "f"
local highCol = "b"

local function update()
    term.clear()
    term.setCursorPos(2, 2)

    for i=0,255 do
        local char = string.char(i)
        
        if nPos == i then
            term.blit(char, textCol, highCol)
        else
            term.blit(char, textCol, backCol)
        end

        if (i + 1) % 16 == 0 then    
            term.setCursorPos(2, math.floor(2 + ((i + 1) / 16)))
        end
    end

    term.setCursorPos(4, 19)
    write("Char: " .. nPos)
end

local bRunning = true
function handleEvent()
    local e, k, x, y = os.pullEvent()

    if e == "key" then
        if k == keys.left or k == keys.right then
            nPos = nPos + (k == keys.left and -1 or 1)
        elseif k == keys.up or k == keys.down then
            nPos = nPos + (k == keys.up and -16 or 16)
        elseif k == keys.backspace then
            bRunning = false
        end
        nPos = nPos < 0 and 0 or nPos
        nPos = nPos > 255 and 255 or nPos
    elseif e:match "mouse" then
        x = x - 2
        y = y - 2

        if x < 0 or x > 15 or y < 0 or y > 255 / 16 then
            return
        end

        nPos = y * 16 + x
    end
end

while bRunning do
    update()
    handleEvent()
end
print()