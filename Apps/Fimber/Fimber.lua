
--___          _    
--| _ ) __ _ __(_)__ 
--| _ \/ _` (_-< / _|
--|___/\__,_/__/_\__| 

-- This is file management App. You can use it :D
-- It based on Basalt Library (all OS based on it) and other self-made libs that could be found in "/UwUntuCC/OS/Libraries", also I recommend you installing your libraries there too.
-- Basalt wiki: https://basalt.madefor.cc/#/objects/Object
-- Basalt github: https://github.com/Pyroxenium/Basalt

local basalt = require(".UwUntuCC.OS.Libraries.Basalt") -- importing Basalt file into our document.
local databaser = require(".UwUntuCC.OS.Libraries.Databaser") -- importing database management API that included with UwUntu.
local fss = require(".UwUntuCC.OS.Libraries.FileSystem")

-- getting platform where user launches UwU
local Host = _HOST

-- creating Main Frame of an app.
local mainFrame = basalt.createFrame()

-- getting launch arguments
local args = { ... }

-- this value is directory the user is currently in. By default it is root directory of computer. Or the first argument of a launch command can be used.
local Directory = ":/UwUntuCC"

if args[1] ~= nil then
    Directory = args[1]
end

-- "Path" is shown on top of the UI and is quite good value to use in future. You will get something like this:
-- "/UwUntuCC/Apps/Finder"
local Path = "/"..fs.getName(fs.getDir(Directory)).."/"..fs.getName(Directory)

-- This values are config. They will be needed in future.

local debug = true
local redstonePerms = false --! THIS SETTINGS REMOVES RESTRICIONS (LIKE EDITING OR CHANGINS SOME "OS" FILES.) !!!USE ON YOUR OWN RISK!!!
local showHidden = true 

-- This function will be needed later.
local loadList

--___             _   _             
--| __|  _ _ _  __| |_(_)___ _ _  ___
--| _| || | ' \/ _|  _| / _ \ ' \(_-<
--|_| \_,_|_||_\__|\__|_\___/_||_/__/
                                   
-- Double Click function. I dont really understand how it works. Its not mine.

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

-- Now file changing functions will come. They are quite simple anyways. Also most of FileSystem manipulations are contained in separate API. It not accessible for users :<

local function open(path)
    Directory = path
    Path = "/"..fs.getName(fs.getDir(Directory)).."/"..fs.getName(Directory)

    loadList()
end


--_   _ ___   _ _           _  __ 
--| | | |_ _| (_) |_ ___ ___| |/ _|
--| |_| || |  | |  _(_-</ -_) |  _|
-- \___/|___| |_|\__/__/\___|_|_|  
                                 
-- Hello There.
    -- rw - width of the window
    -- rh - height of the window
local rw, rh = mainFrame:getSize()


-- This is footer :D

local footer = mainFrame:addFrame()
    :setSize(rw, 2)
    :setPosition(1,1)
    :setBackground(colors.gray)


    -- This is another border. As you see Im adding some panels with symbols. Try changing some of the colors and you will see the UI changing after restart.
    local footerPane1 = footer:addFrame()
        :setSize(rw.."-14",1)
        :setPosition(15,2)
        :setBackground(colors.lightGray, "\131", colors.gray)
    local footerPane2 = footer:addFrame()
        :setSize(1, 2)
        :setPosition(14,1)
        :setBackground(colors.gray, "\149", colors.black)

        -- This search bar uses Input object.
        local searchBar = footer:addInput()
            :setSize(11, 1)
            :setPosition(rw.."-10", 1)
            :setBackground(colors.black)
            :setForeground(colors.white)
            :setDefaultText(" ", colors.lightGray, colors.black)
        
            local searhBarBorder = footer:addFrame()
                :setSize(1, 1)
                :setPosition(rw.."-11", 1)
                :setBackground(colors.black, "\149", colors.gray)

        local menuButton = footer:addButton()
            :setSize(1,1)
            :setPosition(rw.."-12", 1)
            :setBackground(colors.gray)
            :setForeground(colors.lightGray)
            :setText("=")

        local tagsButton = footer:addButton()
            :setSize(1,1)
            :setPosition(rw.."-14", 1)
            :setBackground(colors.gray)
            :setForeground(colors.lightGray)
            :setText("\4")

        local cloudButton = footer:addButton()
            :setSize(1,1)
            :setPosition(rw.."-16", 1)
            :setBackground(colors.gray)
            :setForeground(colors.lightGray)
            :setText("\24")
        
        local sortingButton = footer:addButton()
            :setSize(1,1)
            :setPosition(rw.."-18", 1)
            :setBackground(colors.gray)
            :setForeground(colors.lightGray)
            :setText("\31")

        local typeButton = footer:addButton()
            :setSize(1,1)
            :setPosition(rw.."-21", 1)
            :setBackground(colors.gray)
            :setForeground(colors.lightGray)
            :setText("\182")

        local undoButton = footer:addButton()
            :setSize(1,1)
            :setPosition(rw.."-35", 1)
            :setBackground(colors.gray)
            :setForeground(colors.lightGray)
            :setText("\171")
        
        local folderTitle = footer:addLabel()
            :setSize(11,1)
            :setPosition(rw.."-33")
            :setBackground(colors.gray)
            :setForeground(colors.lightGray)
            :setText(fs.getName(Directory))
            
        
        






-- Here Im creating panel located at side of an app. And adding some borders by using special symbols.
-- Every function and method here coming from Basalt Docs.

local sidePanel = mainFrame:addFrame()
    :setSize(14, rh)
    :setPosition(1,1)
    :setBackground(colors.gray)

    local sidePane = sidePanel:addFrame()
        :setSize(1,rh)
        :setPosition(14,1)
        :setBackground(colors.black, "\149", colors.gray)
    




-- Making some onFocus event code.

    mainFrame:onEvent(function(self, event, arg1, arg2, arg3) 
    
        if event == "gained_focus" then
            folderTitle:setForeground(colors.white)
            searchBar:setDefaultText("Search", colors.lightGray, colors.black)
        end
    
        if event == "losed_focus" then
            folderTitle:setForeground(colors.lightGray)
            searchBar:setDefaultText(" ", colors.lightGray, colors.black)
        end
    
    end)

    


    -- This function shout be placed at the end of code, or inside of thread (coroutine).
-- It makes your workspace update after some changes automatically. In fact this is automatical render of your program and UI.
basalt.autoUpdate()