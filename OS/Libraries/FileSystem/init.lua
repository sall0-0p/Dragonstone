local FileSystem = {}

local basalt = require(".Dragonstone.OS.Libraries.Basalt")
local perm = require(".Dragonstone.OS.Libraries.PermissionService")
local success

local function checkPerms(path, file, success)
    success = true

    

    return success
end

FileSystem = {

    run = function(path, executable, argument, name)
        if checkPerms(path, executable) then
            os.queueEvent("run_program", path, executable, argument, name)
            
            local program = win.create()
                :setSize(51,19)
                :setBar(name)
                :run(path.."/"..executable)
            return success
        end
    end,
    
    edit = function(path)
        if checkPerms(path, file) then
            basalt.debug(path)
            local win = require(".Dragonstone.OS.Libraries.windowingSystem")
            --os.queueEvent("run_program", "/Dragonstone/OS/SystemApps/Edit", "edit.lua", nil, "Editor")
        
            --local programEdit = win.create()
                --:setSize(51,19)
                --:setBar("Editor")
                --:run("/Dragonstone/OS/SystemApps/Edit/edit.lua")
            --sleep(0.1)
            --os.queueEvent("3210050775", path)
            return success
        end
    end,
    
    copy = function(path, file)
        if checkPerms(path, file) then
            fs.move(path.."/"..file, "/Dragonstone/OS/Clipboard/"..file)
            return success
        end
    end,

    move = function(path, file, tPath)
        if checkPerms(path, file) then
            fs.move(path.."/"..file, tPath.."/"..file)
            return success
        end
    end,

    paste = function(path)
        local files = fs.list("/Dragonstone/OS/Clipboard/")
        for i = 1, #files do
            fs.move(i, path.."/"..i)
            return success
        end
    end,

    rename = function(path, file, name)
        if checkPerms(path, file) then
            fs.move(path.."/"..file, "/Dragonstone/OS/Clipboard/"..name)
            fs.move("/Dragonstone/OS/Clipboard/"..name, path.."/"..name)
            return success
        end
    end,

    delete = function(path, file)
        if checkPerms(path, file) then
            fs.move(path.."/"..file, "/Dragonstone/User/Bin/"..name)
        end
    end,
}

return FileSystem