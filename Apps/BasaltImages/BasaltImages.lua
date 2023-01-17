local basalt = require(".Dragonstone.OS.Libraries.Basalt")

local plusImage={{    {
    "                         ",
    "000000000000000000000000",
    "ffffffffffffffffffffffff",
  },
  {
    "                         ",
    "000000000000000000000000",
    "ffffffffffffffffffffffff",
  },
  {
    "                    ",
    "000000000077780000000000",
    "ffffffffff8887ffffffffff",
  },
  {
    "                    ",
    "00000000007ff80000000000",
    "ffffffffff8887ffffffffff",
  },
  {
    "                    ",
    "00000000007ff80000000000",
    "ffffffffff8887ffffffffff",
  },
  {
    "          ",
    "00000777777ff77777800000",
    "fffff88888888888887fffff",
  },
  {
    "          ",
    "00000888887f788888800000",
    "fffff77777888777777fffff",
  },
  {
    "                    ",
    "00000000007ff80000000000",
    "ffffffffff8887ffffffffff",
  },
  {
    "                    ",
    "00000000007f780000000000",
    "ffffffffff8887ffffffffff",
  },
  {
    "                    ",
    "000000000088880000000000",
    "ffffffffff7777ffffffffff",
  },
  {
    "                        ",
    "000000000000000000000000",
    "ffffffffffffffffffffffff",
  },
  {
    "                        ",
    "000000000000000000000000",
    "ffffffffffffffffffffffff",
  },}}


local main = basalt.createFrame()
local imageFrame = basalt.createFrame():onKey(function() main:show() end):onClick(function() main:show() end)
local imageObject = imageFrame:addImage():setSize("parent.w", "parent.h")
local topbar = main:addFrame():setSize("parent.w", 1):setZIndex(30)
local canvas = main:addFrame():setSize("parent.w", "parent.h-1"):setZIndex(5):setPosition(1,2)
local img = canvas:addGraphic():setSize("parent.w", "parent.h"):setBackground(colors.black , "\127", colors.gray)

local fileSubMenu = main:addFrame():setSize(12, 11):setPosition(1, -14):setZIndex(18):setShadow(colors.black)
local editSubMenu = main:addFrame():setSize(14, 11):setPosition(8,-10):setZIndex(18):setShadow(colors.black)

local loadFileFrame = main:addFrame():setSize(30, 7):setPosition(4, 3):setZIndex(20):setShadow(colors.black):hide()
local saveFileFrame = main:addFrame():setSize(20, 7):setZIndex(20):setShadow(colors.black):hide()

local setSizeFrame = main:addFrame():setSize(22, 9):setPosition("parent.w/2-self.w/2-1","parent.h/2-self.h/2-1"):setZIndex(20):setMovable():setShadow(colors.black):hide()
local setImgFrames = main:addFrame():setSize(45, 17):setPosition(1, 1):setZIndex(20):setShadow(colors.black):hide()

local configFrame = main:addFrame():setSize(15, 19):setPosition("parent.w + 16", 3):setZIndex(19):setShadow(colors.black):setMovable()
local asciiFrame = configFrame:addFrame():setSize("parent.w - 2", 7):setPosition(2,12):setBackground(colors.gray):setScrollable()

local metadataEdit = main:addFrame():setSize(39, 25):setPosition(19, -11):setBackground(colors.gray):setZIndex(20):setShadow(colors.black):hide()
local blitEdit = main:addFrame():setSize("parent.w - 8", "parent.h - 8"):setPosition(2, 2):setBackground(colors.gray):setZIndex(20):setShadow(colors.black):hide()
local blitCanvas = blitEdit:addFrame():setSize("parent.w", "parent.h-4"):setZIndex(5):setPosition(2,2)

local mainColor, secondColor = "0", "f"
local text,text2 = " ", " "
local mode = 1
local latestPath
local xO, yO = 0, 0
local availableColors = {"cyan", "purple", "brown", "orange", "red", "gray", "magenta", "blue", "lightBlue", "green", "lightGray", "pink", "black", "white", "black", "lime"}

local function tableCount(t)
    local n = 0
    if(t~=nil)then
        for k,v in pairs(t)do
            n = n + 1
        end
    end
    return n
end

--ANIMATIONS
local fileSubIsHidden = true
local fileSubAnimShow = main:addAnimation()
                :setObject(fileSubMenu)
                :move(1, 2, 0.8)
local fileSubAnimHide = main:addAnimation()
                :setObject(fileSubMenu)
                :move(1, -14, 0.8)

local function setFileSubVisiblity(show)
    local vis = show
    if(vis==nil)then vis = fileSubIsHidden end
    if(vis)then
        fileSubAnimShow:play()
        fileSubIsHidden = false
    else
        fileSubAnimHide:play()
        fileSubIsHidden = true
    end
end

local editSubIsHidden = true
local editSubAnimShow = main:addAnimation()
                :setObject(editSubMenu)
                :move(8, 2, 0.5)
local editSubAnimHide = main:addAnimation()
                :setObject(editSubMenu)
                :move(8, -10, 0.5)

local function setEditSubVisiblity(show)
    local vis = show
    if(vis==nil)then vis = editSubIsHidden end
    if(vis)then
        editSubAnimShow:play()
        editSubIsHidden = false
    else
        editSubAnimHide:play()
        editSubIsHidden = true
    end
end

local configAnimShow = main:addAnimation()
local function configShow()
    configAnimShow:clear()
    :setObject(configFrame)
    :setMode("easeOutCirc")
    :onStart(function()
        configFrame:setPosition("parent.w + 16", 3)
        configFrame:show()
    end)
    :move(main:getWidth() - 16, 3, 1)
    :onDone(function()
        configFrame:setPosition("parent.w - 16", 3)
    end)
    :play()
end
configShow()

local configAnimHide = main:addAnimation()
local function configHide()
    configAnimHide:clear()
    :setObject(configFrame)
    :move(main:getWidth() + 18, 3, 1)
    :onDone(function()
        configFrame:hide()
    end)
    :play()
end

local subFrameObjectShow = main:addAnimation()
local subFrameObjectHide = main:addAnimation()
local function subObjectShow(obj)
    obj:setPosition(main:getWidth() / 2 - obj:getWidth() / 2 , -10)
    obj:show()
    subFrameObjectShow:clear()
    :setObject(obj)
    :move(main:getWidth() / 2 - obj:getWidth() / 2, 3, 0.5)
    :onDone(function()
        obj:setPosition("parent.w / 2 - self.w / 2", 3)
    end)
    :play()
end

local function subObjectHide(obj)
    subFrameObjectHide:clear()
    :setObject(obj)
    :onDone(function()
        obj:hide()
    end)
    :move(math.floor(main:getWidth() / 2 - obj:getWidth() / 2 + 0.5), -obj:getHeight()-1, 0.5)
    :play()
end

-- Notification Message
local notifications = {}
local activeNotifications = 0

local function getFreeNotification()
    for k,v in pairs(notifications)do
        if not(v.active)then
            return k
        end
    end
    return #notifications + 1
end

local function sendNotification(title, info, time)
    os.queueEvent("notification", title, info)
    -- freeNotification = getFreeNotification()
    -- if(notifications[freeNotification]==nil)then
    --     notifications[freeNotification] = {}
    --     notifications[freeNotification].frame = main:addFrame():setSize(30, 5):setZIndex(20)
    --     notifications[freeNotification].title = notifications[freeNotification].frame:addLabel():setForeground(colors.lightGray):setPosition(2, 1)
    --     notifications[freeNotification].label = notifications[freeNotification].frame:addLabel():setSize("parent.w - 3", "parent.h - 2"):setPosition(2, 3):setForeground(colors.black)
    --     notifications[freeNotification].show = main:addAnimation()
    --     notifications[freeNotification].hide = main:addAnimation()
    -- end
    -- local selectedNotification = notifications[freeNotification]
    -- selectedNotification.active = true
    -- local notificationOffset = (freeNotification-1)*6
    -- selectedNotification.frame:setPosition("parent.w + 2", "parent.h - 5 - "..notificationOffset)
    -- selectedNotification.frame:show()
    -- selectedNotification.title:setText(title)
    -- selectedNotification.label:setText(info)
    -- basalt.schedule(function()
    --     selectedNotification.show:clear()
    --     selectedNotification.show:setMode("easeOutBounce")
    --     selectedNotification.show:setObject(selectedNotification.frame)
    --     selectedNotification.show:move(main:getWidth() - 30, main:getHeight() - 5 - notificationOffset, 1)
    --     selectedNotification.show:onDone(function()
    --         selectedNotification.frame:setPosition("parent.w - 30", "parent.h - 5 - "..notificationOffset)
    --     end)
    --     selectedNotification.show:play()
    --     sleep(time or 4)
    --     selectedNotification.hide:clear()
    --     selectedNotification.hide:setObject(selectedNotification.frame)
    --     selectedNotification.hide:move(main:getWidth() + 2, main:getHeight() - 5 - notificationOffset, 1)
    --     selectedNotification.hide:onDone(function()
    --         selectedNotification.frame:setPosition("parent.w + 2", "parent.h - 5 - "..notificationOffset)
    --         selectedNotification.frame:hide()
    --     end)
    --     selectedNotification.hide:play()
    --     activeNotifications = activeNotifications - 1
    --     selectedNotification.active = false
    -- end)()
end

-- Topbar
local infoLabel = topbar:addLabel():setPosition("parent.w - self.w", 1)
local function updateInfoLabel()
    local w, h = img:getImageSize()
    local t = "W: "..w.." H: "..h.." X: "..-xO.." Y: "..-yO
    infoLabel:setText(t)
    infoLabel:setSize(#t-1, 1)
end
updateInfoLabel()
topbar:addButton():setText("File"):setSize(8, 1):onClick(function()
    setFileSubVisiblity()
    setEditSubVisiblity(false)
end)
topbar:addButton():setText("Edit"):setSize(8, 1):setPosition(9,1):onClick(function()
    setFileSubVisiblity(false)
    setEditSubVisiblity()
end)
topbar:addButton():setText("Show"):setSize(8, 1):setPosition(18,1):onClick(function()
    imageFrame:show()
    imageObject:setImage(img:getImage()):usePalette(true):play(true)
    setEditSubVisiblity(false)
    setFileSubVisiblity(false)
end)

-- File Sub Menu:
local newFile = fileSubMenu:addButton():setText("New File"):setPosition(1,2):setSize("parent.w", 1):onClick(function() end)
local lFile = fileSubMenu:addButton():setText("Open File"):setPosition(1,4):setSize("parent.w", 1)
local saveFile = fileSubMenu:addButton():setText("Save"):setPosition(0,6):setSize("parent.w", 1)
local saveFileAs = fileSubMenu:addButton():setText("Save As"):setPosition(1,8):setSize("parent.w", 1)
local quit = fileSubMenu:addButton():setText("Quit"):setPosition(1,10):setSize("parent.w", 1):onClick(function() basalt.stop() end)

local loadFilePathInput
lFile:onClick(function()
    setFileSubVisiblity(false)
    setEditSubVisiblity(false)
    subObjectShow(loadFileFrame)
    loadFileFrame:setFocus()
    if(loadFilePathInput~=nil)then loadFilePathInput:setValue("") end
end)

local saveFileInput
saveFileAs:onClick(function()
    setFileSubVisiblity(false)
    setEditSubVisiblity(false)
    subObjectShow(saveFileFrame)
    saveFileFrame:setFocus()
    if(saveFileInput~=nil)then saveFileInput:setValue("") end
end)

local function saveBimg(path)
    if not(path=="")then
        if not(path:find(".bimg"))then path = path..".bimg" end
        local f = fs.open(path, "w")
        sendNotification("Info", "Successfully saved to "..path)
        f.write(textutils.serialize(img:getImage()))
        f.close()
    else
        sendNotification("Info", "Error - invalid path!")
    end
end

saveFile:onClick(function()
    setFileSubVisiblity(false)
    setEditSubVisiblity(false)
    if(latestPath~=nil)and(latestPath~="")then
        saveBimg(latestPath)
    else
        subObjectShow(saveFileFrame)
        saveFileFrame:setFocus()
        if(saveFileInput~=nil)then saveFileInput:setValue("") end
    end
end)

-- Load File Frame
loadFileFrame:onLoseFocus(function()
    subObjectHide(loadFileFrame)
end)
loadFileFrame:addLabel():setPosition(2, 2):setText("Path:")
loadFilePathInput = loadFileFrame:addInput():setSize("parent.w-2", 1):setPosition(2,4):setBackground(colors.black):setForeground(colors.lightGray)

loadFileFrame:addButton():setSize(8, 1):setText("Open"):setPosition(12, 6):setBackground(colors.black):setForeground(colors.lightGray):onClick(function()
    subObjectHide(loadFileFrame)
    local path = loadFilePathInput:getValue()
    if(not(fs.exists(path))and(not(fs.exists(path..".bimg")))or(path=="")or(path=="/"))then
        sendNotification("Error", "Path "..path.." doesn't exist!")
        return
    end
    img:clear()
    img:loadImage(fs.exists(path) and path or path..".bimg")
    latestPath = fs.exists(path) and path or path..".bimg"
    updateInfoLabel()
    sendNotification("Image", "Successfully opened "..latestPath)
end)

-- Save File Frame
saveFileFrame:onLoseFocus(function()
    subObjectHide(saveFileFrame)
end)
saveFileFrame:addLabel():setText("Save To:"):setPosition(2, 2)
saveFileInput = saveFileFrame:addInput():setSize("parent.w-2", 1):setPosition(2,4):setBackground(colors.black):setForeground(colors.lightGray)

saveFileFrame:addButton():setSize(8, 1):setText("Save"):setPosition(12, 6):setBackground(colors.black):setForeground(colors.lightGray):onClick(function()
    subObjectHide(saveFileFrame)
    local path = saveFileInput:getValue()
    latestPath = path
    saveBimg(path)
end)

-- Edit Metadata Frame:
metadataEdit:setTheme({ButtonBG = colors.black, ButtonText = colors.lightGray, InputBG = colors.black, InputText = colors.lightGray})
metadataEdit:onLoseFocus(function()
    subObjectHide(metadataEdit)
end)

local newMeta = {}
local newMetaPal = {}
metadataEdit:addLabel():setText("Title:"):setPosition(2, 2)
newMeta.title = metadataEdit:addInput():setPosition(21, 2):setSize(18, 1)
metadataEdit:addLabel():setText("Author:"):setPosition(2, 4)
newMeta.author = metadataEdit:addInput():setPosition(21, 4):setSize(18, 1)
metadataEdit:addLabel():setText("Description:"):setPosition(2, 6)
newMeta.description = metadataEdit:addInput():setPosition(21, 6):setSize(18, 1)
metadataEdit:addLabel():setText("Version:"):setPosition(2, 8)
newMeta.version = metadataEdit:addInput():setPosition(21, 8):setSize(18, 1)
metadataEdit:addLabel():setText("Creator:"):setPosition(2, 10)
newMeta.creator = metadataEdit:addInput():setPosition(21, 10):setSize(18, 1)
metadataEdit:addLabel():setText("Date:"):setPosition(2, 12)
newMeta.date = metadataEdit:addInput():setPosition(21, 12):setSize(18, 1)
metadataEdit:addLabel():setText("Animated:"):setPosition(2, 14)
newMeta.animated = metadataEdit:addCheckbox():setPosition(21, 14):setBackground(colors.black):setForeground(colors.lightGray)
metadataEdit:addLabel():setText("Seconds per frame:"):setPosition(2, 16)
newMeta.secondsPerFrame = metadataEdit:addInput():setPosition(21, 16):setSize(18, 1)
metadataEdit:addLabel():setText("Palette:"):setPosition(2, 18)

local metaPaletteInput = metadataEdit:addInput():setPosition(24, 18):setSize(15,1)
local metaPaletteDropdown = metadataEdit:addDropdown():setPosition(11, 18):setBackground(colors.black):setForeground(colors.lightGray):setDropdownSize(12, 3)
:onChange(function(self, val)
    metaPaletteInput:setValue(tonumber(newMetaPal[colors[val.text]]) or colors[val.text])
    basalt.debug(#newMetaPal, colors[val.text])
end)
for k,v in pairs(availableColors)do
    metaPaletteDropdown:addItem(v)
end
metadataEdit:addButton():setPosition(24, 20):setText("Replace"):setSize(9, 1)
:onClick(function()
    local val = metaPaletteInput:getValue()
    if(val=="")then sendNotification("Error", "Please enter a palette color!") return end
    if(tonumber(val)==nil)then
        sendNotification("Error", val.." is not a valid number!")
    else
        local dVal = metaPaletteDropdown:getValue()
        if(dVal~=nil)and(colors[dVal.text]~=nil)then
            newMetaPal[colors[dVal.text]] = val
            sendNotification("Success", "Successfully replaced "..dVal.text.." with "..val..".")
        else
            sendNotification("Error", "Please choose a color to replace!")
        end
    end
end)


local default = {secondsPerFrame = "0.2"}
local function updateMetaFrame()
    basalt.schedule(function()
        local curMeta = img:getMetadata()
        for k,v in pairs(newMeta)do
            if(k~=animated)then
                v:setValue(curMeta[k] or default[k] or "")
            end
        end
        newMetaPal = curMeta.palette or {}
    end)()
end

local function saveMetadata()
    basalt.schedule(function()
        local m = {}
        for k,v in pairs(newMeta)do
            local val = v:getValue()
            if(val~=nil)and(val~="")then
                m[k] = val
            end
        end
        if(tableCount(newMetaPal)>0)then
            m.palette = newMetaPal
        end
        img:setMetadata(m)
    end)()
end

metadataEdit:addButton():setText("Close"):setSize(7, 1):setPosition(2, 23):onClick(function()
    subObjectHide(metadataEdit)
end)
metadataEdit:addButton():setText("Save"):setSize(6, 1):setPosition("parent.w-6", 23):onClick(function()
    subObjectHide(metadataEdit)
    saveMetadata()
end)

-- Set Blit Frame:
local blitMainCol,blitSecondCol = "0", "f"
blitCanvas:setBackground(colors.black):setSize("parent.w - 15", "parent.h - 6")
local graphicFrameColors = {
    ["0"] = blitEdit:addButton():setPosition("parent.w - 10", 3):setBackground(colors.white):setSize(1,1):setText("1"),
    ["1"] = blitEdit:addButton():setPosition("parent.w - 9", 3):setBackground(colors.orange):setSize(1,1):setText(" "),
    ["2"] = blitEdit:addButton():setPosition("parent.w - 8", 3):setBackground(colors.magenta):setSize(1,1):setText(" "),
    ["3"] = blitEdit:addButton():setPosition("parent.w - 7", 3):setBackground(colors.lightBlue):setSize(1,1):setText(" "),
    ["4"] = blitEdit:addButton():setPosition("parent.w - 6", 3):setBackground(colors.yellow):setSize(1,1):setText(" "),
    ["5"] = blitEdit:addButton():setPosition("parent.w - 5", 3):setBackground(colors.lime):setSize(1,1):setText(" "),
    ["6"] = blitEdit:addButton():setPosition("parent.w - 4", 3):setBackground(colors.pink):setSize(1,1):setText(" "),
    ["7"] = blitEdit:addButton():setPosition("parent.w - 3", 3):setBackground(colors.gray):setSize(1,1):setText(" "),
    ["8"] = blitEdit:addButton():setPosition("parent.w - 10", 4):setBackground(colors.lightGray):setSize(1,1):setText(" "),
    ["9"] = blitEdit:addButton():setPosition("parent.w - 9", 4):setBackground(colors.cyan):setSize(1,1):setText(" "),
    ["a"] = blitEdit:addButton():setPosition("parent.w - 8", 4):setBackground(colors.purple):setSize(1,1):setText(" "),
    ["b"] = blitEdit:addButton():setPosition("parent.w - 7", 4):setBackground(colors.blue):setSize(1,1):setText(" "),
    ["c"] = blitEdit:addButton():setPosition("parent.w - 6", 4):setBackground(colors.brown):setSize(1,1):setText(" "),
    ["d"] = blitEdit:addButton():setPosition("parent.w - 5", 4):setBackground(colors.green):setSize(1,1):setText(" "),
    ["e"] = blitEdit:addButton():setPosition("parent.w - 4", 4):setBackground(colors.red):setSize(1,1):setText(" "),
    ["f"] = blitEdit:addButton():setPosition("parent.w - 3", 4):setBackground(colors.black):setSize(1,1):setForeground(colors.white):setText("2"),
}


local function colorSetup(obj, color)
    obj:onClick(function(self, event, btn)
        if(btn==1)then
            if(blitSecondCol == color)then return end
            blitMainCol = color
        elseif(btn==2)then
            if(blitMainCol == color)then return end
            blitSecondCol = color
        end
        for k,v in pairs(graphicFrameColors)do
            if(k==blitMainCol)then
                v:setText("1")
            elseif(k==blitSecondCol)then
                v:setText("2")
            else
                v:setText(" ")
            end
        end
        if(mode==3)then changeMode(1) end
    end)
end


for k,v in pairs(graphicFrameColors)do
    colorSetup(v, k)
end
local blitMap = {{}}
table.insert(blitMap[1], blitCanvas:addGraphic():setPosition(1, 1):setSize(2, 3):setBackground(colors.black , "\127", colors.gray)
:onClick(function(self, event, btn, x, y) 
    self:setBg(btn==1 and blitMainCol or blitSecondCol, x, y)
    self:setText(" ", x, y)
end))


blitEdit:setTheme({ButtonBG = colors.black, ButtonText = colors.lightGray})



blitEdit:addButton():setPosition("parent.w - 7", "parent.h - 1"):setText("Copy"):setSize(6, 1)
blitEdit:addButton():setPosition("parent.w - 17", "parent.h - 1"):setText("Cancel"):setSize(8, 1)
:onClick(function()
    subObjectHide(blitEdit)
end)

local blitSizeHorizontal = blitCanvas:addButton():setSize(1, 1):setText("+"):setPosition(4, 2):onClick(function(self, event, btn, x, y)
    local xPos, yPos = self:getPosition()
    for k,v in pairs(blitMap)do
        table.insert(v, blitCanvas:addGraphic():setPosition(#v*2, (k-1)*3+1):setSize(2, 3):setBackground(colors.black , "\127", colors.gray)
        :onClick(function(self, event, btn, x, y) 
            self:setBg(btn==1 and blitMainCol or blitSecondCol, x, y) 
            self:setText(" ", x, y) 
        end))
    end
    self:setPosition(#blitMap[1] * 2 + 2)
end)

local blitSizeVertical = blitCanvas:addButton():setSize(1, 1):setText("+"):setPosition(2, 5):onClick(function(self, event, btn, x, y)
    local xPos, yPos = self:getPosition()
    local t = {}
    for n=1,#blitMap[1] do
        table.insert(t, 
        blitCanvas:addGraphic():setPosition(#t*2, (#blitMap)*3+1):setSize(2, 3):setBackground(colors.black , "\127", colors.gray)
        :onClick(function(self, event, btn, x, y) 
            self:setBg(btn==1 and blitMainCol or blitSecondCol, x, y) 
        end))
    end
    table.insert(blitMap, t)
    self:setPosition(2, #blitMap * 3 + 2)
end)

-- Edit Sub Menu:
editSubMenu:addButton():setText("Set Size"):setPosition(1,2):setSize("parent.w", 1):onClick(function()
    setEditSubVisiblity(false)
    setSizeFrame:show()
end)
editSubMenu:addButton():setText("Tools"):setPosition(1,4):setSize("parent.w", 1):onClick(function()
    setEditSubVisiblity(false)
    if not(configFrame:isVisible())then
        configShow()
    end
end)

editSubMenu:addButton():setText("Frames"):setPosition(1,6):setSize("parent.w", 1):onClick(function()
    setEditSubVisiblity(false)
    subObjectShow(setImgFrames)
    setImgFrames:setFocus()
end)

editSubMenu:addButton():setText("Metadata"):setPosition(1,8):setSize("parent.w", 1):onClick(function()
    setEditSubVisiblity(false)
    subObjectShow(metadataEdit)
    updateMetaFrame()
    metadataEdit:setFocus()
end)

editSubMenu:addButton():setText("Blit"):setPosition(1,10):setSize("parent.w", 1):onClick(function()
    setEditSubVisiblity(false)
    subObjectShow(blitEdit)
    blitEdit:setFocus()
end)

-- Image Frames Frame:
setImgFrames:addLabel():setPosition(2, 1):setText("Change frame:"):ignoreOffset()

local activeSelectionFrame
setImgFrames:onLoseFocus(function()
    if(activeSelectionFrame==nil)then
        subObjectHide(setImgFrames)
    end
end)

local framesPreview = {}
local addImgFrame = setImgFrames:addImage():setImage(plusImage):setSize(23, 13)

setImgFrames:onScroll(function(self, event, dir)
    local xO = self:getOffset()
    local newOffset = xO+dir*2<0 and -1 or xO+dir*2>#framesPreview*25+25-self:getWidth() and 1 or dir*2
    if(xO + newOffset>=0)and(xO+newOffset<=(#framesPreview*25)+25-self:getWidth())then
        self:setOffset(xO+newOffset, 0)
    end
end)

local editFrameHideAnimation = main:addAnimation()
local editFrameCache
local function editFrame(id)
    if(editFrameCache==nil)then
        editFrameCache = main:addFrame()
            :setSize(30, 11)
            :show()
            :setPosition("parent.w / 2 - self.w / 2", 3)
            :setFocus()
            :setShadow(colors.black)

            editFrameCache:addLabel():setPosition(2, 2):setText("Frame "..id)
            local frameMetadata = img:getFrameMetadata(id)
            --basalt.debug(frameMetadata)
            editFrameHideAnimation
            :clear()
            :setObject(editFrameCache)
            :move(editFrameCache:getX(), - (editFrameCache:getHeight()+1), 1)
            :onDone(function() editFrameCache:remove() basalt.schedule(function() sleep(0.05) editFrameCache = nil end)() end)
            local newColorPalette = {}
            if(frameMetadata.palette~=nil)then
                for k,v in pairs(frameMetadata.palette)do
                    newColorPalette[k] = v
                end
            end
            editFrameCache:addLabel():setPosition(2, 4):setText("Duration:")
            local duration = editFrameCache:addInput():setPosition(17, 4):setBackground(colors.black):setForeground(colors.lightGray):setInputType("number")
            duration:setValue(frameMetadata.duration or "")
            editFrameCache:addLabel():setPosition(2, 6):setText("Palette-Color:")
            local pColor = editFrameCache:addInput():setPosition(17, 6):setBackground(colors.black):setForeground(colors.lightGray)
            local colorDropdown = editFrameCache:addDropdown():setPosition(2, 8):setBackground(colors.black):setForeground(colors.lightGray):setDropdownSize(12, 3)
            :onChange(function(self, val)
                pColor:setValue(tonumber(newColorPalette[colors[val.text]]) or colors[val.text])
            end)
            for k,v in pairs(availableColors)do
                colorDropdown:addItem(v)
            end
            editFrameCache:addButton():setText("Replace"):setPosition(16, 8):setSize(11, 1):setBackground(colors.black):setForeground(colors.lightGray):onClick(function() 
                local val = pColor:getValue()
                if(val=="")then sendNotification("Error", "Please enter a palette color!") return end
                if(tonumber(val)==nil)then
                    sendNotification("Error", val.." is not a valid number!")
                else
                    local dVal = colorDropdown:getValue()
                    if(dVal~=nil)and(colors[dVal.text]~=nil)then
                        newColorPalette[colors[dVal.text]] = val
                        sendNotification("Success", "Successfully replaced "..dVal.text.." with "..val..".")
                    else
                        sendNotification("Error", "Please choose a color to replace!")
                    end
                end
            end)

            editFrameCache:addButton():setText("x"):setPosition("parent.w", 1):setSize(1, 1):onClick(function() 
                editFrameHideAnimation:play()
            end)

            editFrameCache:addButton():setText("Apply"):setPosition("parent.w - 7", "parent.h - 1"):setBackground(colors.black):setForeground(colors.lightGray):setSize(7, 1):onClick(function() 
                editFrameHideAnimation:play()
                local metadata = {}
                local dur = duration:getValue()
                if(dur~="")and(tonumber(dur)~=nil)then
                    metadata.duration = dur
                end
                if(tableCount(newColorPalette)>0)then
                    metadata.palette = newColorPalette
                end
                sendNotification("Success", "Successfully saved the metadata for frame"..id..".")
                img:setFrameMetadata(id, metadata)
            end)
    else
        editFrameCache:remove()
        editFrameCache = nil
        editFrame(id)
    end
end

local function calculatePreviewImages()
    for k,v in pairs(framesPreview)do
        v:remove()
    end
    framesPreview = {}
    local imgX = 0
    local imgY = 0
    local iWidth, iHeight = img:getImageSize()
    local imageFrames = img:getFrames()
    for k,v in pairs(imageFrames)do
        local selectionFrame = main:addFrame()
            :hide()
            :setShadow(colors.black)
            :setSize(15, 13)
            :setZIndex(30)
            :onLoseFocus(function(self)
                activeSelectionFrame = nil
                self:hide()
                basalt.schedule(function()
                    sleep(0.1)
                    if not(setImgFrames:isFocused())then
                        subObjectHide(setImgFrames)
                    end
                end)()
            end)
            selectionFrame:addButton():setSize("parent.w", 1):setPosition(1, 2):setText("Select"):onClick(function() img:selectFrame(k) end)
            selectionFrame:addButton():setSize("parent.w", 1):setPosition(1, 4):setText("Remove"):onClick(function()
                if(#imageFrames>1)then
                    img:removeFrame(k)
                    img:selectFrame(k-1 >= 1 and k-1 or 1)
                    calculatePreviewImages()
                else
                    sendNotification("Remove", "Can't remove last frame.")
                end
            end)
            selectionFrame:addButton():setSize("parent.w", 1):setPosition(1, 6):setText("Copy"):onClick(function() 
                img:addFrame(k+1) 
                local fImg = img:getFrameObject(k).getFrameImage()
                img:getFrameObject(k+1).setFrameImage(fImg)
                calculatePreviewImages()
            end)
            selectionFrame:addButton():setSize("parent.w", 1):setPosition(1, 8):setText("Edit"):onClick(function() editFrame(k) end)
            selectionFrame:addButton():setSize("parent.w", 1):setPosition(1, 10):setText("Move left"):onClick(function() img:moveFrame(k, -1) calculatePreviewImages() end)
            selectionFrame:addButton():setSize("parent.w", 1):setPosition(1, 12):setText("Move right"):onClick(function() img:moveFrame(k, 1) calculatePreviewImages() end)

        local i = {v, width=iWidth, height = iHeight}
        table.insert(framesPreview, setImgFrames:addImage():setSize(23, 13):setPosition(25*imgX + 2, 15 * imgY + 3):setImage(i):resizeImage(23, 13)
        :onClick(function(self, ev, btn, x, y, xAbs, yAbs)
            if(btn==1)then
                img:selectFrame(k)
            else
                basalt.schedule(function()
                    sleep(0.1)
                    activeSelectionFrame = selectionFrame
                    selectionFrame:show()
                        :setPosition(xAbs, yAbs)
                        :setFocus()                    
                end)()
            end
        end))
        imgX = imgX + 1
    end
    addImgFrame:setPosition(25*imgX + 2, 15 * imgY + 3)
end
calculatePreviewImages()

addImgFrame:onClick(function()
    img:addFrame()
    calculatePreviewImages()
end)

-- Set Size Frame:
local canvasSizeDrag = canvas:addButton("cSD"):setPosition(-1, -1):setSize(1,1):setText("\23"):setZIndex(8):setBackground(colors.black):setForeground(colors.lightGray)
local canvasAllowAutoSize = canvas:addCheckbox():setValue(true):setPosition("cSD.x + 1", "cSD.y"):setZIndex(8)

local function canvasSizeDragPosition()
    local xOffset, yOffset = img:getOffset()
    local wI, hI = img:getImageSize()
    canvasSizeDrag:setPosition(wI+1+xOffset, hI+1+yOffset)
end

setSizeFrame:addButton():setAnchor("topRight"):setSize(1, 1):setText("x"):setPosition(1, 1):setBackground(colors.black):setForeground(colors.lightGray):onClick(function()
    basalt.schedule(function() sleep(0.1) setSizeFrame:hide() end)()
end)
setSizeFrame:addLabel():setText("Image Size"):setSize("parent.w", 1):setBackground(colors.black):setForeground(colors.lightGray)
setSizeFrame:addLabel():setText("Width:"):setPosition(2, 2)
local wInput = setSizeFrame:addInput():setInputType("number"):setPosition(2, 3):setBackground(colors.black):setForeground(colors.lightGray)

setSizeFrame:addLabel():setText("Height:"):setPosition(2, 5)
local hInput = setSizeFrame:addInput():setInputType("number"):setPosition(2, 6):setBackground(colors.black):setForeground(colors.lightGray)

local stretch = setSizeFrame:addCheckbox():setPosition(2, 8):setBackground(colors.black):setForeground(colors.lightGray)

setSizeFrame:addButton():setText("Confirm"):setSize(10,1):setPosition(12, 8):setBackground(colors.black):setForeground(colors.lightGray):onClick(function()
    basalt.schedule(function() sleep(0.1) setSizeFrame:hide() end)()
    local w,h = tonumber(wInput:getValue()), tonumber(hInput:getValue())
    if(w==nil)or(h==nil)then return end
    if(w>0)and(h>0)then
        if(stretch:getValue())then
            img:resizeImage(w, h)
        else
            img:setImageSize(w, h) 
        end
    end
    updateInfoLabel()
    canvasSizeDragPosition()
    calculatePreviewImages()
end)

-- Canvas:
canvasSizeDrag:onDrag(function(self, event, btn, x, y, xOffset, yOffset)
    if(canvasAllowAutoSize:getValue())then
        local wI, hI = img:getImageSize() 
        if(wI-xOffset>=1)and(hI-yOffset>=1)then
            img:setImageSize(wI-xOffset, hI-yOffset, true)
            canvasSizeDragPosition()
            updateInfoLabel()
        end
    end
end)
canvasSizeDrag:onClickUp(function()
    calculatePreviewImages()
end)

local function canvasClickHandler(btn, x, y)
    setFileSubVisiblity(false)
    setEditSubVisiblity(false)
    local xOffset, yOffset = img:getOffset()
    x = x-xOffset
    y = y-yOffset
    if(x<1)or(y<1)then return end
    if not(canvasAllowAutoSize:getValue())then
        local wI, hI = img:getImageSize() 
        if(x > wI)then return end
        if(y > hI)then return end
    end

    if(mode==1)then
        if(btn==1)then
            img:setBg(mainColor, x, y)
        elseif(btn==2)then
            img:setBg(secondColor, x, y)
        end
    end
    if(mode==4)or(mode==7)then
        if(btn==1)then
            img:setBg(mainColor:rep(#text), x, y)
        else
            img:setBg(mainColor:rep(#text2), x, y)
        end
    end
    if(mode==2)then
        if(btn==1)then
            img:setFg(mainColor, x, y)
        elseif(btn==2)then
            img:setFg(secondColor, x, y)
        end
    end
    if(mode==5)then
        if(btn==1)then
            img:setFg(mainColor:rep(#text), x, y)
        else
            img:setFg(mainColor:rep(#text2), x, y)
        end
    end
    if(mode==7)then
        if(btn==1)then
            img:setFg(secondColor:rep(#text), x, y)
        else
            img:setFg(secondColor:rep(#text2), x, y)
        end
    end
    if(mode==6)then
        if(btn==1)then
            img:setBg(mainColor, x, y)
            img:setFg(secondColor, x, y)
        else
            img:setFg(mainColor, x, y)
            img:setBg(secondColor, x, y)
        end
    end
    if(mode==3)or(mode==4)or(mode==5)or(mode==7)then
        if(btn==1)then
            img:setText(text, x, y)
        elseif(btn==2)then
            img:setText(text2, x, y)
        end
    end
    canvasSizeDragPosition()
end

img:onDrag(function(self, event, btn, x, y, xOffset, yOffset)
    if(basalt.isKeyDown(keys.leftCtrl))then
        img:setOffset(-xOffset, -yOffset, true)
        xO = xO-xOffset
        yO = yO-yOffset
        canvasSizeDragPosition()
    else
        canvasClickHandler(btn, x, y)
    end
    updateInfoLabel()
end)
img:onClick(function(self, event, btn, x, y, xOffset, yOffset)
    if not(basalt.isKeyDown(keys.leftCtrl))then
        basalt.setMouseDragThrottle(0)
    end
end)
img:onClickUp(function(self, event, btn, x, y)
    if not(basalt.isKeyDown(keys.leftCtrl))then
        if(img:isFocused())then canvasClickHandler(btn, x, y) end
    end
    calculatePreviewImages()
end)

main:onClickUp(function()
    basalt.setMouseDragThrottle(50)
end)

-- Config Frame:
local function sendModeNotification()
    if(mode==1)then sendNotification("Mode", "Background", 2)
    elseif(mode==2)then sendNotification("Mode", "Foreground", 2)
    elseif(mode==3)then sendNotification("Mode", "Text", 2)
    elseif(mode==4)then sendNotification("Mode", "Background, Text", 2)
    elseif(mode==5)then sendNotification("Mode", "Foreground, Text", 2)
    elseif(mode==6)then sendNotification("Mode", "Background, Foreground", 2)
    elseif(mode==7)then sendNotification("Mode", "Background, Foreground, Text", 2)
    end
end
configFrame:addLabel():setText("Tools"):setBackground(colors.black):setSize("parent.w", 1):setForeground(colors.lightGray)
configFrame:addButton():setText("x"):setPosition("parent.w", 1):setSize(1, 1):setForeground(colors.lightGray):setBackground(colors.black):onClick(function() configHide() end)
configFrame:addLabel():setText("Mode:"):setPosition(2, 6)
local modes = configFrame:addMenubar():setPosition(3, 7):setSize("parent.w - 5", 1)
        :setSelectedItem(colors.gray, colors.lightGray)
        :setSpace(1)
        :setScrollable()
        :addItem("B")
        :addItem("F")
        :addItem("T")
        :addItem("BT")
        :addItem("FT")
        :addItem("BF")
        :addItem("BFT")
        :onChange(function(self)
            mode = self:getItemIndex()
            sendModeNotification()
        end)

local function changeMode(m)
    mode = m
    modes:selectItem(m)
end
configFrame:addButton():setText("<"):setPosition(2, 7):setSize(1, 1)
configFrame:addButton():setText(">"):setPosition("parent.w - 2", 7):setSize(1, 1)
configFrame:addLabel():setText("Text:"):setPosition(2, 9)

local lastSelected = 1
local textInput = configFrame:addInput():setBackground(colors.black):setForeground(colors.lightGray):setPosition(2, 10):setSize(6, 1):onChange(function(self, v)
    text = v=="" and " " or v
end):onGetFocus(function() lastSelected = 1 end)
local textInput2 = configFrame:addInput():setBackground(colors.black):setForeground(colors.lightGray):setPosition(9, 10):setSize(6, 1):onChange(function(self, v)
    text2 = v=="" and " " or v
end):onGetFocus(function() lastSelected = 2 end)

local colorsButtons = {
    ["0"] = configFrame:addButton():setPosition(2, 3):setBackground(colors.white):setSize(1,1):setText("1"),
    ["1"] = configFrame:addButton():setPosition(3, 3):setBackground(colors.orange):setSize(1,1):setText(" "),
    ["2"] = configFrame:addButton():setPosition(4, 3):setBackground(colors.magenta):setSize(1,1):setText(" "),
    ["3"] = configFrame:addButton():setPosition(5, 3):setBackground(colors.lightBlue):setSize(1,1):setText(" "),
    ["4"] = configFrame:addButton():setPosition(6, 3):setBackground(colors.yellow):setSize(1,1):setText(" "),
    ["5"] = configFrame:addButton():setPosition(7, 3):setBackground(colors.lime):setSize(1,1):setText(" "),
    ["6"] = configFrame:addButton():setPosition(8, 3):setBackground(colors.pink):setSize(1,1):setText(" "),
    ["7"] = configFrame:addButton():setPosition(9, 3):setBackground(colors.gray):setSize(1,1):setText(" "),
    ["8"] = configFrame:addButton():setPosition(2, 4):setBackground(colors.lightGray):setSize(1,1):setText(" "),
    ["9"] = configFrame:addButton():setPosition(3, 4):setBackground(colors.cyan):setSize(1,1):setText(" "),
    ["a"] = configFrame:addButton():setPosition(4, 4):setBackground(colors.purple):setSize(1,1):setText(" "),
    ["b"] = configFrame:addButton():setPosition(5, 4):setBackground(colors.blue):setSize(1,1):setText(" "),
    ["c"] = configFrame:addButton():setPosition(6, 4):setBackground(colors.brown):setSize(1,1):setText(" "),
    ["d"] = configFrame:addButton():setPosition(7, 4):setBackground(colors.green):setSize(1,1):setText(" "),
    ["e"] = configFrame:addButton():setPosition(8, 4):setBackground(colors.red):setSize(1,1):setText(" "),
    ["f"] = configFrame:addButton():setPosition(9, 4):setBackground(colors.black):setSize(1,1):setForeground(colors.white):setText("2"),
}


local function colorSetup(obj, color)
    obj:onClick(function(self, event, btn)
        if(btn==1)then
            if(secondColor == color)then return end
            mainColor = color
        elseif(btn==2)then
            if(mainColor == color)then return end
            secondColor = color
        end
        for k,v in pairs(colorsButtons)do
            if(k==mainColor)then
                v:setText("1")
            elseif(k==secondColor)then
                v:setText("2")
            else
                v:setText(" ")
            end
        end
        if(mode==3)then changeMode(1) end
    end)
end


for k,v in pairs(colorsButtons)do
    colorSetup(v, k)
end

local x,y = 1,1
local w = asciiFrame:getSize()
for i=1,255 do
    asciiFrame:addButton():setSize(1,1):setText(string.char(i)):setPosition(x,y):onClick(function(self, event, btn)
        if(btn==2)then
            if(lastSelected==1)then
                textInput:setValue(textInput:getValue()..string.char(i))
            else
                textInput2:setValue(textInput2:getValue()..string.char(i))
            end
        else
            if(lastSelected==1)then
                textInput:setValue(string.char(i))
            else
                textInput2:setValue(string.char(i))
            end
        end
        if(mode<3)then changeMode(3) end
    end)
    x = x + 1
    if(x>w)then
        x = 1
        y = y + 1
    end
end

main:onKey(function(self, event, key)
    if(key==keys.s)and(basalt.isKeyDown(keys.leftCtrl))then
        if(latestPath~=nil)and(latestPath~="")then
            saveBimg(latestPath)
        else
            subObjectShow(saveFileFrame)
            saveFileFrame:setFocus()
            if(saveFileInput~=nil)then saveFileInput:setValue("") end
        end
    end
    if(key==keys.t)and(basalt.isKeyDown(keys.leftCtrl))then
        if(configFrame:isVisible())then
            configHide()
        else
            configShow()
        end
    end
end)

basalt.autoUpdate()