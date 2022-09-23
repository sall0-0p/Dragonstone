local library = {}

library = {
    
    checkVersion = function()

        local request = http.get("https://raw.githubusercontent.com/sall0-0p/UwUntuCC/master/OS/Version.md")
            
        local serverVersion = request.readAll()
        request.close()

        if fs.exists(":/UwUntuCC/OS/Version.md") then
            local file = fs.open("UwUntuCC/OS/Version.md", "r")
                version = file.readAll()
                file.close()
        end

        

        if version ~= serverVersion then
            os.queueEvent("notification", serverVersion, "New Version is out! \n New features added and bugs are fixed \2")
        end
    end,

    getVersion = function()

        local request = http.get("https://raw.githubusercontent.com/sall0-0p/UwUntuCC/master/OS/Version.md")
            
        local serverVersion = request.readAll()
        request.close()
        
        if fs.exists(":/UwUntuCC/OS/Version.md") then
            local file = fs.open("UwUntuCC/OS/Version.md", "r")
                version = file.readAll()
                file.close()
        end

        return version, serverVersion
    end





}

return library