local basalt = require(".UwUntuCC.OS.Libraries.Basalt")

local mainFrame = basalt.createFrame()

local path = "UwUntuCC/OS/Desktop/"

local args = { ... }

local plugins = {}

local dir = args[2] or path
for _,v in pairs(fs.list(fs.combine(dir, "plugins")))do
    local newPlugin = require(v:gsub(".lua", ""))
    if(type(newPlugin)=="function")then
        plugins[v] = newPlugin
    end
end
for _,v in pairs(plugins)do
    v(mainFrame)
end

basalt.autoUpdate()


--[[
return function(mainFrame)
    main:addLabel():setText("Hello World")
    main:addButton():setPosition(3,3):setText("Click me")
end
]]