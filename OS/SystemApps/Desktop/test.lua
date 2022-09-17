local basalt = require(".UwUntuCC.OS.Libraries.Basalt")

local main = basalt.createFrame("firstBaseFrame")
local main2 = basalt.createFrame("secondBaseFrame"):hide():setBackground(colors.black)
main:addButton()
  :setText("Show")
  :onClick(function()
      local frame2 = basalt.getFrame("secondBaseFrame")
      if(frame2~=nil)then
            basalt.debug("DEBUGGGGGss")
            frame2:show()
      end
  end)

  basalt.autoUpdate()