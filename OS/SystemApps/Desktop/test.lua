local basalt = require(".UwUntuCC.OS.Libraries.Basalt")

local main = basalt.createFrame()

local sub = main:addFrame():setSize(30,12):setMovable()
sub:addLabel():setText("Example Frame"):setSize("parent.w", 1):setBackground(colors.black):setForeground(colors.lightGray)




local dragButton = sub:addButton()
  :setAnchor("bottomRight")
  :setPosition(1,1)
  :setSize(1,1)
  :setText("/")
  :onDrag(function(self, event, button, x, y, xOffset, yOffset)
      sub:setSize(-xOffset, -yOffset, true)
      basalt.debug(xOffset)
  end)

basalt.autoUpdate()