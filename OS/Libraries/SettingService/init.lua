
local directory = "/UwUntuCC/OS/Data"

local settingsSrv = {}

local file

if not fs.exists(directory.."/SystemSettings.json") then
    file = fs.open(directory.."/SystemSettings.json", "w")
    file.close
end

settingsSrv = {
    
    createSetting = function(name, default) -- creates new setting ("name", [Default])
        
    end

    deleteSetting = function(name) -- deletes setting (name)

    end

    setValue = function(name, value) -- sets Value (name, [Value])

    end

    setDefault = function(name, default) -- sets Default for setting

    end

    checkValue = function(name) -- returns Value (name)

    end

    resetValue = function(name) -- resets Value to default (name)
    
    end

    resetAll = function() -- resets everything

    end
}

return settingsSrv