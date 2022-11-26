local FileSystem = {}

local perm = require(".UwUntuCC.OS.Libraries.PermissionService")

perm.notifyFail()

local function checkPerms(path, file, success)
    success = true

    

    return success
end

FileSystem = {

    run = function(path, executable, argument, name)
        if checkPerms(path, executable) then
            os.queueEvent("run_program", path, executable, argument, name)
        end
    end
    
    edit = function(path, file)
        if checkPerms(path, file) then
            os.queueEvent("run_program", "/UwUntuCC/Apps/Edit", "edit.lua", nil, "Editor")
            sleep(0.05)
            os.queueEvent("3210050775", path.."/"..file)
            return success
        end
    end
    
    copy = function(path, file)
        
    end

    move = function(path, file, tPath)

    end

    paste = function(path)

    end

    rename = function(path, file, name)

    end

    delete = function(path, file)
    
    end
}