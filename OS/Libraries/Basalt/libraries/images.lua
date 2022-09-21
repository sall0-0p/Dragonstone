local function loadNFP(path)
    return paintutils.loadImage(path), "nfp"
end

local function loadBIMG(path)
    local f = fs.open(path, "rb")
    local content = load("return "..f.readAll())()
    f.close()
    if(content~=nil)then
        return content, "bimg"
    end
end

local function loadImage(path, f)
    if(f==nil)then
        if(path:find(".bimg"))then
            return loadBIMG(path)
        elseif(path:find(".bbf"))then
            return loadBBF(path)
        else
            return loadNFP(path)
        end
    end
    -- ...
end

return {
    loadNFP = loadNFP,
    loadBIMG = loadBIMG,
    loadImage = loadImage,

}