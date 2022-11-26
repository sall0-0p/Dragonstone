local service = {}
local db = require(".UwUntuCC.OS.Libraries.Databaser")

db.setDir("UwUntuCC/OS/Libraries/ExtensionsService/DB/")

service = {

    get = function(extension)
        local id = db.search("Extensions", "Extension", extension)

        local data = db.getColumn("Extensions", "Naming")

        if data[id] == nil then
            return "Undefined"
        else
            return data[id]
        end
    end
}

return service