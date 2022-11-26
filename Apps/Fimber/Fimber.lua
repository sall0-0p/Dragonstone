
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

-- creating Main Frame of an app.
local mainFrame = basalt.createFrame()

-- getting launch arguments
local args = { ... }

-- this value is directory the user is currently in. By default it is root directory of computer. Or the first argument of a launch command can be used.
local Directory = ":"

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

edit("/UwUntuCC/Apps/Fimber", "Fimber.lua")

-- This function shout be placed at the end of code, or inside of thread (coroutine).
basalt.autoUpdate()