if fs.exists("/Basalt") == false then

    local githubPath = "https://raw.githubusercontent.com/sall0-0p/UwUntuCC/"
    local treePath = "https://api.github.com/repos/sall0-0p/UwUntuCC/git/trees"
    
    local function createUwuntuTree(page, branch, dirName)
        dirName = dirName or ""
        local tree = {}
        local request, err = http.get(page, _G._GIT_API_KEY and {Authorization = "token ".._G._GIT_API_KEY})
        print("Creating file tree for "..(dirName~="" and "root/"..dirName or "root"))
        if(request==nil)then error("API rate limit exceeded. It will be available again in one hour.") end
        for _,v in pairs(textutils.unserialiseJSON(request.readAll()).tree)do
            if(v.type=="blob")then
                table.insert(tree, {name = v.path, path=fs.combine(dirName, v.path), url=githubPath..(branch or "master")..fs.combine(dirName, v.path), size=v.size})
            elseif(v.type=="tree")then
                tree[v.path] = createUwuntuTree(v.url, (branch or "master"), fs.combine(dirName, v.path))
            end
        end
        return tree
    end
    
    --local tree = createUwuntuTree(treePath.."/master", "master")
    
    --for k,v in pairs(tree)do
        --print(k, v)
    --end

local function splitString(str, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for v in string.gmatch(str, "([^"..sep.."]+)") do
            table.insert(t, v)
    end
    return t
end

local function download(url, file)
    print("Downloading "..url)
    local httpReq = http.get(url, _G._GIT_API_KEY and {Authorization = "token ".._G._GIT_API_KEY})
        if(httpReq~=nil)then
        local content = httpReq.readAll()
        if not content then
            error("Could not connect to website")
        end
        local f = fs.open(file, "w")
        f.write(content)
        f.close()
    end
end

local function downloadBasalt(dir, ignoreList, link)
    local projTree = createTree("https://api.github.com/repos/Pyroxenium/Basalt/git/trees/master:Basalt")
    local projectFiles = {base={}}

    local function isFileInIgnoreList(folder, file)
        if(ignoreList~=nil)then
            if(ignoreList[folder]~=nil)then
                for k,v in pairs(ignoreList[folder])do
                    if(v==file)then
                        return true
                    end
                end
            end
        end
        return false
    end
    for k,v in pairs(projTree)do
        if(k=="objects")then
            projectFiles.objects = {}
            for a,b in pairs(v)do
                if not(isFileInIgnoreList("objects", b))then
                    table.insert(projectFiles.objects, b)
                end
            end
        elseif(k=="libraries")then
            projectFiles.libraries = {}
            for a,b in pairs(v)do
                if not(isFileInIgnoreList("libraries", b))then
                    table.insert(projectFiles.libraries, b)
                end
            end
        else
            table.insert(projectFiles.base, v)
        end
    end

    
    for _,v in pairs(projectFiles["objects"])do
        download("https://raw.githubusercontent.com/Pyroxenium/Basalt/master/Basalt/objects/"..v, dir.."/objects/"..v)
    end
    for _,v in pairs(projectFiles["libraries"])do
        download("https://raw.githubusercontent.com/Pyroxenium/Basalt/master/Basalt/libraries/"..v, dir.."/libraries/"..v)
    end
    for _,v in pairs(projectFiles["base"])do
        download("https://raw.githubusercontent.com/Pyroxenium/Basalt/master/Basalt/"..v, dir.."/"..v)
    end
end

downloadBasalt("Basalt")

end

basalt = require(".Basalt")

local mainFrame = basalt.createFrame()

local rw, rh = mainFrame:getSize()
    
--[[if rw < 70 or rh < 25 then]]
    smallscreenwarning = [[
        Your screen is too small! 
        Your current resolution is ]]..rw.."x"..rh..[[ px.
        If you want to use UwU change your resolution,
        minimum resolution is 70x25.
        You can do this is world configs or in CraftOS-PC configs.
        ---------------
        Ctrl+T to exit.
    ]]
    --[[ocal SmallResolutionFrame = mainFrame:addFrame()
        :setSize(rw,rh)
        :setBackground(colors.lightGray)
            
            SmallResolutionFrame:addLabel()
                :setText("Warning!")
                :setFontSize(2)
                :setPosition(5,5)

            SmallResolutionFrame:addLabel()
                :setPosition(6,8)
                :setSize(rw-"8", 10)
                :setText(smallscreenwarning)

end]]

local licenseScreen = mainFrame:addFrame()
    :setSize(rw.."-10", rh.."-11")
    :setPosition(6,6)
    :setBackground(colors.gray)

    --[[local request = http.get("https://raw.githubusercontent.com/sall0-0p/UwUntuCC/master/LICENSE")
    local License = request.readAll()
    request.close()]]

    License = [[
        Copyright 2022 UwUntuCC 
        -------------------
        Permission is hereby granted, free of charge, 
        to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
        The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
        -------------------
        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.]]

    licenseScreen:addLabel()
        :setText("Welcome to UwUntu")
        :setFontSize(2)
        :setPosition(5,5)
        :setBackground(colors.gray)
        :setForeground(colors.white)
    
        licenseScreen:addLabel()
            :setText("You can ignore that, Its just MIT license")
            :setPosition(6,7)
            :setBackground(colors.gray)
            :setForeground(colors.lightGray)
    
        licenseScreen:addFrame()
            :setPosition(5,9)
            :setSize(rw.."-20", rh.."-24")
            :setBackground(colors.lightGray)
            
            :setForeground(colors.black)

            :addLabel()
                :setPosition(2,2)
                :setText(License)
                :setSize(rw.."-23", rh.."-26")

        local LicenseCheckBox = licenseScreen:addCheckbox()
                :setPosition(6, rh.."-14")
                :setBackground(colors.white)

        licenseScreen:addLabel() 
                :setPosition(8, rh.."-14")
                :setForeground(colors.white)
                :setText("I agree with Terms & Conditions")

        local NextButton = licenseScreen:addButton()
                :setPosition(rw.."-29", rh.."-14")
                :setText("Install")
                :setSize(13,3)
                :setBackground(colors.lightGray)
                :setForeground(colors.lightGray)
                :disable()

        local MemeCheckbox = licenseScreen:addCheckbox():setValue(true)
                :setPosition(6, rh.."-12")
                :setBackground(colors.white)

            licenseScreen:addLabel() 
                :setPosition(8, rh.."-12")
                :setForeground(colors.white)
                :setText("I don`t want to use LevelOS")

        LicenseCheckBox:onChange(function() 
            if LicenseCheckBox:getValue() then
                NextButton:setForeground(colors.black)
                NextButton:setBorder(colors.black)
                NextButton:setPosition(rw.."-28", rh.."-13")
                NextButton:setSize(11,1)
                NextButton:enable()
            else
                NextButton:setForeground(colors.lightGray)
                NextButton:setBorder(false)
                NextButton:setPosition(rw.."-29", rh.."-14")
                NextButton:setSize(13,3)
                NextButton:disable()
            end
        end)

        MemeCheckbox:onChange(function()
            _G._G = nil
        end)

NextButton:onClick(function()
    local Sstartup = [[if fs.exists("/UwUntuCC") == false then
        print("Print")
        fs.makeDir("/UwUntuCC")
        fs.move("/OS", "/UwUntuCC/OS")
        fs.move("/Apps", "/UwUntuCC/Apps")
        fs.makeDir("/UwUntuCC/AppData")
        fs.makeDir("/UwUntuCC/User")
        fs.makeDir("/UwUntuCC/User/Downloads")
        fs.makeDir("/UwUntuCC/User/Desktop")
        fs.makeDir("/UwUntuCC/User/Bin")
        fs.makeDir("/UwUntuCC/User/")
        fs.makeDir("/UwUntuCC/User/Documents")
    end
    
    local basalt = require(".UwUntuCC.OS.Libraries.Basalt")
    
    local mainFrame = basalt.createFrame()
        :setBackground(colors.black)
        
    
    
    
    local RunBucketOS = function()
        sleep(2)
        basalt.removeFrame(mainFrame)
        shell.setDir("/UwUntuCC/OS/SystemApps/Desktop/")
        shell.run("Desktop.lua")
    end
    
    parallel.waitForAll(basalt.autoUpdate(), RunBucketOS)
    
    ]]
       
    local f = fs.open("startup.lua", "w")
    f.write(Sstartup)
    f.close()

    os.reboot()
    
end)
basalt.autoUpdate()

