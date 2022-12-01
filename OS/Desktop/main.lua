local basalt = require(".UwUntuCC.OS.Libraries.Basalt")

local mainFrame = basalt.createFrame()

for _, v in pairs(fs.list("UwUntuCC/OS/Desktop/plugins")) do

    local newPlugin = require(".UwUntuCC.OS.Desktop.plugins."..v:gsub(".lua", ""))
    newPlugin(mainFrame)
end

basalt.autoUpdate()