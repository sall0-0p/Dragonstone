local Object = require("Object")
local xmlValue = require("utils").getValueFromXML
local images = require("images")

local unpack = table.unpack
return function(name)
    -- Image
    local base = Object(name)
    local objectType = "Image"
    base:setZIndex(2)
    local image
    local format = "nfp"

    local object = {
        init = function(self)
            self.bgColor = self.parent:getTheme("ImageBG")
        end,
        getType = function(self)
            return objectType
        end;

        loadImage = function(self, path, f)
            image, _format = images.loadImage(path, f)
            if(_format~=nil)then
                format = _format
            end
            self:updateDraw()
            return self
        end;

        setImage = function(self, data, _format)
            iamge = data
            format = _format
        end,

        getImageData = function(self)
            return image
        end,

        setValuesByXMLData = function(self, data)
            base.setValuesByXMLData(self, data)
            if(xmlValue("path", data)~=nil)then self:loadImage(xmlValue("path", data)) end
            return self
        end,

        draw = function(self)
            if (base.draw(self)) then
                if (image ~= nil) then
                    local obx, oby = self:getAnchorPosition()
                    local w,h = self:getSize()
                    if(format=="nfp")then
                        
                    elseif(format=="bimg")then
                        for y,v in ipairs(image[1])do
                            self.parent:blit(obx, oby+y-1, unpack(v))
                            
                        end
                    end
                end
            end
        end,
    }

    return setmetatable(object, base)
end