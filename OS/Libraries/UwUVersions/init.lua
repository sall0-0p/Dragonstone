local library = {}

library = {
    
    checkVersion = function()

        local request = http.get("https://raw.githubusercontent.com/sall0-0p/Dragonstone/master/OS/Version.md")
        if request == nil then
            os.queueEvent("notification", "Error", "Cannot connect to the server. Check your internet connection")
        else
            local serverVersion = request.readAll()
            request.close()
            
            if fs.exists(":/Dragonstone/OS/Version.md") then
                local file = fs.open("Dragonstone/OS/Version.md", "r")
                    version = file.readAll()
                    file.close()
            end

            

            if version ~= serverVersion then
                os.queueEvent("notification", serverVersion, "New Version is out! \n New features added and bugs are fixed \2")
            end
        end
    end,

    getVersion = function()
        
        local request = http.get("https://raw.githubusercontent.com/sall0-0p/Dragonstone/master/OS/Version.md")
            
        if request == nil then
            os.queueEvent("notification", "Error", "Cannot connect to the server. Check your internet connection")
        end

        local serverVersion = request.readAll()
        request.close()
        
        if fs.exists(":/Dragonstone/OS/Version.md") then
            local file = fs.open("Dragonstone/OS/Version.md", "r")
                version = file.readAll()
                file.close()
        end

        return version, serverVersion
    end





}

return library