local imager

imager = {
    drawImage = function(img, x, y, frame)
    -- expect(1, img, "table")
    --  expect(2, x, "number")
    --  expect(3, y, "number")
    --  expect(4, frame, "number", "nil")
    
      frame = frame or 1
      if not img[frame] then
        return nil, "invalid frame index " .. frame
      end
    
      if img.palette then
        for k, v in pairs(img.palette) do
          term.setPaletteColor(2^k, table.unpack(v))
        end
      end
    
      if img[frame].palette then
        for k, v in pairs(img[frame].palette) do
          term.setPaletteColor(k, table.unpack(v))
        end
      end
    
      for i, line in ipairs(img[frame]) do
        term.setCursorPos(x+i-1, y)
        term.blit(table.unpack(line))
      end
    
      return true
    end
    
    -- * Example Usage.
    --  h = fs.open("/lisa.bimg", "r")
    --  f = h.readAll()
    --  h.close()
    --  t = textutils.unserialise(f)
    --  drawImage(t,51,19,1)}

    -- * Credits
    --  Thanks to Ocawesome101 and sashafiesta for this program
}
return imager