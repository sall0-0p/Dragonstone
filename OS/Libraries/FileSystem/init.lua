local FileSystem = {}

local perm = require(".UwUntuCC.OS.Libraries.PermissionService")

local function checkPerms(path, file, success)
    success = true

    

    return success
end

FileSystem = {

    run = function(path, executable, argument, name)
        if checkPerms(path, executable) then
            os.queueEvent("run_program", path, executable, argument, name)
            return success
        end
    end,
    
    edit = function(path, file)
        if checkPerms(path, file) then
            os.queueEvent("run_program", "/UwUntuCC/Apps/Edit", "edit.lua", nil, "Editor")
            sleep(0.05)
            os.queueEvent("3210050775", path.."/"..file)
            return success
        end
    end,
    
    copy = function(path, file)
        if checkPerms(path, file) then
            fs.move(path.."/"..file, "/UwUntuCC/OS/Clipboard/"..file)
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
        local files = fs.list("/UwUntuCC/OS/Clipboard/")
        for i = 1, #files do
            fs.move(i, path.."/"..i)
            return success
        end
    end,

    rename = function(path, file, name)
        if checkPerms(path, file) then
            fs.move(path.."/"..file, "/UwUntuCC/OS/Clipboard/"..name)
            fs.move("/UwUntuCC/OS/Clipboard/"..name, path.."/"..name)
            return success
        end
    end,

    delete = function(path, file)
        if checkPerms(path, file) then
            fs.move(path.."/"..file, "/UwUntuCC/User/Bin/"..name)
        end
    end,
}

return FileSystem