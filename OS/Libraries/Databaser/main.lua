
-- Change this if you want to set custom directory for saving local Databases
local directory = "BucketOS/OS/Data/"

local databaser = {}

local function checkcolumn(name, columnName)
    if name == nil then
        error("You have to state database name")
    end
    
    if columnName == nil then
        error("You need to state name of column")
    end

    if not fs.exists(directory.."/"..name) then
        error("Such database do not exist")
    end

    if not fs.exists(directory.."/"..name.."/"..columnName..".json") then
        error("Such column do not exists! "..columnName)
    end
end

databaser = {

    setDir = function(path)
        directory = path
        local success = true
        return success
    end,

    createTable = function(name)
        if name == nil then
            error("You have to state database name")
        end

        if fs.exists(directory.."/"..name) then
            error("This database already exists")
        else
            fs.makeDir(directory.."/"..name)
        end
        local success = true
        return success
    end,

    deleteTable = function(name)
        if name == nil then
            error("You have to state database name")
        end

        if not fs.exists(directory.."/"..name) then
            error("Such database do not exist")
        end

        fs.delete(directory.."/"..name)
        local success = true
        return success
    end,

    -- TODO: Add ability to import already existing table after creationg of column
    addColumn = function(name, columnName)
        if name == nil then
            error("You have to state database name")
        end

        if columnName == nil then
            error("You have to state column name")
        end

        if not fs.exists(directory.."/"..name) then
            error("Such database do not exist")
        end


        local file = fs.open(directory.."/"..name.."/"..columnName..".json", "w")
        --file.writeLine("-- This is database")
        --file.close()
        file.close()
        local success = true
        return success
    end,

    deleteColumn = function (name, columnName)
        if name == nil then
            error("You have to state database name")
        end

        if columnName == nil then
            error("You have to state column name")
        end

        if not fs.exists(directory.."/"..name) then
            error("Such database do not exist")
        end

        if fs.exists(directory.."/"..name.."/"..columnName..".json") then
            fs.delete(directory.."/"..name.."/"..columnName..".json")
        end
        local success = true
        return success
    end,

    import = function(name, columnName, table)
        checkcolumn(name, columnName)

        local file = fs.open(directory.."/"..name.."/"..columnName..".json", "w")
        file.write(textutils.serialize(table))
        file.close()
        local success = true
        return success
    end,

    getColumn = function(name, columnName)
        checkcolumn(name, columnName)

        local file = fs.open(directory.."/"..name.."/"..columnName..".json", "r")
        local data = file.readAll()
        data = textutils.unserialize(data)
        file.close()

        local success = true
        return data, success
    end,

    getColumns = function(name)
        if name == nil then
            error("You have to state database name")
        end

        if not fs.exists(directory.."/"..name) then
            error("Such database do not exist")
        end

        local data = fs.list(directory.."/"..name)
        local success = true
        return data, success
    end,

    getTables = function()
        local data = fs.list(directory)
        local success = true
        return data, success
    end,

    getData = function(name, index)
        if name == nil then
            error("You have to state database name")
        end

        if not fs.exists(directory.."/"..name) then
            error("Such database do not exist")
        end

        local columns = fs.list(directory.."/"..name)
        local data = {}
        local n = 1
        for _, col in pairs(columns) do
            local file = fs.open(directory.."/"..name.."/"..columns[n], "r")
            local info = file.readAll()

            if file == nil then
                error("Column "..columns[n].." is empty or do not have data for this request.")
            end

            info = textutils.unserialize(info)
            table.insert(data, info[index])
            file.close()
            n = n+1
        end

        local success = true
        return data, success
        
    end,

    addValue = function(name, columnName, value, index)

        if index == nil then
            local file = fs.open(directory.."/"..name.."/"..columnName..".json", "r")
            local info = file.readAll()
            if info == nil then
                info = {}
                index = 0
            else
                info = textutils.unserialize(info)
                if info ~= nil then
                index = table.getn(info)
                else
                index = 0
                end
            end
            index = index + 1
            file.close()
        end

        local file = fs.open(directory.."/"..name.."/"..columnName..".json", "r")
        local info = file.readAll()
        info = textutils.unserialize(info)
        if info == nil then
            info = {

            }
        end
        file.close()
        table.insert(info, index, value)
        local file = fs.open(directory.."/"..name.."/"..columnName..".json", "w")
        file.write(textutils.serialize(info))
        file.close()
        local success = true
        return success
    end,
    
    setValue = function(name, columnName, value, index)
        local file = fs.open(directory.."/"..name.."/"..columnName..".json", "r")
        local info = file.readAll()
        info = textutils.unserialize(info)
        file.close()
        table.remove(info, index)
        table.insert(info, index, value)
        local file = fs.open(directory.."/"..name.."/"..columnName..".json", "w")
        info = file.write(textutils.serialize(info))
        file.write(info)
        file.close()
        local success = true
        return success
    end,

    removeValue = function(name, columnName, index)
        local file = fs.open(directory.."/"..name.."/"..columnName..".json", "r")
        local info = file.readAll()
        info = textutils.unserialize(info)
        file.close()
        table.remove(info, index)
        local file = fs.open(directory.."/"..name.."/"..columnName..".json", "w")
        info = file.write(textutils.serialize(info))
        file.write(info)
        file.close()
        local success = true
        return success
    end,

    search = function(name, columnName, value)
        local file = fs.open(directory.."/"..name.."/"..columnName..".json", "r")
        local info = file.readAll()
        info = textutils.unserialize(info)
        file.close()

        local n = 1
        for _, line in pairs(info) do

            if line == value then
                return n
            end
            n = n+1
        end
    end,

    clearTable = function(name)
        local columns = fs.list(directory.."/"..name)
        
        for _, object in pairs(columns) do
            local file = fs.open(directory.."/"..object, "w")
            file.write("{'bruh'}")
            file.close()
        end
    end,


}

return databaser
